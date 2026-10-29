---
name: coding-principles
description: "Foundational rules for implementation and refactoring. Apply to code changes; do not load as a separate review procedure unless implementation/refactoring is requested. Covers readability, complexity, error handling, naming, pragmatic simplicity, and batched verification."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.2
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

Before finishing, review correctness, naming, unnecessary complexity, error paths, repository consistency, and unused code.

## Work in batches — important

- **Editing is not a verification checkpoint.** Do not run, suggest, or ask the user to run `typecheck`, tests, lint, or build after each file edit, line edit, patch, or tool call.
- First inspect the relevant code, make the full set of logically related changes, and review the diff. Then choose the smallest useful verification step.
- For an ordinary low-risk change, run at most one relevant verification pass after implementation. Do not run `npm run typecheck` by default if the change does not materially affect types or if a more targeted check is sufficient.
- Run a check earlier only when a concrete blocker requires its result to proceed, or when the task is broad/high-risk and an intermediate result changes the next step.
- If a check fails, diagnose and fix the cause before rerunning it. Do not rerun just because more unrelated edits were made.
- Before completion, use one final verification pass when warranted. If the same check already passed after the final relevant edit, do not repeat it without a reason.
- Do not ask the user whether to run routine checks after every edit. Use judgment, batch the work, and report which checks were actually run.
