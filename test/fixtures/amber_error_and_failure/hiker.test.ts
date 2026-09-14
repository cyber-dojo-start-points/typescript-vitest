import { describe, expect, it } from "vitest";

import { answer } from "./hiker";

// One test fails its expectation and the other throws. A single unrecognised
// exception is enough to make the whole run amber, so the failing test's red
// is not what the colour rests on: see amber_1_error.
describe("answer", () => {
  it("to life the universe and everything", () => {
    expect(answer()).toEqual(42);
  });

  it("has two digits", () => {
    // digits[0] is undefined at run time, so this throws rather than failing
    // an expectation. tsc types it as string and accepts the line.
    const digits: string[] = [];
    expect(digits[0].length).toEqual(2);
  });
});
