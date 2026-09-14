import { describe, expect, it } from "vitest";

import { checksum } from "./checksum";
import { answer } from "./hiker";

describe("answer", () => {
  it("to life the universe and everything", () => {
    expect(answer()).toEqual(42);
  });

  it("has a two character checksum", () => {
    expect(checksum(String(answer()))).toEqual(2);
  });
});
