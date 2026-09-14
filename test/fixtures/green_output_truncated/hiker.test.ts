import { describe, expect, it } from "vitest";

import { answer } from "./hiker";

// node's globals are not on tsc's path here, so process has to be declared
// before it can be used. See amber_debug_output_needs_node_types.
declare const process: { stdout: { write(text: string): void } };

describe("answer", () => {
  it("to life the universe and everything", () => {
    // vitest writes its whole report to stdout, and these lines land on that
    // same stream ahead of it. Flooding past the runner's per-stream cap
    // therefore cuts off the file line and the summary that follow.
    for (let i = 0; i !== 4000; i += 1) {
      process.stdout.write("debug: i is " + i + ", total is " + i * 2 + "\n");
    }
    expect(answer()).toEqual(42);
  });
});
