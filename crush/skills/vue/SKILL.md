---
name: vue
description: "Use for Vue component implementation, Composition API, reactivity, props/emits, composables, lifecycle, or Vue-specific refactoring. For JS/TS code changes, also load the TypeScript skill. Apply the project's Vue version and conventions."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.1
---

# Vue Practices

Use Vue 3 Composition API with `<script setup lang="ts">` by default unless the project explicitly uses another supported pattern. Follow the repository's component, routing, state, and styling conventions.

## Single-file component structure

When using a Vue single-file component, keep sections in this order:

1. `<script setup lang="ts">`
2. `<template>`
3. `<style>` only if the repository/framework convention explicitly requires colocated styles

The preferred project convention is to keep styles in separate files and import them where appropriate. Do not place styles in the component file by default.

## Composition API and TypeScript

- Type props, emits, exposed values, and important composable boundaries. Prefer `defineProps<T>()` and typed `defineEmits` when suitable for the project's Vue version.
- Keep reactive state minimal. Use `computed` for derived values; do not duplicate derived state in a `ref` unless synchronization is truly required.
- Use `ref` for replaceable values and `reactive` when an object-shaped reactive value makes access clearer. Understand unwrapping and destructuring behavior before changing reactive objects.
- Keep composables focused on reusable stateful behavior or integrations. Avoid extracting trivial code merely to create another file.
- Use `watch`/`watchEffect` for actual side effects and synchronization, not as a substitute for `computed`.
- Clean up listeners, subscriptions, timers, and external resources. Use lifecycle hooks and watcher cleanup where relevant.
- Declare props and emits explicitly. Avoid mutating props; emit changes or use a clearly owned local state model.
- Prefer `v-for` keys based on stable identity. Avoid index keys for reorderable collections.

## Component design

- Keep one main component per file. Small private helpers may remain colocated if they improve readability.
- Keep business logic out of templates when expressions become hard to understand; move it into script-level functions or computed values.
- Follow existing naming conventions for components, composables, stores, and files. Do not add Pinia or another library if the project already has an adequate state approach.
- Keep API/data access in the established service or feature layer when one exists; do not scatter network calls through templates or lifecycle hooks.

## Verification

Check reactive dependency behavior, watcher cleanup, props/emits contracts, and loading/error states. Finish the related edit batch and review the diff before running one relevant Vue check. Never run checks after every line or tool action; rerun only when a relevant fix or risk justifies it. Avoid unrelated refactors.
