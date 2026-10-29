---
name: documentation-writing
description: "Use when creating or reviewing README files, ADRs, specifications, API references, runbooks, changelogs, onboarding or contribution guides, or non-obvious code comments. Do not activate for routine code changes with no documentation impact."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# Documentation Writing

Write for a specific reader and question. Put the answer first, use concrete details, and avoid duplicating information that already has a source of truth.

## General rules

- Identify the reader and the task the document helps them complete.
- Start with purpose or the direct answer; organize the rest in the order a reader needs it.
- Prefer concise headings, lists, commands, and examples over long abstract prose.
- Use the same terms as the code and product. Link to canonical details instead of copying them into multiple documents.
- Mark unknowns and assumptions explicitly. Do not present guesses as facts.
- Keep commands copy-pasteable and label pseudocode or illustrative examples.
- Update documentation when a change makes it incorrect. Delete or mark obsolete guidance rather than letting it mislead.

## Choose the document shape

- **README:** what the project is, prerequisites, install/run/test commands, and links to deeper material.
- **ADR:** title, date/status, context and constraints, decision, consequences. Create a new ADR to supersede an accepted decision rather than silently rewriting history.
- **Design/spec/plan:** problem, goals and non-goals, approach, important interfaces/data flow, alternatives and trade-offs, risks/rollout. Scale detail to project risk; do not impose a page count.
- **API reference:** purpose, parameters and types, response/errors, minimal example. Generate repetitive details from schemas where practical.
- **Runbook:** symptom, ordered checks/actions, recovery or rollback, escalation path. Prioritize usable steps over background explanation.
- **Changelog:** user-visible changes grouped by release; describe impact rather than internal refactors.
- **Code comment:** explain a non-obvious reason, constraint, workaround, or trade-off. Do not narrate what the code already says or leave vague TODOs.
- **Contribution guide:** local setup, tests, branch/commit/PR expectations, and review process.

## Maintenance and review

Keep docs near the code or workflow they describe. Avoid repeating configuration defaults already defined in code/config; link to or generate from the source of truth. Use diagrams only when they clarify a flow or relationship better than text.

Before finishing, check: Is the answer easy to find? Is each section useful? Are examples accurate? Are terms consistent? Did the change create stale or duplicated documentation?
