---
name: game-design
description: "Use when designing or reviewing game mechanics, core loops, progression, economy, player experience, or scope. Covers prototyping, balance, playtesting, and design documentation. Do not activate for pure implementation tasks with no design decisions."
license: MIT
metadata:
  author: Vladimir Volkov (ff34d)
  version: 1.0
---

# Game Design

Design for a specific player doing a specific thing, not for a document. The goal is a playable, testable experience—not a complete spec. Project constraints and player experience take precedence over genre conventions or tooling preferences.

## Defaults

- **Start from the player experience.** Name the moment the player should feel (tension, mastery, discovery, relief, loss). If you cannot describe it in one sentence, the mechanic is not ready to implement.
- **Prototype before specifying.** A gray-box or paper test answers more questions than another paragraph of design doc. Specify only what the prototype cannot answer.
- **Design the core loop first.** Every feature must feed, deepen, or extend the loop. Cut features that do not.
- **Prefer fewer mechanics, deeper.** Depth comes from interactions between simple rules, not from the number of systems. Two verbs that combine beat five that do not.
- **Make the interesting decision obvious.** Each mechanic should create a choice with a real trade-off. If the optimal move is always the same, the mechanic is a gate, not a decision.
- **Tune with numbers, feel with hands.** Use values to find the range; use the controller to find the feel. A mathematically balanced mechanic can still feel wrong.
- **Scope to the team, not the prototype.** Every mechanic costs content, tuning, UI, audio, QA, and onboarding. Estimate the real cost.
- **Separate fantasy from mechanics.** The fantasy sells the loop; the loop must stand on its own. Do not hide weak mechanics behind strong art or lore.

## Core loop

- Write the loop as a cycle: intent → action → feedback → reward → next intent. If any step is unclear or unrewarding, the loop leaks.
- Nest three scales: a moment-to-moment loop (seconds), a session loop (minutes), a progression loop (hours). Each should give the player a reason to continue to the next scale.
- The first five minutes must teach the loop, show the fantasy, and give one satisfying win. Do not hide the fun behind onboarding.
- Failure should be informative and recoverable. If losing teaches nothing or costs too much, players stop taking risks and the loop stalls.
- Feedback must be immediate and legible. A hit that does not read as a hit is a bug, not a polish item.

## Mechanics and systems

- Each system has an input, a process, and an output the player can perceive. Systems the player never perceives are overhead, not depth.
- Prefer verbs to menus. Player agency should show up in play, not in a screen the player reads once.
- Define the dominant strategy before adding counters. If one option wins without a cost, the rest are content, not choices.
- Use hard and soft counters deliberately. Hard counters (rock-paper-scissors) are simple and legible; soft counters (ratios, timing, positioning) are deeper but need tuning.
- Randomness is a tool: it adds variance, replayability, and risk. Do not use it to hide weak decisions. Pity timers and guaranteed outcomes are valid but must be visible or documented.
- A new mechanic must earn its UI. If the player needs a tooltip to understand it, either simplify the mechanic or commit to teaching it in play.

## Economy and progression

- Every resource has a source, a sink, and a rate. If one is missing, the economy is either inflationary or starved.
- Progression should unlock decisions, not just numbers. "+5% damage" is a delay; "choose between two paths" is a decision.
- Time-to-power should match the session length. Do not gate the fun behind a grind the player cannot see the end of.
- Watch for the rich-get-richer loop. Add catch-up mechanics or parallel goals when the curve snowballs.

## Scope and production

- Cut in this order: features that do not feed the loop, content for cut features, polish for cut content.
- A vertical slice means one fully polished loop, not one of each system. Prove the loop before you spread across systems.
- Write the minimum design doc: fantasy, loop, verbs, win/lose, progression, open questions. Keep it near the code or prototype it describes.
- Mark assumptions, unknowns, and the next experiment. A design doc is a plan for testing, not a commitment.
- When design and code disagree, resolve the player experience first, then the implementation. Do not let the architecture decide what the game is.

## Playtesting

- Test the question, not the build. Write down what you want to learn before the session.
- Watch the player, not the screen. Note where they hesitate, misread, or stop having fun.
- One playtester is an anecdote; three with the same confusion is a pattern. Fix the pattern, not the anecdote.
- Do not explain the design during a test. If it needs an explanation, the game is not teaching it.
- Record what changed after each test and what it falsified. Untracked iteration is just tinkering.

## Quick check

Before finishing a design pass: Is the core loop named and playable? Does each mechanic create a decision? Is the economy sourced and sunk? Is the scope honest? What is the next experiment, and what will it falsify?

If you cannot answer the next experiment, the design is not ready—go prototype.
