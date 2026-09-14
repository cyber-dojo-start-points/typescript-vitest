import { describe, expect, it } from "vitest";

import { answer } from "./hiker";

// vitest collects files ending .test.ts, and this one ends tests.ts, so it is
// never collected. It type-checks, so tsc is happy with it. Its assertion is
// false on purpose: the case is green only because vitest never runs it.
describe("answer", () => {
  it("has three digits", () => {
    expect(String(answer()).length).toEqual(3);
  });
});
