---
name: coding-principles
description: "Foundational coding rules for implementation and refactoring. Apply to code changes; do not load as a separate review procedure unless the task also asks to implement or refactor. Covers readability, complexity, error handling, naming, and pragmatic simplicity."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# Coding Principles

Apply these defaults when writing or changing code. Follow existing project conventions where they are sound; project requirements and correctness take precedence over style preferences.

## Defaults

- **Solve the actual problem.** Prefer the smallest complete change. Do not add speculative abstractions, configuration, layers, or flexibility without a concrete need.
- **Make intent obvious.** Use descriptive names, small cohesive functions, explicit control flow, and consistent formatting. Keep short names only in tiny, obvious scopes.
- **Keep responsibilities cohesive.** Split code when it has distinct reasons to change or becomes hard to understand—not because it crossed an arbitrary line or argument count.
- **Keep related code local.** Put helpers, types, and constants near their use unless reuse, ownership, or module boundaries justify a separate location.
- **Handle failures deliberately.** Do not silently swallow errors. Propagate, translate, recover, or report them according to the caller's responsibility.
- **Avoid dead weight.** Remove unused code, imports, commented-out implementations, and unnecessary wrappers. Do not duplicate an abstraction merely to avoid a small amount of repetition; repeated logic is worth extracting when the concepts truly match.
- **Separate configuration from behavior** when values vary by environment, feature, or deployment. A local constant does not need a config file merely to avoid a literal.
- **Optimize with evidence.** Notice obvious complexity problems (for example, repeated linear lookup inside a large loop), but benchmark or profile before making non-obvious performance trade-offs.

## Design heuristics

- Apply SOLID, encapsulation, composition, high cohesion, and low coupling when they improve changeability. They are diagnostic tools, not a checklist that requires a class or interface for every concept.
- Prefer composition over deep inheritance. Use interfaces at real boundaries or when substitutability matters, not solely to satisfy a pattern.
- A function with many parameters is a signal to inspect the API, not an automatic reason to wrap them in an options object.
- Comments should explain a non-obvious reason, constraint, or trade-off—not restate the code.
- Avoid hidden side effects and names that promise less than a function actually does.

## Architecture boundary

Use `architecture-patterns` when choosing layers, module boundaries, dependency direction, or a structural pattern. Do not impose Clean Architecture on every project: use the simplest structure that keeps the current change understandable and maintainable.

## Quick check

Before finishing, review correctness, naming, unnecessary complexity, error paths, accidental expensive loops, repository consistency, and unused code. **Batch verification:** do not run typecheck, lint, tests, or builds after every line edit or tool action. First complete a coherent set of related edits, then run the narrowest relevant checks once at a useful checkpoint. Re-run only after a fix that could affect the result, and perform appropriate final verification before reporting completion. For a tiny or low-risk change, avoid redundant checks; use judgment based on risk and repository conventions. Report checks that were run or could not be run.
