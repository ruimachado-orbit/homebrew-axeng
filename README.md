# homebrew-axeng — Official Homebrew Tap for Axeng

## Install

```bash
brew install ruimachado-orbit/axeng/axeng
```

## What is Axeng?

**Engineering Manager Accelerator** — open-source autonomous AI chief of staff that runs 24/7 on any machine (even a $200 Mac Mini). Monitors GitHub, Linear, calendar, and team — generates standups, 1:1 pre-reads, sprint reports, risk alerts, team sync, and offboarding automatically.

See full README: [github.com/ruimachado-orbit/axeng](https://github.com/ruimachado-orbit/axeng)

---

## Quick Setup (3 steps)

```bash
# 1. Install
brew install ruimachado-orbit/axeng/axeng

# 2. Configure
AXENG_DIR=$(brew --prefix)/opt/axeng
cp "$AXENG_DIR/.env.example" "$AXENG_DIR/.env"
# Edit .env — add ANTHROPIC_API_KEY, LINEAR_API_KEY, GITHUB_TOKEN

cp "$AXENG_DIR/config/config.yaml.example" "$AXENG_DIR/config/config.yaml"
# Edit config/config.yaml — add your orgs, team, Linear projects

# 3. Start
axeng
open http://localhost:8501
```

## Commands

| Command | What it does |
|---------|-------------|
| `axeng` | Start Axeng (docker compose up -d) |
| `axeng-stop` | Stop Axeng |
| `axeng-logs` | View live logs |
| `axeng-update` | Pull latest + rebuild + restart |

## Required API Keys

Edit `.env` (from `brew --prefix`):
```bash
# LLM (Claude recommended)
ANTHROPIC_API_KEY=sk-ant-...

# GitHub — token OR run `gh auth login`
GITHUB_TOKEN=ghp_...

# Linear
LINEAR_API_KEY=lin_...

# Optional
TELEGRAM_BOT_TOKEN=...   # for daily briefings
NEWS_API_KEY=...         # world news in briefs
```

## Uninstall

```bash
brew uninstall axeng
brew untap ruimachado-orbit/axeng
```

---

*Official Homebrew tap for [ruimachado-orbit/axeng](https://github.com/ruimachado-orbit/axeng) — MIT licensed.*