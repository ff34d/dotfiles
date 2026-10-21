---
name: react
description: "Use for React component implementation, hooks, rendering behavior, state, props, context, or React-specific refactoring. For Next.js routing/server components, also use the Next.js skill when relevant."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# React Practices

Follow the project's React version, router, state/query libraries, and existing component conventions. Do not introduce a new library or architecture without a concrete need.

## Component conventions

- Prefer function components written as arrow functions and explicitly typed with `React.FC`/`FC`, matching this project's convention. If the repository has an established alternative or the installed React typings make a pattern unsuitable, preserve compatibility and explain a meaningful deviation.
- Aim for one primary component per file. Small, tightly related private subcomponents or types may stay in the same file when this improves locality; split them when they are independently reusable, complex, or obscure the main component.
- Keep component responsibilities clear. Extract logic into a custom hook when it represents reusable stateful behavior or makes the component materially easier to understand—not merely to move a few lines.
- Keep styles in separate files where practical, following the project's styling system. Do not mix unrelated styling approaches.

## Hooks and state

- Follow the Rules of Hooks. Call hooks unconditionally at the top level of components or custom hooks.
- Keep state as local as possible. Lift it only when multiple consumers need coordinated ownership; use context or a state library only when prop passing/local state no longer fits.
- Derive values from existing state instead of storing duplicate state that can drift.
- Use effects to synchronize with external systems (subscriptions, browser APIs, imperative libraries), not to calculate values that can be derived during render.
- Clean up subscriptions, timers, listeners, and imperative resources. Handle stale closures and async races where relevant.
- Use stable keys for rendered collections. Do not use array indexes when items can reorder or be inserted/removed and identity matters.
- Memoize with `useMemo`, `useCallback`, or `memo` only when identity/performance matters or measurement supports it. Avoid blanket memoization.

## Type safety and behavior

- Type props, callbacks, refs, and context values meaningfully. Avoid `any` and unsafe assertions.
- Keep rendering declarative; avoid direct DOM mutation unless integrating with an imperative API.
- Make loading, empty, error, and success states explicit when applicable. Consider accessibility: semantic elements, labels, keyboard behavior, focus, and status announcements.
- Prefer testing user-visible behavior over component internals.

## Before finishing

Check hook correctness, state ownership, effect cleanup/dependencies, keys, and accessibility. After a coherent batch of related edits, run only the relevant project checks (typecheck/lint/tests); do not run them after every line or tool action. Re-run after relevant fixes or before completion as risk warrants.
