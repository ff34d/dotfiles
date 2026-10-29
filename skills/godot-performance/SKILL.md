---
name: godot-performance
description: "Use for Godot 4.x performance work: profiling, _process overhead, node counts, MultiMesh/instancing, object pooling, physics queries, and rendering cost. Do not load without evidence—optimize only measured bottlenecks."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Godot Performance

Measure first. Godot rewards node-count discipline, cached lookups, and the right rendering primitive. Do not optimize what the profiler has not flagged.

## Profiling

- **Built-in profiler** (`Debugger > Profiler`) for frame time breakdown. Learn the split between `_process`, `_physics_process`, and `RenderingServer` before touching code.
- **`Performance.get_monitor()`** for continuous reads (FPS, draw calls, memory, node count, physics active objects).
- **`Time.get_ticks_usec()`** around suspected hot paths. Log, do not print per frame.
- **Remote scene tree** with performance monitors on. Watch node count, orphan count, and process time per node.
- **`--gpu-profile`** and `--frame-delay` for reproducible captures. Measure on target hardware, not the editor.

## Process overhead

- **`_process` and `_physics_process` cost per node.** Thousands of nodes ticking is the most common Godot slowdown.
- **Disable per node:** `set_process(false)` / `set_physics_process(false)` when idle. Re-enable on event.
- **`process_mode`** (`Inherit`, `Pausable`, `WhenPaused`, `Always`, `Disabled`) per node. Use `Disabled` for pooled nodes at rest.
- **One manager ticking many items** beats many nodes ticking themselves—when item count is high.
- **Signals over polling** for state changes that happen rarely.

## Rendering

- **`MultiMeshInstance2D` / `MultiMeshInstance3D`** for identical repeated sprites (bullets, grass, tiles). One draw call instead of thousands.
- **`Sprite2D` per entity** is fine up to a few hundred. Beyond that, benchmark before refactoring.
- **`CanvasItem.visible = false`** removes the node from drawing; `modulate.a = 0` does not. Hide, do not fade, for off-screen.
- **Draw calls dominate 2D fill-rate light scenes.** Batch textures, share materials, avoid unique `ShaderMaterial` per entity.
- **`RenderingServer` direct calls** for mass updates (particles, decals) when the scene tree overhead dominates. Advanced; measure before adopting.

## Physics

- **Collision layers and masks** are the cheapest optimization. Every object on every layer is the default slow path.
- **`Area2D.monitoring` off** when not needed; enable only when the area must detect.
- **`PhysicsServer2D` direct queries** (`intersect_ray`, `intersect_shape`) for one-off checks instead of a node.
- **Fixed timestep is a design choice**; lowering `physics_ticks_per_second` speeds simulation but changes feel. Do it deliberately.
- **Large static colliders:** one `StaticBody2D` with a `CollisionPolygon2D` beats hundreds of tiles with individual bodies.

## Memory and allocation

- **Object pooling** for frequently spawned/freed nodes (bullets, enemies, particles). `instantiate` + `queue_free` per call allocates.
- **Avoid `Array.append` in tight loops** without `resize` upfront. Preallocate when size is known.
- **`String` concatenation in loops** is O(n²). Use `PackedStringArray.join` or `StringBuilder`-style accumulation.
- **`preload` > `load`** for repeated loads. Cache `Resource` references; do not reload per frame.
- **`PackedByteArray` / `PackedInt32Array`** for large numeric data instead of `Array`.

## Common pitfalls

- **`get_node` per frame** instead of `@onready` caching.
- **Signals connected in `_ready`** on pooled nodes reconnecting on reuse—guard or disconnect on return.
- **`instance()` every frame** for VFX. Pool it.
- **`queue_free` in a tight loop** fragments memory; batch frees between frames.
- **`_process` doing `position += direction * delta`** on thousands of nodes instead of `MultiMesh` or a single manager.
- **Debug prints left in `_process`** destroying frame time. Strip them or gate on a debug flag.
- **Optimizing before measuring.** "Seems slow" is not evidence; the profiler is.

## Quick check

Profiler capture exists for the claim? Process/physics disabled on idle nodes? Right rendering primitive (MultiMesh vs Sprite)? Collision masks narrowed? Pooling for hot spawn paths? Allocation reduced in hot loops?

If you cannot point at the profiler capture, the change is a guess.
