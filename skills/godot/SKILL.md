---
name: godot
description: "Use for Godot 4.x + GDScript implementation and refactoring: scene tree, signals, autoloads, node lifecycle, typed GDScript, resources, groups, and common runtime pitfalls. Do not load for 2D rendering, tilemaps, shaders, animation trees, or UI layout; use a graphics-specific skill for those."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Godot 4.x + GDScript

Compose with nodes and signals; keep state in the node that owns it; type everything the engine lets you type. Follow the project's existing scene conventions before introducing a competing pattern.

## Scene tree and composition

- **Scenes are the unit of composition.** Prefer small scenes composed together over deep inheritance. A scene that inherits `extends Player` is often better as `Player` + `Movement` + `Health` children.
- **A script belongs to the node it configures.** If a script only reads another node's data, it is in the wrong place.
- **`@onready` for children, `_ready` for setup.** Cache child references in `@onready`; do work that depends on the tree in `_ready`. Do not call `get_node` every frame.
- **Node paths are brittle.** Prefer `@export var` node references, unique names (`%Name`), or `@onready var x = $Path` once. Avoid `get_node("../..")` chains.
- **Name by role, not by class.** `Hurtbox`, `Muzzle`, `SpawnPoint` beat `Area2D2`, `Node3`.
- **Instantiate with `preload` for fixed scenes, `load` for runtime paths.** `preload` catches missing paths at parse time; prefer it unless the path is data-driven.

## Signals

- **Signal up, call down.** Children emit, parents connect. Direct calls are fine from parent to child; reverse direction usually wants a signal.
- **Connect in `_ready`, disconnect is automatic when either side is freed.** Manual `disconnect` is only needed for long-lived emitters with short-lived listeners.
- **Typed signals:** `signal died(cause: String)`. No untyped payloads—use a resource or a typed dictionary, not `Variant`.
- **Do not connect the same signal twice.** Re-entering a scene should not duplicate connections; guard or use `CONNECT_ONE_SHOT` where it fits.
- **Name signals as events in past tense:** `died`, `damaged`, `picked_up`. A signal named `on_damage` is a naming smell.
- **Avoid signal chains that hide control flow.** Three hops of relays is harder to debug than one direct call. Use signals at real boundaries, not at every node.

## Autoloads

- **Autoloads are global singletons.** Use them for services with no natural owner: input mapping, save system, audio bus, scene transitions. Not for game state that a scene should own.
- **Keep them few.** More than a handful usually means the scene tree is not carrying its weight.
- **No `_process` in autoloads** unless the service genuinely needs per-frame work. Prefer signals and events.
- **Autoload state survives scene changes.** Clear per-run state on `new_game` explicitly; do not rely on process restart.

## Lifecycle

- **`_process` for visuals and input polling, `_physics_process` for physics and movement.** Mixing them silently causes jitter and missed collisions.
- **`_input` vs `_unhandled_input`:** UI and modal state consume in `_input`; gameplay reads `_unhandled_input`. Do not handle gameplay in `_input` unless the game is modal.
- **`_ready` runs after children.** Use it for setup that needs the subtree. Use `_enter_tree` only for registration that must precede children.
- **`queue_free`, not `free`**, from gameplay code. `free` mid-frame invalidates references other nodes still hold.
- **`_exit_tree` for cleanup** of groups, timers, and external references. Signals self-clean; registered state does not.

## Typed GDScript

- **Type variables, parameters, and return values** (`var hp: int = 100`, `func take_damage(amount: int) -> void`). Typed code is faster and catches bugs the editor can flag.
- **`@export` for design-time values, `@export_range` / `@export_enum` when the domain is bounded.** An export without a range is a guess waiting to be a bug report.
- **`class_name` for shared types** used across scenes; local scripts otherwise. A `class_name` per script pollutes autocomplete.
- **`StringName` (`&"run"`)** for hot signal and animation names; plain `String` elsewhere.
- **`@tool` only when the editor genuinely needs it.** A tool script that runs game logic in the editor is a footgun.

## Resources and data

- **`Resource` subclasses for shared data:** stats, curves, item definitions, spawn tables. Save them as `.tres`/`.res`, edit in the inspector.
- **`Resource.duplicate()` when per-instance mutation is needed.** Shared resources are shared; mutating one mutates every user.
- **Validate exported data in `_ready` or a setter.** Silent fallbacks hide content bugs.
- **`@export_group` and `@export_subgroup`** keep the inspector readable. Order exports by importance, not by type.

## Common pitfalls

- **Orphan nodes:** `Node.new()` without `add_child` leaks. Add or `queue_free` explicitly; `@onready var x = $Node.new()` is not a thing.
- **Signal memory leaks:** a long-lived emitter holding a reference to a freed listener. Prefer `Callable` with a bound object; use `is_instance_valid` when unsure.
- **`get_node` in hot paths:** cache once in `@onready`. Repeated lookups dominate frame time in dense scenes.
- **`is_instance_valid` before deferred access:** after `queue_free`, references are still non-null until end of frame.
- **Groups are global strings:** typos are silent. Define them as constants (`const ENEMIES := &"enemies"`) and reuse.
- **`await` in `_process`:** suspended frames stack up. Use `await` for one-shot flows (`await get_tree().create_timer(1).timeout`), not per-frame logic.
- **`Input.is_action_pressed` in `_physics_process`:** fine for movement; not a substitute for `_input` events for discrete actions.

## Quick check

Before finishing: Are children cached in `@onready`, not looked up per frame? Are signals typed and past-tense? Is state owned by the node that uses it, not by an autoload? Is physics in `_physics_process` and visuals in `_process`? Are shared resour[118;1:3uces duplicated when mutated? Are `@export` values bounded and validated?

If a script needs another node's internals, the ownership is wrong—move the behavior, not the pointer.
