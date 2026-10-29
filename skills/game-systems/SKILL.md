---
name: game-systems
description: "Use for explicit systems-design and systems-architecture work in a game: decomposing mechanics into systems, defining state ownership and data flow, choosing update/tick models, managing coupling and emergence, and deciding what is data vs code. Do not load for ordinary feature implementation unless system structure is part of the task; use game-design for player experience, core loop, and scope."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Game Systems

Choose system structure to reduce the cost of tuning, debugging, and adding content. Start from the game you actually have, its pain points, and its team size. There is no universally best decomposition—only the simplest one that keeps the current systems understandable and changeable.

## Core rules

- **Each system has one job.** Name it by responsibility (combat, inventory, weather), not by implementation. If you cannot describe its input, state, update, and output in one sentence, it is two systems.
- **Make state ownership explicit.** Every piece of state has exactly one owner. Hidden or duplicated state is where desync, save bugs, and "why did this change?" live.
- **Update order is a design decision.** Phases and priority are part of the architecture, not an accident of file order. Write the order down.
- **Boundaries must earn their cost.** A new system boundary costs serialization, sync, ordering, and tests. Add one to solve a concrete tuning, bug, or content problem—not to match a diagram.
- **Prefer composition of small systems over a monolithic manager.** A "GameManager" that knows everything is a symptom, not a pattern.
- **Data for content and tuning, code for behavior.** A config value with one consumer and no tuning need is a constant, not data.
- **Emergence from simple rules beats scripted special cases.** Every special case is a future bug and a future onboarding tax.

## Choose the simplest fitting structure

- **Flat systems over a shared world/context:** small games, few systems. Keep state and update near the loop.
- **Feature-local systems:** distinct responsibilities (combat, AI, economy) with private state and a small public API. Systems talk through that API, not by reaching into each other.
- **Layered simulation → rules → presentation:** use when rendering, input, and audio have genuinely different lifetimes from game state. Keep rules free of framework and render types.
- **ECS / data-oriented:** use when entity count and compositionality are real, measured problems. It is a trade-off in readability and debuggability, not a default.
- **Event bus / signals:** use when decoupling is real and ordering is understood. Document who emits, who listens, and in what phase. Untracked events become implicit control flow.
- **Dependency injection / service locator:** only at the composition root. Do not pass the container through gameplay code.

These can combine. Name systems and folders so a new contributor can tell what is simulated, what is rules, and what is presentation.

## Boundaries and coupling

- Systems communicate via explicit interfaces, queries, or events—not by importing another system's state.
- Prefer one-way data flow: presentation reads simulation, not the reverse. Input goes to simulation, not into UI logic.
- Shared mutable state is coupling. If two systems must mutate the same data, either one owns it and exposes commands, or the data is a message, not a shared field.
- Watch for cycles. A cycle between two systems usually means a missing concept that belongs in neither.
- Keep the public surface of each system small. A system that exports ten functions is probably doing ten jobs.
- Follow the repository's existing conventions before introducing a competing pattern.

## State and data flow

- Single source of truth for each value. Do not cache derived values unless recomputation is a measured hotspot.
- Make the update direction explicit: input → simulation → rules → presentation → UI/audio. Deviations from that order are worth a comment.
- Fixed timestep for simulation, variable for presentation, unless the game does not need it. Decide once and document it; mixing timesteps silently is a bug source.
- Randomness that affects gameplay goes through one seeded source per system, not ambient `random()` calls. This keeps bugs reproducible.
- Snapshot and rollback only when the game needs them (replays, multiplayer, time travel). They constrain RNG, iteration order, and float determinism—decide early.

## Data-driven vs code

- Data-driven fits content and tuning: stats, curves, tables, recipes, dialogue, spawn lists. Code fits behavior, rules, and invariants.
- Validate data at load. Fail with the path and the offending value; do not silently fall back to defaults that hide content bugs.
- A schema or editor is a cost. Adopt it when non-programmers author content or the volume justifies it—not for ten hand-edited rows.
- Keep data near the system that owns it. A global config dump for unrelated systems is a coupling magnet.

## Emergence and feedback

- Emergence comes from simple rules that interact, not from many independent scripts. Prefer rules that compose.
- Identify positive feedback loops (snowballing) and add negative ones (diminishing returns, upkeep, counters, soft caps) deliberately—not as afterthoughts when the game breaks.
- Randomness and hidden state create emergence but hurt determinism and tests. Make the trade-off explicit in the design, not discovered later in bug reports.
- When you are tempted to add a special case, check whether the underlying rules can express it. A special case per exception does not scale.

## Observability

- Log system transitions and boundary events, not every frame. Add debug views of state for the systems you are tuning.
- Telemetry on player behavior is design data. Make it opt-in, privacy-aware, and cheap to disable.
- Save/load bugs are system-boundary bugs. Test round-trips of the state a system owns, not the whole world.

## Structural-change checklist

1. What concrete tuning, bug, or content pain does this str[118;1:3uucture solve?
2. Is state ownership clear, and is update order documented?
3. Any cycles, private deep imports, or shared mutable state between systems?
4. Does each new abstraction earn its serialization, sync, and test cost?
5. Can the problem be solved incrementally, without a broad migration?

If no concrete benefit can be named, keep the simpler structure.

## Quick check

Before finishing a systems pass: Is each system's job and state owner clear? Is the update order written down? Are boundaries paid for? Is data validated at load? Are feedback loops deliberate? Did this change create a cycle or a special case that a rule could have expressed?

If you cannot name the pain the new structure solves, it is not ready—go back to the simplest one that works.
