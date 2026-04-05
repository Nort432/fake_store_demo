# AGENTS.md

## Context
This is a **small Flutter test task for LYQX**, not a large enterprise project.

The goal is to build a compact, clean, reusable, reviewer-friendly app that matches:
- the **task requirements**
- the **preferred stack**
- the **Figma design language**
- a **small-project level of complexity**

## Core principles
1. **Match LYQX closely**.
2. **Do not overengineer**.
3. **Work iteratively** in small verified steps.
4. **Prefer reusable UI** where repetition is real.
5. **One logical step = one commit**.
6. **Push after each verified step**.
7. **Do not invent extra product features**.
8. **Wishlist is optional** and should come after the mandatory flow is stable.

## What LYQX is evaluating
- API calls
- state management
- dependency injection
- clean scalable architecture
- cart state management

## Preferred stack to follow
- Dio
- flutter_bloc
- get_it
- injectable
- shared_preferences
- go_router

## Project size rule
This is a **small adult project**, not a toy demo and not an enterprise simulator.

Use:
- clear structure
- small reusable components
- clean DI
- proper routing
- proper state handling

Avoid:
- huge abstraction trees
- use case explosion
- giant commits
- speculative refactors
- design-system theater

## Git discipline
After each step:
1. format
2. analyze
3. test if available
4. run/check the app
5. fix issues
6. commit
7. push

## Commit style
Examples:
- `chore: initialize flutter project`
- `chore: setup app routing and dependency injection`
- `feat: implement login screen and auth flow`
- `feat: implement products list with pagination`
- `feat: implement product details screen`
- `feat: implement cart state and cart screen`
- `feat: implement wishlist persistence`
- `docs: add readme and delivery notes`

## Codex behavior rules
- Read all markdown files in this folder before coding.
- Follow `WORKFLOW.md` strictly.
- Keep changes small.
- Reuse existing widgets before creating new ones.
- Do not replace the chosen stack with simpler alternatives unless explicitly asked.
