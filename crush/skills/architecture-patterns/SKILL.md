---
name: architecture-patterns
description: "Use for explicit architecture or codebase-structure work: choosing a pattern, organizing modules, defining boundaries, changing dependency direction, or diagnosing coupling. Do not load for ordinary feature work unless structure is part of the task."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# Architecture Patterns

Choose architecture to reduce the cost and risk of change. Start from the existing repository, product complexity, team size, expected lifetime, and actual pain points. There is no universally best pattern.

## Core rules

- Keep dependencies explicit and avoid cycles. Inner business rules should not depend on outer frameworks or transport **when a distinct domain boundary exists**.
- Group code that changes together; avoid making one feature depend on unrelated modules.
- Expose intentional public APIs between modules. Avoid importing another module's private files when the repository has an established public boundary.
- Introduce a layer, interface, port, event, or shared module only to solve a concrete dependency, testing, ownership, or reuse problem.
- Prefer incremental boundary improvements over broad rewrites. Do not refactor unrelated code just to make the diagram cleaner.

## Choose the simplest fitting structure

- **Flat / feature-local structure:** small applications and features with little domain complexity. Keep implementation, types, and tests close together.
- **Feature-based:** several product areas with logic that changes independently. Each feature owns its implementation and exposes a small public surface.
- **Layered:** useful when presentation, application logic, and infrastructure have distinct responsibilities. Avoid pass-through layers that add no policy or isolation.
- **Clean / Onion:** useful when business rules must remain independent of frameworks and be tested in isolation. Keep the domain free of framework-specific types; do not create use cases and interfaces for trivial forwarding.
- **Hexagonal (ports and adapters):** useful when external systems or delivery mechanisms need to be replaceable or independently tested. Add ports where the boundary matters, not to fill a template.
- **Modular monolith:** useful when one deployable application needs strong internal boundaries. Avoid shared mutable state and accidental cross-module coupling; distributed services are not the default next step.

These approaches can be combined. Use names and folders that make the actual boundaries understandable to contributors.

## Frontend-specific guidance

- Organize around product features and responsibilities when the application is large enough to benefit; do not force a full Feature-Sliced Design (FSD) hierarchy onto a small app.
- Keep UI components focused on rendering and interaction. Move reusable business logic or data access out when doing so improves clarity, reuse, or testing—not automatically for every few lines.
- Treat shared modules carefully: promote code to shared only when ownership and reuse are real. Avoid dumping unrelated items into `shared`, `common`, or `utils`.
- Follow the framework's established conventions and the repository's current architecture before introducing a competing pattern.

## Structural-change checklist

1. What concrete change pain or risk does this structure solve?
2. Are dependencies and module ownership clear? Any cycles or private deep imports?
3. Does each new layer own meaningful behavior, policy, or isolation?
4. Are boundaries proportional to project size and expected change?
5. Can the problem be fixed incrementally without a broad migration?

If no concrete benefit can be named, keep the simpler structure.
