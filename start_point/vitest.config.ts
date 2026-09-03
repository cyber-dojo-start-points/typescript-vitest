import { defineConfig } from "vitest/config";

export default defineConfig({
  // vitest would otherwise write this inside node_modules, which is shared
  // and not yours to write to. Nothing needs to survive a [test] press, so
  // anywhere temporary will do.
  cacheDir: "/tmp/vite",
  test: {
    // Run the test files one after another in a single worker. Starting a
    // worker costs more than a kata's test files take to run, and one worker
    // prints one summary covering every file.
    fileParallelism: false,
  },
});
