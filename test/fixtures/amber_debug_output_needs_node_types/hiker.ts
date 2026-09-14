// node's globals are not on tsc's path here. tsconfig.json names no "types"
// list, so tsc looks for a node_modules/@types beside this file, and the
// node_modules beside this file is a symlink to where the packages really
// live, which it does not follow. So printing debug output the obvious way
// stops at tsc, and the tests never run.
export function answer(): number {
  process.stderr.write("answer was called\n");
  return 6 * 7;
}
