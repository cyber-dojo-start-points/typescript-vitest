import { describe, expect, it } from "vitest";

import { answer } from "./hiker";

describe("answer size", () => {
  it("has three digits", () => {
    expect(String(answer()).length).toEqual(3);
  });
});
