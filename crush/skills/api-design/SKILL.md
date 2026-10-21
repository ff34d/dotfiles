---
name: api-design
description: "Use when designing or materially changing API contracts, endpoints, request/response schemas, data-access boundaries, error mapping, pagination, or external integrations. Do not activate for an ordinary API call that follows an established project pattern."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# API Design

An API is a contract between systems or layers. Design for explicit inputs, outputs, errors, and evolution. Apply the level of separation that fits the project's size and existing conventions.

## Contract fundamentals

- Define request and response shapes, required fields, validation, side effects, and error behavior.
- Validate untrusted input at the boundary. Enforce business invariants in the domain/application logic as appropriate; client-side validation is not a security boundary.
- Keep error responses stable and actionable. Use machine-readable codes where clients need to distinguish cases; do not expose stack traces or sensitive internals.
- Make pagination, filtering, sorting, naming, and error envelopes consistent across related endpoints.
- Prefer backward-compatible additions. For breaking changes, define a migration or versioning strategy.
- Make retryable side effects safe through idempotency or an equivalent deduplication strategy when duplicate execution would be harmful.
- Enforce authentication and authorization on trusted server-side boundaries; never rely on UI visibility or client-provided identity/permissions.

## Frontend data access

- Keep transport details (`fetch`/Axios calls, headers, serialization, HTTP status handling) out of rendering code when a data-access layer improves consistency, reuse, or testability.
- Follow the existing query/cache library and service conventions. Do not build a second transport abstraction around a project that already has a suitable one.
- Type API boundaries and treat network data as untrusted. Runtime schema validation is useful when malformed or drifting responses are a meaningful risk; TypeScript types alone do not validate JSON at runtime.
- Separate DTOs from application/domain types when their meanings or lifecycles differ. If the wire shape already is the useful application shape, avoid pointless mapper files and duplicate types.
- Map transport errors into a small application-level error model when callers need transport-independent handling. Do not create a custom error class for every status code by default.
- Keep UI concerns such as toasts, navigation, and loading indicators with the UI/use-case caller, not in a generic transport client.
- Organize endpoint functions, schemas, and mappers by feature or API ownership, consistent with the repository. Avoid one giant unrelated API module.

## Server-side boundaries

- Keep handlers/controllers thin enough to parse and validate input, invoke application behavior, and shape the response. Business rules belong in the appropriate application/domain layer, not in transport glue.
- Return an explicit public response contract rather than leaking database rows or internal objects by accident.
- Translate known domain failures into stable public errors. Unexpected failures should not leak secrets or implementation details.
- Use layered or ports-and-adapters separation when it protects a real boundary; do not introduce use cases, repositories, or interfaces that only forward calls without adding policy or isolation.

## Review questions

1. Is the contract explicit and validated at the correct boundary?
2. Are error shapes, authorization, retries, and side effects handled safely?
3. Are transport details leaking into layers that should not know them?
4. Do DTO/domain mappings solve a real mismatch, or are they redundant?
5. Can the contract evolve without silently breaking callers?

Treat these as risk checks, not a requirement to introduce every possible layer.
