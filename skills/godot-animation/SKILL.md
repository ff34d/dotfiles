---
name: godot-animation
description: "Use for Godot 4.x animation: AnimationPlayer, AnimationTree, StateMachine, blend spaces, BlendSpace2D, method/audio tracks, and syncing animation with gameplay state. Do not load for sprite sheet import or shader-based effects."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Godot Animation

`AnimationPlayer` plays clips. `AnimationTree` decides which clip. Gameplay owns the state; the tree reads it. Never let animation drive logic—only visuals and cues.

## Choose the tool

- **`AnimationPlayer`** for one-off clips: doors, UI, cutscenes, VFX sequences. Simple and direct.
- **`AnimationTree` with `AnimationNodeStateMachine`** for character locomotion and combat. States, transitions, and conditions live in the tree.
- **`BlendSpace1D` / `BlendSpace2D`** for continuous blending: walk→run by speed, strafe by velocity. One parameter drives the blend.
- **`AnimationNodeBlendTree`** for layered animation: base locomotion + additive upper-body aim + one-shot overlays.
- Do not use `AnimationTree` for a single clip; do not use `AnimationPlayer` for state-driven locomotion.

## State machine

- **States match gameplay states, not clips.** `idle`, `run`, `jump`, `attack`. Clips are assets; states are behavior.
- **Transitions carry conditions**, set from code via `AnimationTree.set("parameters/.../transition_request", "run")`. Do not connect gameplay signals directly to animation nodes.
- **One-shot animations** (attack, hurt) use `AnimationNodeOneShot` or an `AnimationStateMachine` with `advance_condition` and `advance_expression`.
- **Do not duplicate state logic** between gameplay and the animation tree. If gameplay already knows "is running", the tree should read that, not re-derive it.
- **Reset on re-entry** with `AnimationNodeStateMachinePlayback.start()` when a state must restart (attack cancels, hurt overrides).

## Tracks and cues

- **Method tracks** for gameplay cues at exact frames: spawn hitbox, play sound, emit signal. Better than timers.
- **Audio tracks** for footsteps, swings. Route through `AudioStreamPlayer` child nodes with bus names, not global players.
- **Call method tracks call any `Callable`**—including on freed nodes. Guard with `is_instance_valid` or use signals.
- **Property tracks for visuals only** (modulate, position offset, scale). Do not animate gameplay stats like HP—drive them from code.

## Timing and feel

- **Squash and stretch on `scale`** reads better than movement tweens. Use `AnimationPlayer` and blend back to `Vector2.ONE`.
- **Anticipation and recovery frames matter more than the strike.** A one-frame hit with no windup feels invisible.
- **Do not sync gameplay to animation length in code.** Read `animation_finished` or `animation_changed` when needed, but keep the source of truth in gameplay.
- **`Tween` for procedural motion** (UI, camera, world objects). Use it over manual `_process` interpolation.

## Blend spaces

- **`BlendSpace1D` for a single dominant axis** (speed). **`BlendSpace2D` for two** (velocity). Beyond two axes, layer trees.
- **Blend parameters are gameplay values**, not tweaked per state. Set `run_speed = velocity.length()` and let the tree choose.
- **Synchronize clips at the same phase** with "Sync Mode" (`Anim Tree` sync groups) so feet do not skate during blend.

## Common pitfalls

- **`AnimationTree.active = false`** during scene transitions stalls the tree silently. Re-enable and re-set parameters on resume.
- **Setting `AnimationTree` parameters with `set("parameters/...")`** relies on exact paths; wrap in constants or a helper.
- **`AnimationPlayer.play()` interrupting the tree.** Pick one system per node.
- **Method tracks running on freed nodes.** Validate before invoking.
- **Blending `position` tracks across clips** causes drift. Blend `velocity` or use root motion.
- **`Tween` killed by scene change.** Store the tween if the caller needs to cancel or chain; otherwise let it die.

## Quick check

State machine states match gameplay states? Transitions requested from code, not wired from signals into animation? Cues as method/audio tracks, validated? Blend parameters driven by real gameplay values? One animation system per node?

If animation is deciding gameplay, invert the dependency.
