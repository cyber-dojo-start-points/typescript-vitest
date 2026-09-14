import { describe, expect, it } from "vitest";

import { answer } from "./hiker";

describe("answer size", () => {
  it("has two digits", () => {
    expect(String(answer()).length).toEqual(2);
  });
});
