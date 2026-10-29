---
name: code-review
description: "Use when the user asks to review a diff, PR, patch, commit, or proposed change for defects or merge risk. Do not activate merely because code is being written."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# Code Review

Review changes to find meaningful defects and risks, not to enforce personal style. Review the diff first; inspect surrounding code only as needed to understand behavior and contracts.

## Review procedure

1. Establish intended behavior from the request, tests, and nearby code. If intent is unclear and affects correctness, state the uncertainty.
2. Trace changed paths and their callers, state, side effects, error handling, and external contracts.
3. Prioritize correctness, regressions, data loss, security/privacy, compatibility, performance at realistic scale, and missing critical tests.
4. Verify findings against code. Do not report speculative problems as facts or invent file locations.
5. Avoid style-only comments unless they create a concrete maintenance or correctness problem.

## Finding quality

A finding should identify the problem, its impact, and the condition under which it occurs. Include a file/line reference when available and a practical fix. Do not report a concern if the code or context disproves it.

Use these severity levels when useful:

- **Blocker:** likely data loss, security issue, crash, or core behavior failure; must fix before merge.
- **Important:** realistic defect or regression with meaningful impact.
- **Minor:** limited-impact issue worth correcting, but not a merge blocker.
- **Question:** intent or contract needs clarification before a reliable conclusion.

Do not inflate severity. Separate confirmed defects from suggestions and questions.

## Scope and output

- Do not rewrite the entire implementation unless asked. Review only the supplied change and relevant context.
- If there are findings, list highest severity first. For each: severity, location, condition, impact, and suggested correction.
- Then briefly state residual risks and checks not run, if relevant.
- If no findings are identified, say so explicitly and summarize the main areas checked. Do not invent filler sections for a tiny review.
- Use a detailed report for substantial or high-risk changes; use a short verdict for a small diff.

## Checklist

Check only applicable items: behavior and edge cases; null/empty/error paths; state and side effects; API/type compatibility; authorization and sensitive data; concurrency and lifecycle; resource cleanup; performance on realistic inputs; accessibility when UI changes; migration/backward compatibility; tests for changed behavior.

A review is not proof of correctness. Distinguish what was inspected from what was executed or tested.
