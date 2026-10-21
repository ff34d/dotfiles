---
name: react-native
description: "Use for React Native or Expo-specific implementation: native components, styling, navigation, gestures, platform APIs, permissions, or iOS/Android behavior. Use the React skill for general React concepts too when relevant."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# React Native Practices

Inspect the React Native/Expo version and existing navigation, styling, state, and build setup first. Prefer the project's established APIs and libraries over introducing alternatives.

## Components and styling

- Use native primitives (`View`, `Text`, `Pressable`, `ScrollView`, `FlatList`, etc.) rather than web DOM elements. Use platform-specific components only when the experience genuinely differs.
- Colocate styles with the component by default, typically using `StyleSheet.create` or the project's existing styling system. Keep large or shared style definitions separate when that improves clarity.
- Keep one main component per file where practical; small private subcomponents can remain colocated when tightly related.
- Use `FlatList`/`SectionList` for long or dynamic collections rather than rendering an unbounded array inside a `ScrollView`.
- Respect safe areas, keyboard behavior, touch target size, accessibility labels/roles, and platform conventions.

## Platform and lifecycle

- Check whether an API is supported on both platforms and in the installed runtime. Use `Platform` or platform-specific files only when behavior truly differs.
- Request permissions when needed and handle denied/restricted states. Do not assume a permission is granted.
- Clean up listeners, subscriptions, timers, and native resources. Handle app foreground/background transitions when they affect correctness.
- Avoid blocking the JS thread with expensive work. Profile before optimizing animations, rendering, or list performance.
- Follow the project's navigation and deep-link setup; do not introduce a second navigation system.

## Expo and native dependencies

- Determine whether the project uses Expo managed/prebuild or a bare React Native setup before changing native configuration.
- Check SDK compatibility before adding or upgrading native modules. Prefer supported Expo APIs in Expo projects where they satisfy the requirement.
- Do not edit generated native files or run destructive prebuild/reset commands without understanding how the project manages them.
- Keep secrets out of the app bundle; client-side environment variables are not secret.

## Verification

Check the affected platform(s), navigation/lifecycle behavior, permissions, and keyboard/safe-area layout. After a coherent batch of related edits, run relevant typecheck/lint/tests rather than after every line or tool action; rerun after relevant fixes or before completion as risk warrants. If a simulator/device is unavailable, state what could not be verified.
