---
name: typescript
description: "Use whenever implementing or materially editing JavaScript/TypeScript code, modeling types, handling async/runtime behavior, diagnosing compiler errors, or changing frontend tooling. Load alongside React, Vue, Next.js, or React Native skills when their implementation includes JS/TS; the framework skill covers framework conventions and this skill covers language/type safety. For conceptual framework questions with no JS/TS code or type implications, it is not needed."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# TypeScript and Frontend Language Practices

Prefer explicit, useful types and let the type system prevent invalid states. Follow the repository's TypeScript version, compiler options, lint rules, and established patterns before introducing new conventions.

## Type modeling preferences

- Prefer `type` for simple aliases, unions/intersections, utility compositions, and small structural shapes.
- Prefer `interface` for named object contracts/entities that represent a stable, extendable shape, especially business objects. This is a preference, not a technical restriction; use whichever communicates the model best.
- Give important function boundaries, API data, component props, emitted events, and shared state meaningful types. Let TypeScript infer obvious local variables and return types when inference stays clear.
- Avoid `any`. Prefer `unknown` at untrusted boundaries, then narrow or validate it. Do not use assertions to silence a mismatch without understanding it.
- Model nullable, loading, success, and error states explicitly when they affect behavior. Use discriminated unions when they make invalid combinations harder to represent.
- Avoid duplicate types that merely mirror one another without a real boundary. Reuse an existing domain type when ownership and semantics match.

## JavaScript semantics

- Use arrow functions when lexical `this` is intended or when matching project conventions (including React components and callbacks).
- Use regular `function` declarations when their own `this`, hoisting, generator behavior, or a named function declaration is useful. Do not choose syntax based on an inaccurate assumption that one form is universally faster or more typed.
- Prefer `const`; use `let` only when reassignment is needed. Avoid mutation when it makes data flow harder to follow, but do not introduce costly copying without a reason.
- Handle promises intentionally. Avoid unobserved rejections, accidental floating promises, and unnecessary `async` wrappers.
- Use platform APIs and language features supported by the project's target/runtime; check compatibility before introducing newer syntax.

## Frontend project conventions

- Prefer keeping styles in separate style files rather than embedding them in component source, except where the framework or project convention makes colocated styles the clearer choice. React Native styles are normally colocated with the component.
- Keep types close to the feature or component that owns them. Promote them to shared modules only when multiple consumers genuinely share the same concept.
- Do not add abstractions, generic helpers, state libraries, or build tools for hypothetical future needs.
- Respect the current package manager, lockfile, formatter, lint rules, and build setup. Avoid unrelated toolchain changes.

## Verification

When changing type-heavy code, first finish the related implementation batch and review the diff. Run the narrowest relevant typecheck once after that batch if it adds meaningful confidence. **Never run or ask for a typecheck after each edit, file save, patch, or tool action.** Re-run only if a relevant fix may have changed the result, a failure needs diagnosis, or final verification is warranted and no check has covered the final state. Do not automatically run lint, tests, and build alongside typecheck unless the change warrants them. Do not claim TypeScript guarantees runtime validation of network data; validate external data when required by the risk and contract.
