---
name: godot-input
description: "Use for Godot 4.x input handling: InputMap actions, keyboard/mouse/gamepad/touch, _input vs _unhandled_input vs _input_event, action remapping, deadzones, and buffering. Do not load for movement physics; use the godot skill for that."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Godot Input

Actions, not keys. Poll for held state, handle events for presses. Map once in `InputMap`, read everywhere through action names.

## Actions

- **Define actions in `ProjectSettings > InputMap`**, never hard-code `KEY_W` or `JOY_BUTTON_A` in gameplay code.
- **Name by intent:** `move_left`, `jump`, `interact`, `pause`. Not `key_a`.
- **Multiple bindings per action:** keyboard, gamepad, touch. The map is the remap surface.
- **Remap via `InputMap.action_erase_events` + `action_add_event`**, then persist to `ConfigFile`. Do not store raw key codes in save files.
- **Contextual maps** (`gameplay`, `menu`, `dialogue`) as separate action sets or autoload-managed enable/disable. Do not branch on game state inside every `_input`.

## Polling vs events

- **`Input.is_action_pressed`** in `_physics_process` for movement. Continuous, frame-aligned.
- **`Input.is_action_just_pressed`** is per-frame, not per-event. It can miss inputs between frames; do not use it for critical actions.
- **`_input(event)`** for global handling: pauses, debug keys, UI modals. Consumes before gameplay.
- **`_unhandled_input(event)`** for gameplay actions. Only sees what UI and earlier handlers did not consume.
- **`_input_event`** on `CollisionObject2D` for object-local clicks. Do not do world queries manually when this fits.
- **`get_viewport().set_input_as_handled()`** after consuming. Forgetting this is why the player jumps when clicking a menu button.

## Gamepad and touch

- **Deadzones per axis** (`InputMap` action deadzone), not global. Analog sticks drift; triggers do not.
- **`JOY_BUTTON_*` vs `JOY_AXIS_*`:** buttons are discrete, axes are continuous. Bind both to the same action when possible.
- **Controller connect/disconnect** via `Input.joy_connection_changed`; rebuild UI hints, not the input logic.
- **Touch:** `InputEventScreenTouch` / `InputEventScreenDrag`. Do not emulate mouse—handle touch explicitly.
- **`Input.get_connected_joypads()`** at startup to choose the right glyph set.

## Buffering and feel

- **Input buffering:** store the last N frames of a press; consume when the action becomes legal. One `[action, frame]` ring buffer is enough.
- **Coyote time:** a small grace window after leaving ground for jump. Ten frames is a start; tune in feel.
- **Do not use `Timer` for buffering**—poll `Time.get_ticks_msec()` against a stored timestamp.

## Common pitfalls

- **`is_action_just_pressed` in `_process`** racing `_physics_process` causes missed inputs. Pick one tick for gameplay actions.
- **Reading `Input.is_key_pressed(KEY_W)`** bypasses remapping and splits keyboard/gamepad paths.
- **UI eating gameplay input** because nothing called `set_input_as_handled()`.
- **`_input` for movement** instead of `_unhandled_input`—UI can no longer suppress it.
- **Multiple `_input` handlers acting on the same event.** Order is tree order; make it explicit or consolidate.
- **Analog deadzone set to 0** produces drift; set to 0.2 as a starting point.

## Quick check

Actions defined by intent and remappable? Movement polled in `_physics_process`, presses in `_unhandled_input`? Handled events consumed? Deadzones per action? Buffering implemented with timestamps, not timers?

If a key code appears in gameplay code, the input map is being bypassed.
