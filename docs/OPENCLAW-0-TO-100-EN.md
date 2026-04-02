# 🦞 OpenClaw: Complete Guide 0 → 100%

**Version:** 1.0 | **Updated:** April 2026 | **OpenClaw:** v2026.4.2+

> **Created by:** Friday Assistant (@Fridayassis_bot)  
> **For:** @azazelpy (R N)  
> **Creation Date:** 2026-04-02  
> **Inspired by:** openclaw-ops by @cathrynlavery

---

## Table of Contents

1. [Initial Installation](#1-initial-installation)
2. [Basic Configuration](#2-basic-configuration)
3. [Models and APIs](#3-models-and-apis)
4. [Communication Channels](#4-communication-channels)
5. [Essential Skills](#5-essential-skills)
6. [Operations and Monitoring](#6-operations-and-monitoring)
7. [Security and Hardening](#7-security-and-hardening)
8. [Maintenance](#8-maintenance)
9. [Troubleshooting](#9-troubleshooting)
10. [Final Checklist](#10-final-checklist)

---

## 1. Initial Installation

### Prerequisites

| Tool | Version | Command |
|------|---------|---------|
| Node.js | 22.16+ or 24 | `node --version` |
| npm/pnpm/bun | Latest | `npm --version` |
| Git | Latest | `git --version` |
| Python 3 | 3.9+ | `python3 --version` |

### Installation

```bash
# Install OpenClaw globally
npm install -g openclaw@latest

# Or with pnpm (recommended)
pnpm add -g openclaw@latest

# Verify installation
openclaw --version
```

### Onboarding

```bash
# Interactive setup assistant
openclaw onboard --install-daemon

# This configures:
# - Gateway daemon
# - Initial workspace
# - Environment variables
# - Auto-start daemon
```

### Initial Verification

```bash
# Gateway status
openclaw gateway status

# General status
openclaw status

# View logs in real-time
tail -f ~/.openclaw/logs/gateway.log
```

---

## 2. Basic Configuration

### Directory Structure

```
~/.openclaw/
├── openclaw.json          # Main configuration
├── workspace/             # Your workspace
│   ├── SOUL.md           # Agent personality
│   ├── AGENTS.md         # Workspace conventions
│   ├── MEMORY.md         # Long-term memory
│   ├── memory/           # Daily notes
│   ├── tasks/            # Task management
│   └── skills/           # Custom skills
├── skills/                # Installed skills
└── logs/                  # System logs
```

### Minimum Configuration (openclaw.json)

```json5
{
  "agent": {
    "model": "modelstudio/qwen3.5-plus"
  },
  "providers": {
    "nvidia": {
      "apiKey": "nvapi-xxxxx",
      "baseUrl": "https://integrate.api.nvidia.com/v1"
    },
    "modelstudio": {
      "apiKey": "sk-xxxxx",
      "baseUrl": "https://dashscope.aliyuncs.com/compatible-mode/v1"
    }
  },
  "env": {
    "EXA_API_KEY": "xxxxx"
  },
  "security": {
    "actionApproval": {
      "required": ["email.send", "file.delete", "shell.exec"]
    }
  }
}
```

### Environment Variables (.zshenv or .bashrc)

```bash
# NVIDIA NIM (FREE tier)
export NVIDIA_API_KEY="nvapi-xxxxx"

# Alibaba DashScope
export DASHSCOPE_API_KEY="sk-xxxxx"

# MiniMax
export MINIMAX_API_KEY="xxxxx"

# Exa AI (web searches)
export EXA_API_KEY="xxxxx"
```

---

## 3. Models and APIs

### Recommended Providers

| Provider | Model | Context | Cost | Use |
|----------|-------|---------|------|-----|
| **NVIDIA NIM** | minimax-m2.5 | 32K | FREE | Daily |
| **Alibaba** | qwen3.5-plus | 256K | ~$0.10/1M | Production |
| **Alibaba** | qwen-plus | 128K-1M | ~$0.40/1M | Long docs |
| **Alibaba** | qwen-turbo | 128K | ~$0.05/1M | Fast |
| **Local** | qwen3.5:9b | 32K | FREE | Offline |

### Fallback Chain

```javascript
MODELS = [
    "minimaxai/minimax-m2.5",            // PRIMARY
    "nvidia/nemotron-4-340b-instruct",   // Fallback 1
    "deepseek-ai/deepseek-r1-distill-qwen-32b",  // Fallback 2
    "meta/llama-3.1-70b-instruct",       // Fallback 3
]
```

### Estimated Monthly Cost (100K tokens/day)

| Provider | Cost/Mo |
|----------|---------|
| NVIDIA NIM | $0.00 |
| Alibaba Qwen | ~$0.50 |
| **TOTAL** | **~$0.50** |

---

## 4. Communication Channels

### Supported Channels

- ✅ Telegram
- ✅ Discord
- ✅ WhatsApp
- ✅ Slack
- ✅ Signal
- ✅ iMessage (macOS)
- ✅ Google Chat
- ✅ IRC
- ✅ Matrix
- ✅ LINE

### Telegram Configuration (Example)

```json5
{
  "channels": {
    "telegram": {
      "botToken": "xxxxx:xxxxx",
      "allowedChats": ["-1003742752506"]
    }
  }
}
```

### Channel Diagnostics

```bash
# List channels
openclaw channels list

# Test connection
openclaw channels test telegram
```

### Common Issues

| Channel | Issue | Solution |
|---------|-------|----------|
| Slack | `missing_scope` | Renew token with correct scopes |
| WhatsApp | Disconnection | Use Bun instead of Node |
| Telegram | Not responding | Verify bot token |
| iMessage | No access | Enable Full Disk Access |
| Discord | WebSocket 1005/1006 | Restart gateway |

---

## 5. Essential Skills

### Skill Installation

```bash
# Official skills
openclaw skills install weather
openclaw skills install github
openclaw skills install summarize

# Third-party skills (audit first!)
git clone https://github.com/cathrynlavery/openclaw-ops.git ~/.openclaw/skills/openclaw-ops
```

### Recommended Skills

| Skill | Purpose | Priority |
|-------|---------|----------|
| `openclaw-ops` | Monitoring & health | **Critical** |
| `skill-vetter` | Skill security audit | **Critical** |
| `weather` | Weather & forecasts | High |
| `github` | Issues/PRs management | High |
| `summarize` | Summarize URLs/transcripts | High |
| `healthcheck` | Security hardening | High |
| `model-usage` | Cost tracking | Medium |
| `memory` | Memory management | Medium |

### Skill Audit (MANDATORY)

```bash
# Before installing any third-party skill
cd ~/.openclaw/skills/openclaw-ops
bash scripts/skill-audit.sh <skill-path>

# Check for red flags:
# - Hardcoded secrets
# - Suspicious network calls
# - Prompt injection patterns
```

---

## 6. Operations and Monitoring

### openclaw-ops: Essential Scripts

| Script | Purpose | Frequency |
|--------|---------|-----------|
| `heal.sh` | Auto-repair | On-demand |
| `watchdog.sh` | Continuous monitoring | Every 5 min |
| `check-update.sh` | Post-update triage | Post-update |
| `security-scan.sh` | Security audit | Weekly |
| `health-check.sh` | Health checks | Hourly |

### Watchdog Installation (macOS)

```bash
cd ~/.openclaw/skills/openclaw-ops
bash scripts/watchdog-install.sh

# View logs
tail -f ~/.openclaw/logs/watchdog.log

# View incidents
cat ~/.openclaw/logs/heal-incidents.jsonl
```

### Watchdog on Linux (cron)

```bash
# Edit crontab
crontab -e

# Add every 5 minutes
*/5 * * * * bash /path/to/scripts/watchdog.sh >> ~/.openclaw/logs/watchdog.log 2>&1
```

### Health Targets (health-targets.conf)

```bash
# Copy template
cp templates/health-targets.conf.example ~/.openclaw/health-targets.conf

# Example configuration
gateway http://localhost:18789/health 300
knowledge http://localhost:8001/health 300
ops http://localhost:8002/health 300
```

### Run Health Check

```bash
cd ~/.openclaw/skills/openclaw-ops
bash scripts/health-check.sh --verbose
```

---

## 7. Security and Hardening

### Security Scan

```bash
cd ~/.openclaw/skills/openclaw-ops
bash scripts/security-scan.sh

# Generates report with:
# - Hardening score (0-100)
# - Exposed credentials
# - File permissions
# - Insecure configuration
```

### Hardening Checklist

- [ ] `auth: "none"` removed (v2026.1.29+)
- [ ] API keys in environment variables, NOT in config
- [ ] `tools.exec.ask` and `tools.exec.security` configured
- [ ] Third-party skills audited before install
- [ ] Correct file permissions (600 for secrets)
- [ ] No secrets in logs or history
- [ ] Firewall configured for gateway
- [ ] Tailscale/SSH tunneled for remote access

### Critical CVEs (v2026.2.12+)

| CVE | Description | Impact |
|-----|-------------|--------|
| CVE-2026-25253 | RCE via token leakage | **Critical** |
| SSRF-2026-001 | SSRF in MCP tools | High |
| PATH-2026-002 | Path traversal | High |
| PROMPT-2026-003 | Prompt injection | Medium |

**⚠️ Minimum version: v2026.2.12**

### File Permissions

```bash
# Config with secrets
chmod 600 ~/.openclaw/openclaw.json

# Executable scripts
chmod 755 ~/.openclaw/skills/*/scripts/*.sh

# Logs (read-only for user)
chmod 644 ~/.openclaw/logs/*.log
```

---

## 8. Maintenance

### Daily (Automatic via Heartbeat)

- [ ] Check urgent emails
- [ ] Check calendar (next 24-48h)
- [ ] Check notifications
- [ ] Rotate logs if >100MB

### Weekly

```bash
# Security scan
cd ~/.openclaw/skills/openclaw-ops
bash scripts/security-scan.sh

# Skill audit (if installed new skills)
bash scripts/skill-audit.sh ~/.openclaw/skills/<new-skill>

# Clean sessions
openclaw sessions prune --older-than 7d
```

### Monthly

- [ ] Review MEMORY.md and curate insights
- [ ] Update openclaw: `openclaw update`
- [ ] Run `check-update.sh` post-update
- [ ] Review API costs
- [ ] Backup workspace and config

### Post-Update Triage

```bash
cd ~/.openclaw/skills/openclaw-ops

# Report only
bash scripts/check-update.sh

# Report + auto-fix
bash scripts/check-update.sh --fix
```

### Common Post-Update Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Gateway won't start | `auth: "none"` removed | Configure valid auth |
| Agents blocked | Exec approvals reset | Re-configure allowlists |
| Channels offline | Expired tokens | Renew tokens |
| Skills failing | Breaking changes | Review changelog |

---

## 9. Troubleshooting

### Gateway Down

```bash
# Check status
openclaw gateway status

# View error logs
tail -100 ~/.openclaw/logs/gateway.err.log

# Try restart
openclaw gateway restart

# If fails, run heal
cd ~/.openclaw/skills/openclaw-ops
bash scripts/heal.sh
```

### Agents Stuck on /approve

```bash
# Check exec config
openclaw config get tools.exec

# Common fix: empty allowlist shadowing wildcard
# Edit ~/.openclaw/openclaw.json and remove empty entries
```

### Channels Not Responding

```bash
# List channels
openclaw channels list

# Test individual
openclaw channels test telegram

# View channel logs
tail -f ~/.openclaw/logs/channels.log
```

### Memory Full / Context Overflow

```bash
# Check context usage
openclaw status

# Compact conversation
openclaw sessions compact

# Prune old sessions
openclaw sessions prune --older-than 7d
```

### Diagnostic Commands

```bash
# Full status
openclaw status

# Version
openclaw --version

# Doctor (automatic diagnosis)
openclaw doctor

# List active sessions
openclaw sessions list

# View logs live
tail -f ~/.openclaw/logs/gateway.log
```

---

## 10. Final Checklist

### Installation ✅

- [ ] Node.js 22.16+ or 24 installed
- [ ] OpenClaw installed globally
- [ ] Gateway daemon running
- [ ] Workspace initialized

### Configuration ✅

- [ ] openclaw.json configured
- [ ] Environment variables in .zshenv/.bashrc
- [ ] Models configured with fallback
- [ ] At least 1 channel connected and tested

### Skills ✅

- [ ] openclaw-ops installed
- [ ] skill-vetter installed
- [ ] watchdog installed (LaunchAgent or cron)
- [ ] Basic skills installed (weather, github, summarize)

### Security ✅

- [ ] Security scan executed (score >80)
- [ ] API keys in env vars, not in config
- [ ] Correct file permissions
- [ ] Third-party skills audited

### Monitoring ✅

- [ ] Watchdog running
- [ ] Health targets configured
- [ ] Logs being rotated
- [ ] Alerts configured (Signal/Telegram)

### Maintenance ✅

- [ ] Heartbeat configured
- [ ] Automatic backup configured
- [ ] Documentation updated
- [ ] MEMORY.md being curated

---

## 📞 Support and Resources

| Resource | URL |
|----------|-----|
| Official Docs | https://docs.openclaw.ai |
| GitHub | https://github.com/openclaw/openclaw |
| Discord | https://discord.com/invite/clawd |
| ClawHub (skills) | https://clawhub.ai |
| openclaw-ops | https://github.com/cathrynlavery/openclaw-ops |

---

## 🎯 Next Steps

1. **Day 1:** Installation + basic config + 1 channel
2. **Day 2:** Install openclaw-ops + watchdog
3. **Day 3:** Security scan + hardening
4. **Day 4:** Configure heartbeat + automations
5. **Day 5:** Full testing + documentation

---

*Guide created for OpenClaw production setup. Update according to new versions.*

---

## 👤 Authorship

| Role | Responsible |
|------|-------------|
| **Created by** | Friday Assistant (@Fridayassis_bot) |
| **For** | @azazelpy (R N) |
| **Date** | 2026-04-02 |
| **Group** | AI multiverse (Telegram) |
| **Inspired by** | openclaw-ops by @cathrynlavery |

---

**Last update:** 2026-04-02  
**OpenClaw version:** v2026.4.2  
**openclaw-ops version:** Latest (cathrynlavery)
