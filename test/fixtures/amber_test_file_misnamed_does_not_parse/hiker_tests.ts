import { describe, expect, it } from "vitest";

import { answer } from "./hiker";

// vitest never collects this name, but tsconfig.json names no include list, so
// tsc takes every .ts file under the sandbox and this one is parsed all the
// same. cyber-dojo.sh stops at tsc, and vitest is never reached.
describe("answer", () => {
  it("has three digits", () => {
    expect(String(answer()).length).toEqual(???);
  });
});
