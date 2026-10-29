---
name: 2d-graphics
description: "Use for Godot 4.x 2D rendering and visual composition: CanvasItem/Node2D/Control hierarchy, draw order and z-index, TileMapLayer, Sprite2D and animation, Camera2D, Light2D and CanvasModulate, CanvasLayer, Viewport, basic shaders, and pixel-art setup. Do not load for gameplay logic, signals, or scene architecture; use the godot skill for those."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Godot 2D Graphics

The screen is a stack: hierarchy, then z-index, then y-sort, then CanvasLayer. Know which layer you are controlling. Pick the simplest drawing model that matches the game—scene nodes for characters, TileMapLayer for grids, custom `_draw` only when nothing else fits.

## Draw order

Godot composites 2D in this order, later wins:

1. **CanvasLayer** by `layer` (negative draws behind `0`, positive above). Use for HUD, parallax, cutscenes, minimap.
2. **Tree order** within a layer: parent draws before children, siblings in child order.
3. **`z_index`** within the same CanvasItem parent stack (`-4096..4096`). Use sparingly; it flips tree order.
4. **`y_sort_enabled`** on a parent sorts its children by global Y. The right tool for top-down overlap (characters, props).
5. **`z_as_relative`** decides whether a child's `z_index` is relative to the parent or absolute. Flip it deliberately, not by accident.

Rule of thumb: prefer tree order → then `y_sort` → then `CanvasLayer` → `z_index` last.

## Nodes

- **`Node2D`** for world objects in 2D space. **`Control`** for UI—anchors and containers, not position math.
- **`Sprite2D`** for one image, **`AnimatedSprite2D`** for frame flipbooks, **`AnimationPlayer`** for anything timeline-driven (movement, tint, sound cues).
- **`TextureRect`** for UI images with stretch modes; do not use `Sprite2D` in a `Control` tree.
- **`Polygon2D`** for simple shapes; `Line2D` for strokes; `_draw` only for dynamic procedural visuals.
- **`Marker2D`** for spawn points, pivots, aim origins. Name them by role.

## Camera2D

- **One active camera per viewport.** `enabled = true` on the one in use; disable on the rest.
- **`position_smoothing_enabled`** for follow, tuned in seconds, not frames. Use `position_smoothing_speed` low, not zero.
- **`limit_*`** to clamp to level bounds; otherwise the camera floats off the map.
- **`drag_horizontal_enabled` / `drag_vertical_enabled`** for dead zones—better than scripting a follow.
- **`get_screen_center_position()`** for UI that tracks the camera; do not read `position` and assume it matches.
- **Pixel-art:** integer `zoom` and `position_smoothing` off, or the world shimmers. Set `ProjectSettings > rendering/2d/snap/snap_2d_transforms_to_pixel`.

## TileMapLayer

- **Godot 4.3+ uses `TileMapLayer`.** One layer per visual plane (ground, decor, collision, foreground). `TileMap` is deprecated.
- **Separate physics tiles from visual tiles.** A layer with collisions should not also carry decoration; it makes editing and querying ambiguous.
- **`tile_set` physics layers** drive collisions; do not hand-place `StaticBody2D` per tile.
- **`y_sort_enabled` on the layer** for top-down overlap; combine with a parent `Node2D` that also y-sorts for entities.
- **`set_cell` in code only for runtime generation.** Level content lives in the editor scene; procedural edits go through one owner.
- **`used_rect()` and `get_used_cells()`** for bounds and queries; do not iterate the whole grid blindly.

## Lighting and color

- **`CanvasModulate`** tints the whole `CanvasLayer`/viewport—day/night, underwater, flash. One per layer; stack with `Light2D` for contrast.
- **`PointLight2D`** for torches, lamps; **`DirectionalLight2D`** for sun/global; **`LightOccluder2D`** with `OccluderPolygon2D` for shadows.
- **`CanvasItemMaterial.light_mode`:** `Unshaded` for UI/emissive, `Normal` default. A "glowing" object is usually `Unshaded` + additive blend, not more lights.
- **Blend modes** (`Add`, `Sub`, `Mul`, `Pre-mult Alpha`) on `CanvasItemMaterial` for glows and overlays. Test them on the target background, not on white.

## Pixel art

- **`ProjectSettings > rendering/textures/canvas_textures/default_texture_filter = Nearest`**. One setting, whole project.
- **Integer scale factors** only: `window/stretch/scale_mode = integer` and `scale = 2, 3, 4`. Non-integer scaling destroys pixels.
- **`snap_2d_transforms_to_pixel` and `snap_2d_vertices_to_pixel`** on; otherwise sub-pixel jitter.
- **`Camera2D.zoom` integer, `position_smoothing` off.** Smoothing on pixel art produces shimmer.
- **Sprite import:** `Filter = Neare[118;1:3ust`, `Mipmaps = Off`, `Fix Alpha Border = Off` unless you see fringing.

## Shaders

- **`canvas_item` shader** for 2D visuals. One effect per shader; compose with `next_pass` for stacks.
- **`uniform` values are the tuning surface.** Expose color, intensity, and thresholds—not hard-coded magic numbers.
- **`TIME` is global.** Time-based effects drift between scenes; reset or gate on a state uniform.
- **`SCREEN_TEXTURE`** via `hint_screen_texture` for full-screen effects (blur, distortion, vignette). Sample with `screen_uv`, not `UV`.
- **Do not reach for a shader** when `CanvasItem.modulate`, `self_modulate`, or a `Tween` on `modulate` solves it. Shaders are a cost.

## Viewport and stretch

- **`ProjectSettings > display/window/stretch/mode`:** `canvas_items` for most games, `viewport` for pixel art with strict scaling, `disabled` only if you manage scaling yourself.
- **`aspect = keep`** unless the design requires letterboxing; `expand` reveals more world, not more UI.
- **SubViewport** for render-to-texture (minimap, in-world screens, post-processing). Set `size`, `render_target_update_mode`, and `transparent_bg` deliberately.
- **`CanvasLayer.follow_viewport_enabled`** for parallax that tracks the camera without being a child of it.

## Common pitfalls

- **`z_index` fights with `y_sort`.** If a character draws behind a tree but above another, decide which system owns order and stick to it.
- **`CanvasLayer` breaks `y_sort`.** Nodes in different layers cannot interleave by Y. Put world and characters in the same layer if they must overlap.
- **Light2D needs a texture and an energy.** A light with `energy = 1` and no texture is invisible; a `CanvasModulate` can wash it out.
- **`TextureRect` ignores `position` when inside a `Container`.** Containers own layout; use `top_level = true` only for free-floating UI.
- **Modulate stacks multiplicatively down the tree.** A dimmed parent dims every child; `self_modulate` affects only the node.
- **Camera smoothing during pixel-snap produces a shimmer.** Pick one: smooth and non-snap, or snap and no smoothing.

## Quick check

Before finishing a 2D visual pass: Is the draw order (layer → tree → y_sort → z_index) intentional? Is the camera clamped and smoothed per the art style? Are tile physics separated from visuals? Is pixel art set to Nearest + integer scale? Are shaders earning their cost over modulate/tween? Does the HUD live on its own `CanvasLayer`?

If you cannot say which layer controls an element's order, the layering is accidental.
