---
name: godot-audio
description: "Use for Godot 4.x audio: AudioStreamPlayer vs 2D/3D, audio buses, reverb, effects, ducking, music loops, and sync with animation. Do not load for input remapping or animation state logic."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Godot Audio

Audio is a bus graph plus players. Route once, mix once. One music track, many SFX, one obvious path from event to sound.

## Players and routing

- **`AudioStreamPlayer`** for music and UI (no spatialization). **`AudioStreamPlayer2D`** for world sound that pans and attenuates; **`3D`** for spatial. Pick by context, not preference.
- **Buses in `AudioServer`:** `Master`, `Music`, `SFX`, `UI`, `Voice`, `Ambient`. Name by role, mix by role.
- **Never route SFX directly to `Master`.** One SFX bus lets you duck, mute, and balance in one place.
- **`bus` is set per player**, not per stream. Same stream, different bus, different mix—valid and cheap.
- **Music on its own bus** with a compressor and a `AudioEffectLimiter` before `Master`.

## Mixing and effects

- **Add effects on the bus**, not on individual players, unless the effect is per-instance (reverb per room). Bus effects are shared and cheap.
- **Ducking via `AudioEffectCompressor` with sidechain**, not by scripting volume. Music ducks when `Voice` crosses a threshold, automatically.
- **`AudioEffectReverb` per room** via a bus switch, not per player. Swap buses with `set_bus`.
- **`AudioEffectEQ6` / `EQ10`** for tonal balance on `Master`; do not fix tonal issues by re-importing files.
- **`AudioServer.set_bus_volume_db()`** for fades. Prefer `Tween` on the value over `_process` math.

## Music

- **Loop with `AudioStreamOggVorbis.loop`**, not by restarting the player. Configure the loop point in import.
- **Stingers** on a separate player and bus so they do not cut the loop.
- **Layered music** via `AudioStreamInteractive` or multiple synchronized players. One source of truth for the current layer.
- **Do not stop and restart music across scene loads.** Keep it on a persistent autoload or `CanvasLayer` player; only change tracks when design demands.

## SFX

- **Pool players** for frequent sounds (footsteps, hits). `AudioStreamPlayer` created per call leaks and stutters under load.
- **Pitch variation** (`pitch_scale = randf_range(0.9, 1.1)`) to break repetition. Keep it small; large shifts break the asset's identity.
- **Polyphony limit per sound** to avoid stacking: cap concurrent instances of the same hit.
- **Do not play on `_ready` for scene-scoped sounds.** Wait for the event that actually triggers them.

## Sync

- **Method tracks in `AnimationPlayer`** for footsteps and impacts, not timers. Frame-accurate.
- **`AudioStreamPlayer.finished` signal** for one-shot chaining; do not poll `playing`.
- **Do not `await` audio length** to chain SFX—latency stacks. Schedule the next sound against `get_playback_position()` instead.

## Common pitfalls

- **`AudioStreamPlayer` per SFX call** without pooling. Dozens of nodes, frame hitches.
- **Music restarted on scene change** because it lives in the scene. Move it out.
- **Fading with `_process` math** instead of `Tween`. More code, less reliable.
- **Reverb on `Master`** affecting UI and music. Route reverb to a bus the world uses.
- **Mono files panned in 2D** behave differently than stereo. Set `panning_strength` deliberately.
- **Importing `.wav` with loop disabled** and wondering why music stops. Configure loop on import.

## Quick check

Players chosen by context (2D world vs UI vs music)? Buses by role, effects on buses? Music persistent across scenes? SFX pooled with pitch variation? Cues synced via animation tracks, not timers? Ducking automated?

If the mix requires per-player tweaking, the bus graph is missing a bus.
