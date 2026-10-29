---
name: game-balance
description: "Use when tuning numbers, curves, progression rates, economy, combat math, or difficulty in a game, and when validating balance with sims, spreadsheets, telemetry, or playtests. Covers formulas, sources and sinks, breakpoints, and common failure modes. Do not load for design of the core loop (game-design) or for system structure and data flow (game-systems)."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Game Balance

Balance is the set of numbers and rules that make intended decisions feel meaningful. Optimize for the player's experience of choice and pacing, not for a symmetric table. Measure before you tune; tune before you spec.

## Defaults

- **Balance serves a design goal, not symmetry.** Name the intended experience (brutal, generous, tense, relaxing) before touching numbers. "Balanced" without a target is undefined.
- **Tune the lever, not the symptom.** When one value is wrong, find the input that produced it. Patching outputs multiplies special cases.
- **Change one variable at a time.** Batch unrelated tuning and you cannot attribute the result.
- **Prefer curves to tables for anything that scales.** A formula documents intent and extrapolates; a hand-tuned table hides both.
- **Prefer breakpoints to smooth dials when the decision is discrete.** Players reason in thresholds ("can I survive two hits?"), not in decimals.
- **Numbers are hypotheses.** A value is not "right" until it survives contact with a player, a sim, or a build. State the assumption.
- **Do not balance around the mean.** The median player and the top 1% need different curves. Decide which one you are tuning for.

## Curves and progression

- Every curve has a domain, a shape, and a reason. Linear, polynomial, exponential, and logarithmic curves imply different player experiences—choose deliberately.
- Exponential curves require a matching exponential reward, or progression stalls. If costs grow exponentially and income does not, the game has a wall, not a curve.
- Time-to-power should fit the session. A curve that pays off after a session the player cannot see is a retention bug.
- Diminishing returns are a soft cap, not a hard one. A hard cap communicates an end; a soft cap communicates a trade-off.
- Prefer piecewise curves with named phases (early, mid, late) over a single formula stretched across the whole game. Document the phase boundaries.
- Watch the derivative, not just the value. A curve that is smooth but flat at the level the player spends most time at is boring, even if "correct".

## Combat and encounter math

- Define time-to-kill (TTK) explicitly for the intended encounter. TTK sets the feel of combat more than any single damage number.
- Separate **effective** and **nominal** values. Armor, resistances, crits, and hit chance change the effective number; tune one layer at a time.
- Hit chance, crit, and damage reduction interact multiplicatively. Do not eyeball the product—compute the effective DPS at the level the player actually is.
- Randomness in combat is a feel tool (variance, tension) and a balance hazard (streaks, unlucky deaths). Bound it with pity, guaranteed hits, or distributions that rarely produce outliers.
- Encounter difficulty is not one number. Separate stat difficulty (HP, damage), mechanical difficulty (patterns, timing), and information difficulty (what the player can know). Tune the one that actually causes failure.
- Breakpoints in damage or HP create discrete power spikes. If crossing one breakpoint flips an encounter from impossible to trivial, that breakpoint is a design decision, not an accident.

## Economy

- Every resource has a source, a sink, and a rate. Missing any of the three is the bug. Name them before tuning.
- Sinks must scale with sources, or the economy inflates. Inflation is not a currency problem; it is a sink problem.
- Prefer sinks that are also decisions (upgrades, trade-offs, risk) over sinks that are taxes (repair bills, fees). Taxes feel like friction.
- Track the **time-to-afford** for the next meaningful purchase. If it grows faster than session length, the player disengages before the payoff.
- Watch for rich-get-richer loops. Add parallel goals, catch-up rates, or soft caps when the curve snowballs.
- Reward magnitude and reward frequency are separate dials. A small frequent reward and a large rare reward shape different behavior—choose the one that matches the intended session.
- When the economy can be simulated, simulate it. A few thousand agent-runs expose inflation and starvation faster than a spr[118;1:3ueadsheet.

## Difficulty and pacing

- Difficulty is a curve, not a setting. The first hour and the twentieth hour should not be tuned with the same number.
- Teach with a safe encounter, then test with a fair one, then reward with a demanding one. Difficulty that arrives before mastery is frustration; after, it is boredom.
- The perceived difficulty is the gap between required skill and current skill. Raise both or the game becomes either trivial or unfair.
- Failure should cost time, not progress. Loss that wipes progress teaches the player to avoid risk, which flattens the game.
- Difficulty options that only change HP and damage are the shallowest form. Prefer options that change rules (information, timing, resource pressure) when the design allows.

## Tuning tools and iteration

- Use a spreadsheet or script for exploration; use the game for feel. Do not tune feel in a spreadsheet or exploration in a build.
- Keep a tuning log: what changed, why, and what it falsified. Untracked iteration is tinkering.
- When a value is read from data, validate at load: range, type, and invariant. Silent fallbacks hide balance bugs as content bugs.
- Prefer a small set of named constants over magic numbers scattered in code, even for balance values. Named constants document intent.
- Telemetry on player behavior is balance data. Make it opt-in, privacy-aware, and cheap to disable; do not let it become a substitute for playtests.
- Sims and bots are useful for throughput and rough bounds, not for feel. A bot that wins does not mean the fight is fun.

## Common failure modes

- **Power creep.** New content must be at least as strong to sell. Counter it with horizontal progression, sidegrades, and rebalances—not with a bigger number every patch.
- **Dead stats.** A stat nobody picks is either hidden, weak, or dominated. Remove it or make it the correct choice in a real situation.
- **Dominant strategy.** If one option wins without a cost, the rest is content, not a choice. Add a cost, a counter, or a niche.
- **Breakpoint cliffs.** A single point of damage or HP flipping an encounter from impossible to trivial. Smooth it or make the breakpoint the point.
- **Mystery numbers.** Values with no stated reason. Keep a one-line "why" next to every tuned constant; future you will need it.
- **Balancing around the tutorial.** Early-game numbers that only work because the player has no options yet. Test with the full kit.
- **Averages hiding tails.** A mean that looks fine while the 5th and 95th percentiles are broken. Always look at the distribution.

## Validation

- State the hypothesis before the test: what value, what behavior, what would falsify it.
- Use the cheapest evidence that answers the question: a spreadsheet for ranges, a sim for throughput, a playtest for feel, telemetry for scale.
- A playtest with one player is an anecdote; three with the same reaction is a signal. Do not retune on a single session.
- For a balance bug, add a regression check when practical (a sim range, a unit test on a formula, a snapshot of a key derived value).
- Report what was tuned, what was verified, and what remains a guess. Do not present a tuned constant as a validated one.

## Quick check

Before finishing a balance pass: Is the intended experience named? Does each tuned number have a reason and a lever? Are sources, sinks, and rates defined for the economy? Is the effective (not nominal) value what the player feels? Is there a next experiment, and what would falsify it?

If you cannot name the player behavior a number is meant to produce, it is not balanced—it is just a number.
