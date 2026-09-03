# vitest, like most test frameworks, exits 1 for a failing test and for a
# test that never ran, so those two are told apart from stdout/stderr. The
# statuses that do carry information are 0, which vitest sets only when it
# ran tests and they all passed, and 42, which cyber-dojo.sh returns when tsc
# rejects the code before vitest starts.
#
# An assertion failure is a test failing, which is red. Anything else that
# stops a test is amber: a raised exception, code that will not type-check,
# a test file with no tests in it.
#
# vitest names whatever stopped each failing test on a line of its own, so
# the exceptions are named by the framework rather than listed here. Only
# AssertionError has to be known, which keeps a newly met exception amber
# instead of silently red.

lambda { |stdout,stderr,status|
  output = stdout + stderr

  return :green if status === 0
  return :amber if status === 42

  # Nothing was collected, so nothing was proved either way.
  return :amber if /^\s*Tests\s+no tests/.match(output)

  if /^\s*Tests\s+\d+ failed/.match(output)
    exceptions = output.scan(/^(\w*Error): /).flatten
    return :amber if exceptions.any? { |name| name != 'AssertionError' }
    return :red
  end

  :amber
}
