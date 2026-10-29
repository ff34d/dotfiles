---
name: godot-save
description: "Use for Godot 4.x save/load systems: what to persist, format choice (Resource/JSON/ConfigFile/binary), versioning and migrations, atomic writes, and load-time validation. Do not load for general data-driven content authoring."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Godot Save/Load

Persist state, not objects. Version every file, validate on load, write atomically. A save is a contract with future you; break it carefully.

## What to save

- **Player-visible state and progression:** unlocks, stats, inventory, quest flags, world position, current scene.
- **Not the scene tree.** Do not serialize nodes. Serialize the data the scene needs to reconstruct itself.
- **Not ephemeral sta[118;1:3ute:** tween progress, particle state, animation time, camera smoothing accumulators.
- **Derive, do not save:** anything computable from saved data (max HP from level, UI strings from IDs).
- **Narrative/audio/animation cues** are not save data; replay them on load if they matter.

## Format choice

- **`ConfigFile`** for small, human-editable settings and debug data. Simple, poor for nested structures.
- **`JSON`** for portable, human-readable saves. Loses types—cast on load, validate ranges.
- **`Resource` (`.tres`/`.res`)** when saves must round-trip Godot types. `ResourceLoader.load` accepts arbitrary resources—sanitize or use `ResourceLoader.CACHE_MODE_IGNORE`.
- **Binary via `var_to_bytes`/`bytes_to_var`** for large or performance-critical saves. Opaque; versioning is mandatory.
- **Never `ResourceSaver.save` a user-editable file without `ResourceLoader` on load.** Resource format executes code paths; treat loaded files as untrusted.

## Versioning and migrations

- **`save_version: int` as the first field.** Reject unknown versions or migrate; do not guess.
- **Migrations are functions**, one per version step (`v1_to_v2`, `v2_to_v3`). Chain them; never rewrite old migrations.
- **Additive changes are free; renames and removals are migrations.** Do not reuse field names with new meanings.
- **Defaults on load:** every field has a fallback. A save missing a new field is normal, not a bug.
- **Deleted features leave tombstone keys** until the next major version, then drop them in a migration.

## Atomic writes and paths

- **Write to `user://save.tmp`, then `DirAccess.rename` over `user://save.dat`.** A crash mid-write must not corrupt the save.
- **Keep one backup** (`save.dat.bak` rotated before rename). Recovery on load: if parse fails, try the backup.
- **`user://` for writable, `res://` for read-only.** Anything in `res://` is wiped on export reimport; do not save there.
- **Slot paths as constants.** `user://saves/slot_%d.dat`—no string concatenation scattered across scripts.
- **Save metadata separately** (`slot_%d.meta`) with timestamp, level, playtime—so the menu lists slots without loading full saves.

## Validation on load

- **Validate type and range per field.** `hp` is `int`, `0 <= hp <= max_hp`. Silent coercion hides corruption.
- **Fail loudly for corrupt saves**, but degrade gracefully: offer the backup, offer a fresh start, never silently overwrite.
- **Sanitize before `bytes_to_var`.** `bytes_to_var` can construct arbitrary objects; validate with `allow_objects = false` unless the file is trusted.
- **Log the loaded version and slot** for support and debugging.

## Common pitfalls

- **Saving `Resource` without version.** Next release breaks silently for players.
- **Non-atomic write.** Power loss corrupts the save; player loses progress.
- **Saving references to nodes** (`"player": $Player`). Serializes ids, not state; breaks on reload.
- **No defaults for new fields.** One missing field crashes the whole load.
- **Loading with `bytes_to_var` and no validation.** Arbitrary object construction from user files.
- **Testing only the "happy path" save.** Test migration, corrupted file, missing file, permission denied.

## Quick check

Version field first? Migrations chained and additive? Defaults for every field? Write atomic with a backup? `user://` paths centralized? Validation per field on load? Corrupt saves recover gracefully?

If loading a save requires the same code path that wrote it, the format is not a contract.
