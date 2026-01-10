---
name: create-cli-tool
description: Craft or refactor a CLI interface and behavior using the CLI Guidelines. Use when defining a new CLI spec or reshaping an existing command surface: arguments, flags, subcommands, help text, outputs, errors, exit codes, prompts, config/env precedence, and safe/dry-run behavior.
---

# Create CLI Tool

Shape a CLI that feels good for people and predictable for scripts.

## Start Here

- Read `references/cli-guidelines.md` and treat it as the default rubric.
- Consider upstream guidance at https://clig.dev/ when resolving tradeoffs.
- Ask only the minimum questions needed to lock the interface.
- Design forward only. Do not preserve legacy behavior unless the user asks.

## Quick Clarify

Ask, then proceed with sensible defaults if unclear:

- Command name and single-sentence purpose.
- Primary audience: humans, scripts, or both.
- Inputs: flags/args vs stdin; files vs URLs; secrets never via flags.
- Outputs: human text, structured (`--json`), or stable line text (`--plain`).
- Interactivity: prompts allowed; need `--no-input`; confirmations for destructive ops.
- Configuration: flags vs env vs config file; precedence model; XDG vs repo-local.
- Runtime constraints: OS targets; single binary or runtime required.

## What to Deliver

Produce a compact, implementation-ready spec:

- Command tree plus USAGE synopsis.
- Full args/flags table: type, default, required, examples.
- Subcommand behavior: inputs, outputs, side effects, idempotence.
- Output rules: stdout vs stderr, TTY detection, `--json`/`--plain`, `--quiet`/`--verbose`.
- Error taxonomy and exit codes for common failures.
- Safety controls: `--dry-run`, confirmations, `--force`, `--no-input`.
- Config/env rules and precedence (flags > env > project config > user config > system).
- Shell completion approach if relevant.
- 5-10 example invocations, including stdin/pipes.

## Defaults Unless Overridden

- `-h/--help` prints help and ignores other flags.
- `--version` prints to stdout.
- Primary data to stdout; diagnostics to stderr.
- Provide `--json` for machine output; add `--plain` for stable line output when useful.
- Prompt only if stdin is a TTY; `--no-input` disables prompts.
- Destructive operations require explicit confirmation or `--force` for non-interactive runs.
- Respect `NO_COLOR` and `TERM=dumb`; provide `--no-color`.
- Handle Ctrl-C with fast exit and minimal cleanup.

## Spec Template

Fill only what applies:

1. **Name**: `mycmd`
2. **One-liner**: `...`
3. **USAGE**:
   - `mycmd [global flags] <subcommand> [args]`
4. **Subcommands**:
   - `mycmd init ...`
   - `mycmd run ...`
5. **Global flags**:
   - `-h, --help`
   - `--version`
   - `-q, --quiet` / `-v, --verbose` (define exactly)
   - `--json` / `--plain` (if applicable)
6. **I/O contract**:
   - stdout:
   - stderr:
7. **Exit codes**:
   - `0` success
   - `1` generic failure
   - `2` invalid usage (parse/validation)
   - (add command-specific codes only when actually useful)
8. **Env/config**:
   - env vars:
   - config file path + precedence:
9. **Examples**:
   - ...

## Notes

- Keep it language-agnostic unless asked to recommend a parser library.
- If the request is only about parameters, avoid implementation details.
