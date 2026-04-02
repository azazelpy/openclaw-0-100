# 🦞 OpenClaw: Guía Completa 0 → 100%

**Versión:** 1.0 | **Actualizado:** Abril 2026 | **OpenClaw:** v2026.4.2+

> **Creado por:** Friday Assistant (@Fridayassis_bot)  
> **Para:** @azazelpy (R N)  
> **Fecha de creación:** 2026-04-02  
> **Inspirado en:** openclaw-ops de @cathrynlavery

---

## 📋 Índice

1. [Instalación Inicial](#1-instalación-inicial)
2. [Configuración Básica](#2-configuración-básica)
3. [Modelos y APIs](#3-modelos-y-apis)
4. [Canales de Comunicación](#4-canales-de-comunicación)
5. [Skills Esenciales](#5-skills-esenciales)
6. [Operaciones y Monitoreo](#6-operaciones-y-monitoreo)
7. [Seguridad y Hardening](#7-seguridad-y-hardening)
8. [Mantenimiento](#8-mantenimiento)
9. [Troubleshooting](#9-troubleshooting)
10. [Checklist Final](#10-checklist-final)

---

## 1. Instalación Inicial

### Requisitos Previos

| Herramienta | Versión | Comando |
|-------------|---------|---------|
| Node.js | 22.16+ o 24 | `node --version` |
| npm/pnpm/bun | Latest | `npm --version` |
| Git | Latest | `git --version` |
| Python 3 | 3.9+ | `python3 --version` |

### Instalación

```bash
# Instalar OpenClaw globalmente
npm install -g openclaw@latest

# O con pnpm (recomendado)
pnpm add -g openclaw@latest

# Verificar instalación
openclaw --version
```

### Onboarding

```bash
# Asistente interactivo de configuración
openclaw onboard --install-daemon

# Esto configura:
# - Gateway daemon
# - Workspace inicial
# - Variables de entorno
# - Daemon de inicio automático
```

### Verificación Inicial

```bash
# Estado del gateway
openclaw gateway status

# Estado general
openclaw status

# Ver logs en tiempo real
tail -f ~/.openclaw/logs/gateway.log
```

---

## 2. Configuración Básica

### Estructura de Directorios

```
~/.openclaw/
├── openclaw.json          # Configuración principal
├── workspace/             # Tu espacio de trabajo
│   ├── SOUL.md           # Personalidad del agente
│   ├── AGENTS.md         # Convenciones del workspace
│   ├── MEMORY.md         # Memoria a largo plazo
│   ├── memory/           # Notas diarias
│   ├── tasks/            # Gestión de tareas
│   └── skills/           # Skills personalizados
├── skills/                # Skills instalados
└── logs/                  # Logs del sistema
```

### Configuración Mínima (openclaw.json)

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

### Variables de Entorno (.zshenv o .bashrc)

```bash
# NVIDIA NIM (FREE tier)
export NVIDIA_API_KEY="nvapi-xxxxx"

# Alibaba DashScope
export DASHSCOPE_API_KEY="sk-xxxxx"

# MiniMax
export MINIMAX_API_KEY="xxxxx"

# Exa AI (búsquedas web)
export EXA_API_KEY="xxxxx"
```

---

## 3. Modelos y APIs

### Proveedores Recomendados

| Proveedor | Modelo | Contexto | Costo | Uso |
|-----------|--------|----------|-------|-----|
| **NVIDIA NIM** | minimax-m2.5 | 32K | FREE | Diario |
| **Alibaba** | qwen3.5-plus | 256K | ~$0.10/1M | Producción |
| **Alibaba** | qwen-plus | 128K-1M | ~$0.40/1M | Docs largos |
| **Alibaba** | qwen-turbo | 128K | ~$0.05/1M | Rápido |
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

### Costo Mensual Estimado (100K tokens/día)

| Proveedor | Costo/Mes |
|-----------|-----------|
| NVIDIA NIM | $0.00 |
| Alibaba Qwen | ~$0.50 |
| **TOTAL** | **~$0.50** |

---

## 4. Canales de Comunicación

### Canales Soportados

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

### Configuración de Telegram (Ejemplo)

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

### Diagnóstico de Canales

```bash
# Ver estado de canales
openclaw channels list

# Test de conexión
openclaw channels test telegram
```

### Problemas Comunes

| Canal | Problema | Solución |
|-------|----------|----------|
| Slack | `missing_scope` | Renovar token con scopes correctos |
| WhatsApp | Desconexión | Usar Bun en lugar de Node |
| Telegram | No responde | Verificar bot token |
| iMessage | Sin acceso | Activar Full Disk Access |
| Discord | WebSocket 1005/1006 | Reiniciar gateway |

---

## 5. Skills Esenciales

### Instalación de Skills

```bash
# Skills oficiales
openclaw skills install weather
openclaw skills install github
openclaw skills install summarize

# Skills de terceros (con audit previo)
git clone https://github.com/cathrynlavery/openclaw-ops.git ~/.openclaw/skills/openclaw-ops
```

### Skills Recomendados

| Skill | Propósito | Prioridad |
|-------|-----------|-----------|
| `weather` | Clima y pronósticos | Alta |
| `github` | Gestión de issues/PRs | Alta |
| `summarize` | Resumir URLs/transcripts | Alta |
| `openclaw-ops` | Monitoreo y salud | **Crítica** |
| `skill-vetter` | Auditoría de skills | **Crítica** |
| `healthcheck` | Hardening de seguridad | Alta |
| `model-usage` | Tracking de costos | Media |
| `memory` | Gestión de memoria | Media |

### Auditoría de Skills (OBLIGATORIO)

```bash
# Antes de instalar cualquier skill de terceros
cd ~/.openclaw/skills/openclaw-ops
bash scripts/skill-audit.sh <ruta-del-skill>

# Verificar red flags:
# - Hardcoded secrets
# - Llamadas de red sospechosas
# - Prompt injection patterns
```

---

## 6. Operaciones y Monitoreo

### openclaw-ops: Scripts Esenciales

| Script | Propósito | Frecuencia |
|--------|-----------|------------|
| `heal.sh` | Auto-reparación | On-demand |
| `watchdog.sh` | Monitoreo continuo | Cada 5 min |
| `check-update.sh` | Triage post-update | Post-update |
| `security-scan.sh` | Auditoría seguridad | Semanal |
| `health-check.sh` | Health checks | Cada hora |

### Instalación del Watchdog (macOS)

```bash
cd ~/.openclaw/skills/openclaw-ops
bash scripts/watchdog-install.sh

# Ver logs
tail -f ~/.openclaw/logs/watchdog.log

# Ver incidentes
cat ~/.openclaw/logs/heal-incidents.jsonl
```

### Watchdog en Linux (cron)

```bash
# Editar crontab
crontab -e

# Agregar cada 5 minutos
*/5 * * * * bash /path/to/scripts/watchdog.sh >> ~/.openclaw/logs/watchdog.log 2>&1
```

### Health Targets (health-targets.conf)

```bash
# Copiar plantilla
cp templates/health-targets.conf.example ~/.openclaw/health-targets.conf

# Ejemplo de configuración
gateway http://localhost:18789/health 300
knowledge http://localhost:8001/health 300
ops http://localhost:8002/health 300
```

### Ejecutar Health Check

```bash
cd ~/.openclaw/skills/openclaw-ops
bash scripts/health-check.sh --verbose
```

---

## 7. Seguridad y Hardening

### Security Scan

```bash
cd ~/.openclaw/skills/openclaw-ops
bash scripts/security-scan.sh

# Genera reporte con:
# - Score de hardening (0-100)
# - Credenciales expuestas
# - Permisos de archivos
# - Configuración insegura
```

### Hardening Checklist

- [ ] `auth: "none"` eliminado (v2026.1.29+)
- [ ] API keys en variables de entorno, NO en config
- [ ] `tools.exec.ask` y `tools.exec.security` configurados
- [ ] Skills de terceros auditados antes de instalar
- [ ] Permisos de archivos correctos (600 para secrets)
- [ ] No secrets en logs o history
- [ ] Firewall configurado para gateway
- [ ] Tailscale/SSH tunneled para acceso remoto

### CVE Críticos (v2026.2.12+)

| CVE | Descripción | Impacto |
|-----|-------------|---------|
| CVE-2026-25253 | RCE via token leakage | **Crítico** |
| SSRF-2026-001 | SSRF en MCP tools | Alto |
| PATH-2026-002 | Path traversal | Alto |
| PROMPT-2026-003 | Prompt injection | Medio |

**⚠️ Versión mínima: v2026.2.12**

### Permisos de Archivos

```bash
# Config con secrets
chmod 600 ~/.openclaw/openclaw.json

# Scripts ejecutables
chmod 755 ~/.openclaw/skills/*/scripts/*.sh

# Logs (solo lectura para usuario)
chmod 644 ~/.openclaw/logs/*.log
```

---

## 8. Mantenimiento

### Diario (Automático via Heartbeat)

- [ ] Check de emails urgentes
- [ ] Check de calendario (próximas 24-48h)
- [ ] Check de notificaciones
- [ ] Rotación de logs si >100MB

### Semanal

```bash
# Security scan
cd ~/.openclaw/skills/openclaw-ops
bash scripts/security-scan.sh

# Skill audit (si instalaste nuevos skills)
bash scripts/skill-audit.sh ~/.openclaw/skills/<nuevo-skill>

# Limpieza de sesiones
openclaw sessions prune --older-than 7d
```

### Mensual

- [ ] Revisar MEMORY.md y curar insights
- [ ] Actualizar openclaw: `openclaw update`
- [ ] Ejecutar `check-update.sh` post-actualización
- [ ] Revisar costos de APIs
- [ ] Backup de workspace y config

### Post-Update Triage

```bash
cd ~/.openclaw/skills/openclaw-ops

# Solo reporte
bash scripts/check-update.sh

# Reporte + auto-fix
bash scripts/check-update.sh --fix
```

### Problemas Comunes Post-Update

| Problema | Causa | Solución |
|----------|-------|----------|
| Gateway no inicia | `auth: "none"` removido | Configurar auth válido |
| Agentes bloqueados | Exec approvals reset | Re-configurar allowlists |
| Canales offline | Tokens expirados | Renovar tokens |
| Skills fallan | Breaking changes | Revisar changelog |

---

## 9. Troubleshooting

### Gateway Down

```bash
# Ver estado
openclaw gateway status

# Ver logs de error
tail -100 ~/.openclaw/logs/gateway.err.log

# Intentar restart
openclaw gateway restart

# Si falla, ejecutar heal
cd ~/.openclaw/skills/openclaw-ops
bash scripts/heal.sh
```

### Agentes Bloqueados en /approve

```bash
# Ver configuración de exec
openclaw config get tools.exec

# Fix común: allowlist vacía shadoweando wildcard
# Editar ~/.openclaw/openclaw.json y remover entradas vacías
```

### Canales No Responden

```bash
# Listar canales
openclaw channels list

# Test individual
openclaw channels test telegram

# Ver logs del canal
tail -f ~/.openclaw/logs/channels.log
```

### Memoria Llena / Context Overflow

```bash
# Ver uso de contexto
openclaw status

# Compactar conversación
openclaw sessions compact

# Prunar sesiones viejas
openclaw sessions prune --older-than 7d
```

### Comandos de Diagnóstico

```bash
# Estado completo
openclaw status

# Versión
openclaw --version

# Doctor (diagnóstico automático)
openclaw doctor

# Ver sesiones activas
openclaw sessions list

# Ver logs en vivo
tail -f ~/.openclaw/logs/gateway.log
```

---

## 10. Checklist Final

### Instalación ✅

- [ ] Node.js 22.16+ o 24 instalado
- [ ] OpenClaw instalado globalmente
- [ ] Gateway daemon corriendo
- [ ] Workspace inicializado

### Configuración ✅

- [ ] openclaw.json configurado
- [ ] Variables de entorno en .zshenv/.bashrc
- [ ] Modelos configurados con fallback
- [ ] Al menos 1 canal conectado y testeado

### Skills ✅

- [ ] openclaw-ops instalado
- [ ] watchdog instalado (LaunchAgent o cron)
- [ ] skill-vetter instalado
- [ ] Skills básicos instalados (weather, github, summarize)

### Seguridad ✅

- [ ] Security scan ejecutado (score >80)
- [ ] API keys en env vars, no en config
- [ ] Permisos de archivos correctos
- [ ] Skills de terceros auditados

### Monitoreo ✅

- [ ] Watchdog corriendo
- [ ] Health targets configurados
- [ ] Logs siendo rotados
- [ ] Alertas configuradas (Signal/Telegram)

### Mantenimiento ✅

- [ ] Heartbeat configurado
- [ ] Backup automático configurado
- [ ] Documentación actualizada
- [ ] MEMORY.md siendo curado

---

## 📞 Soporte y Recursos

| Recurso | URL |
|---------|-----|
| Docs Oficiales | https://docs.openclaw.ai |
| GitHub | https://github.com/openclaw/openclaw |
| Discord | https://discord.com/invite/clawd |
| ClawHub (skills) | https://clawhub.ai |
| openclaw-ops | https://github.com/cathrynlavery/openclaw-ops |

---

## 🎯 Próximos Pasos

1. **Día 1:** Instalación + configuración básica + 1 canal
2. **Día 2:** Instalar openclaw-ops + watchdog
3. **Día 3:** Security scan + hardening
4. **Día 4:** Configurar heartbeat + automatizaciones
5. **Día 5:** Testing completo + documentación

---

*Guía creada para el setup de OpenClaw en producción. Actualizar según nuevas versiones.*

---

## 👤 Autoría

| Rol | Responsable |
|-----|-------------|
| **Creado por** | Friday Assistant (@Fridayassis_bot) |
| **Para** | @azazelpy (R N) |
| **Fecha** | 2026-04-02 |
| **Grupo** | AI multiverse (Telegram) |
| **Inspirado en** | openclaw-ops de @cathrynlavery |

---

**Última actualización:** 2026-04-02  
**OpenClaw version:** v2026.4.2  
**openclaw-ops version:** Latest (cathrynlavery)
