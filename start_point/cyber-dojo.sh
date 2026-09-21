# vitest and tsc live in /etc/ts/ rather than alongside your files, and node
# only looks for node_modules next to the code importing from it, so link it
# in here for the duration of this run.
ln -s /etc/ts/node_modules ${CYBER_DOJO_SANDBOX}/node_modules

function cyber_dojo_exit()
{
  # Ensure the symlink is removed.
  unlink ${CYBER_DOJO_SANDBOX}/node_modules
}
trap cyber_dojo_exit EXIT SIGTERM

# The commands below are the ones package.json names, called directly.
# Calling [npm run ...] is sloooow so don't do that.

# tsc reads your code and vitest runs it, so neither needs the other to have
# finished and they start together. Each is a fresh node process, which is
# most of what they cost.
# HELD is on /tmp, which the exit trap never walks, so nothing here comes back
# as a file.
readonly HELD=$(mktemp -d)

# vitest colours its report whether or not anything is there to interpret the
# colours, and the escape codes it uses to do that are noise here.
export NO_COLOR=1

# tsc checks the types in every .ts file in this directory and below, whether
# or not anything imports it, so a file you are halfway through writing is
# still checked.
# Each tool's two streams are held apart. The traffic-light lambda is handed
# stdout and stderr separately, so a byte that moved from one to the other
# could change the colour.
node_modules/.bin/tsc --noEmit > ${HELD}/tsc 2> ${HELD}/tsc.err &
readonly TSC_PID=$!

#Uncomment this line to enable linting.
#Note: this will slow down the test.
#node_modules/.bin/eslint --fix .

# vitest finds your test files itself, at any depth, by their .test.ts ending,
# and runs them all in one go. Name a test file something else and vitest will
# not find it, so its tests will not run.
node_modules/.bin/vitest run > ${HELD}/tests 2> ${HELD}/tests.err &
readonly TESTS_PID=$!

# Types that do not add up still end the run here, before any test output,
# because tests run against code that does not compile tell you nothing.
# vitest is left unwaited for: this script is the container's last word, so
# exiting abandons it.
wait ${TSC_PID} || TSC_FAILED=1
cat ${HELD}/tsc
cat ${HELD}/tsc.err >&2
if [ -n "${TSC_FAILED:-}" ]; then
  exit 42
fi

wait ${TESTS_PID} || TESTS_STATUS=$?
cat ${HELD}/tests
cat ${HELD}/tests.err >&2
exit ${TESTS_STATUS:-0}
