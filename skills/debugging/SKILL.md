---
name: debugging
description: "Use when diagnosing a bug, unexpected output, crash, failing or flaky test, regression, or environment-specific failure. Not needed for routine implementation unless debugging is part of it."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# Debugging

Reduce uncertainty systematically. Prefer evidence over guesses and the smallest fix that addresses the demonstrated cause.

## Workflow

1. **Define the symptom.** Capture the exact error/output, expected behavior, environment, relevant inputs, and when it began.
2. **Reproduce when practical.** Build the smallest reproduction that preserves the failure. If it is intermittent or cannot be reproduced locally, collect logs, traces, timestamps, versions, and environmental differences; state the limitation.
3. **Form a specific hypothesis.** Identify the mechanism that could produce the symptom and what observation would support or disprove it.
4. **Run a discriminating check.** Change one variable at a time where practical. Prefer a targeted test, log, trace, or minimal experiment over unrelated edits.
5. **Confirm the cause.** Verify that evidence supports the explanation. If the cause remains uncertain, label it as a hypothesis rather than claiming certainty.
6. **Apply the smallest safe fix.** Avoid unrelated refactors. Add a regression test when it provides meaningful protection and is practical.
7. **Verify and report.** Re-run the reproduction and relevant checks. State what changed, what passed, and what remains unverified.

## Useful diagnostic order

- Read the full error and stack trace before editing.
- Check recent changes, configuration, dependency/runtime versions, input shape, state transitions, and environment differences.
- Follow data from source to failure; inspect boundaries where types, serialization, async timing, or external responses can change it.
- For async/race issues, examine lifecycle, cancellation, stale closures, shared mutable state, ordering, and cleanup.
- For performance issues, measure or profile before optimizing. Identify the dominant cost rather than guessing.
- Avoid broad logging, destructive commands, dependency upgrades, or resets unless justified and safe.

## Rules

- Do not make several unrelated changes at once; they obscure causality.
- Do not suppress an error merely to make the symptom disappear.
- Do not assume the first plausible explanation is the root cause.
- A failing test may expose a product defect, a test defect, or an environment issue; determine which before changing expectations.
- If reproducing is impossible, make progress with the available evidence but explicitly communicate uncertainty.

## Completion note

For nontrivial investigations, summarize: symptom, confirmed cause or remaining hypothesis, fix, verification, and residual risk. For obvious one-line issues, a concise explanation is enough.
