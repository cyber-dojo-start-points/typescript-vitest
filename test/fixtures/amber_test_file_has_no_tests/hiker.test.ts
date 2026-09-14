import { describe } from "vitest";

// The file parses and type-checks, and vitest collects it, but the describe
// block holds no it() so nothing is there to pass or fail.
describe("answer", () => {});
