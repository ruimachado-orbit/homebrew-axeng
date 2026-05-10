# Homebrew Tap — Axeng

Install [Axeng](https://github.com/ruimachado-orbit/axeng) via Homebrew in one command:

```bash
brew tap ruimachado-orbit/axeng
brew install axeng
```

## What is Axeng?

**Engineering Manager Accelerator** — an open-source autonomous AI chief of staff that runs on your Mac Mini ($200 hardware). Monitors GitHub, Linear, calendar, and team activity — generates standups, 1:1 pre-reads, sprint reports, risk alerts, team sync, and offboarding automatically.

See [axeng/README.md](https://github.com/ruimachado-orbit/axeng) for full feature list.

## Quick Start

```bash
# 1. Install
brew tap ruimachado-orbit/axeng
brew install axeng

# 2. Configure — edit the config files
vim $(brew --prefix)/opt/axeng/config/config.yaml
cp $(brew --prefix)/opt/axeng/.env.example .env  # then add your API keys

# 3. Start
axeng

# 4. Open browser → http://localhost:8501
```

## Commands

| Command | Description |
|---------|-------------|
| `axeng` | Start Axeng (docker compose up -d) |
| `axeng-stop` | Stop Axeng |
| `axeng-logs` | View live logs |
| `axeng-update` | Pull latest + rebuild |

## Requirements

- **macOS or Linux** with Homebrew installed
- **Docker** (installed automatically as a dependency)
- API keys: `LINEAR_API_KEY`, `GITHUB_TOKEN`, `ANTHROPIC_API_KEY` (or `OPENAI_API_KEY`)

## Uninstall

```bash
brew uninstall axeng
brew untap ruimachado-orbit/axeng
```

---

*Official Homebrew tap for [ruimachado-orbit/axeng](https://github.com/ruimachado-orbit/axeng) — MIT licensed.*