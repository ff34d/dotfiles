---
name: testing-strategy
description: "Use when choosing test coverage or writing, changing, or diagnosing tests. Do not activate for every implementation by default; apply when tests are requested, relevant to the change, or needed to verify a bug fix."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# Testing Strategy

Tests should protect meaningful behavior and make changes safer. Optimize for confidence and maintainability, not a coverage percentage or a rigid testing pyramid.

## Choose the test level

- **Unit:** isolated logic, transformations, validation, and edge cases; usually the fastest option.
- **Integration:** interaction between modules, storage, network adapters, framework wiring, or real configuration.
- **End-to-end:** a small number of critical user journeys where the integration itself is part of the risk.

Use the cheapest test that gives credible confidence. Do not mock away the behavior the test is meant to verify. Follow the repository's existing tools and conventions.

## When to run checks

- Do not run tests, typechecks, lint, or builds after every individual line edit or tool action. Finish a coherent batch of related changes first, then run the narrowest relevant check at a checkpoint.
- Re-run a check when a subsequent fix could affect its result, when investigating a failure, or during final verification—not merely because another line changed.
- For small changes, prefer one appropriate verification pass after implementation. For broad or risky changes, use checkpoints when they provide useful early feedback.
- A typecheck is not a substitute for a behavioral test, and a test suite is not a substitute for typechecking when type correctness is relevant. Choose checks based on the change and repository scripts; do not automatically run every available command.

## What to test

- Assert observable behavior and important contracts, not private implementation details or incidental call order.
- Cover meaningful boundaries: empty/null values, invalid input, failures, permissions, state transitions, and off-by-one cases when applicable.
- For a bug fix, add a regression test when practical: it should fail before the fix and pass after it.
- Prefer explicit expected values. Avoid deriving expected output with the same logic used by the implementation.
- Keep each test focused on one behavior, with a name that explains the scenario and expected result.

## Reliable tests

- Make tests deterministic: control time and randomness where they affect results; isolate shared state; avoid dependence on test order.
- Unit tests should not require live network services or arbitrary real sleeps. Use fakes, controlled clocks, or temporary resources where appropriate.
- Prefer the simplest test double that fits: real value object, stub, fake, then mock when interaction itself is the contract.
- Avoid excessive setup, snapshot-only assertions for complex behavior, and helper abstractions used by only one trivial test.
- A test can use loops or conditionals when they improve clarity; do not ban language constructs categorically. Keep cases explicit when that makes failures easier to diagnose.
- Treat flaky tests as defects. Investigate the cause; do not hide flakes with blind retries.

## TDD and coverage

TDD is useful for well-defined behavior, algorithms, and reproducible bugs, but is not mandatory for exploratory UI work or unclear requirements. Before considering a meaningful behavior change complete, ensure appropriate verification exists—automated tests where they add value, otherwise clearly state the manual checks or remaining gap.

Coverage is a diagnostic signal, not a goal. Prefer coverage of changed behavior and risky branches over chasing a global percentage. Do not add tests solely to raise a number.

## Quick review

Check that assertions would catch the intended regression, tests are repeatable, important failure paths are covered, doubles are justified, and the suite actually ran. Report tests that were not run or could not be made reliable. Do not imply a check passed unless it actually ran.
