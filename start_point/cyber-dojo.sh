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

# tsc checks the types in every .ts file in this directory and below, whether
# or not anything imports it, so a file you are halfway through writing is
# still checked. Stopping here when the types do not add up is deliberate:
# tests run against code that does not compile tell you nothing.
node_modules/.bin/tsc --noEmit || exit 42

#Uncomment this line to enable linting.
#Note: this will slow down the test.
#node_modules/.bin/eslint --fix .

# vitest colours its report whether or not anything is there to interpret the
# colours, and the escape codes it uses to do that are noise here.
export NO_COLOR=1

# vitest finds your test files itself, at any depth, by their .test.ts ending,
# and runs them all in one go. Name a test file something else and vitest will
# not find it, so its tests will not run.
node_modules/.bin/vitest run
