#!/bin/bash
# 🦞 OpenClaw Quick-Start Script
# Guía interactiva 0 → 100%
# Versión: 1.0 | Abril 2026
#
# Creado por: Friday Assistant
# Para: @azazelpy (R N)
# Fecha: 2026-04-02
# Grupo: AI multiverse

set -eu  # Salir en error y variables no definidas

# Cleanup trap para Ctrl+C
cleanup() {
    echo ""
    print_warning "Instalación cancelada por el usuario"
    echo "Podés continuar en cualquier momento ejecutando: bash scripts/quick-start.sh"
    exit 130
}

trap cleanup SIGINT

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Emojis (usando nombres alternativos)
EMOJI_OK="[OK]"
EMOJI_ERR="[ERR]"
EMOJI_WARN="[!]"
EMOJI_PKG="[PKG]"
EMOJI_FIX="[FIX]"
EMOJI_SEC="[SEC]"
EMOJI_NET="[NET]"
EMOJI_BRAIN="[AI]"

# Funciones de utilidad
print_header() {
    echo -e "\n${CYAN}═══════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}\n"
}

print_step() {
    echo -e "${BLUE}➜ $1${NC}"
}

print_success() {
    echo -e "${GREEN}${EMOJI_OK} $1${NC}"
}

print_error() {
    echo -e "${RED}${EMOJI_ERR} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}${EMOJI_WARN} $1${NC}"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

pause() {
    echo ""
    read -p "Presioná Enter para continuar..."
}

# Banner inicial
print_header "OpenClaw Quick-Start 0 -> 100% (🦞)"
echo "Esta guía interactiva te va a llevar de 0 a 100% con OpenClaw."
echo "Tiempo estimado: 15-20 minutos"
echo ""
echo "Presioná Ctrl+C en cualquier momento para salir."
pause

# ============================================================================
# FASE 1: Verificación de Requisitos
# ============================================================================
print_header "FASE 1: Verificacion de Requisitos ${EMOJI_PKG}"

print_step "Verificando Node.js..."
if check_command node; then
    NODE_VERSION=$(node --version)
    print_success "Node.js instalado: $NODE_VERSION"
else
    print_error "Node.js NO encontrado"
    echo "Instalalo desde: https://nodejs.org/"
    echo "O con nvm: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
    exit 1
fi

print_step "Verificando npm/pnpm..."
if check_command pnpm; then
    PM="pnpm"
    print_success "pnpm disponible (recomendado)"
elif check_command npm; then
    PM="npm"
    print_success "npm disponible"
elif check_command bun; then
    PM="bun"
    print_success "bun disponible"
else
    print_error "No se encontró npm, pnpm o bun"
    exit 1
fi

print_step "Verificando Git..."
if check_command git; then
    GIT_VERSION=$(git --version)
    print_success "Git instalado: $GIT_VERSION"
else
    print_error "Git NO encontrado"
    echo "Instalalo: brew install git (macOS) o apt install git (Linux)"
    exit 1
fi

print_step "Verificando Python 3..."
if check_command python3; then
    PYTHON_VERSION=$(python3 --version)
    print_success "Python 3 instalado: $PYTHON_VERSION"
else
    print_warning "Python 3 NO encontrado (necesario para openclaw-ops)"
fi

print_success "Todos los requisitos básicos están OK"
pause

# ============================================================================
# FASE 2: Instalación de OpenClaw
# ============================================================================
print_header "FASE 2: Instalacion de OpenClaw ${EMOJI_PKG}"

# Crear directorio ~/.openclaw si no existe
if [[ ! -d ~/.openclaw ]]; then
    print_step "Creando directorio ~/.openclaw..."
    mkdir -p ~/.openclaw
    print_success "Directorio creado"
fi

print_step "Verificando si OpenClaw ya está instalado..."
if check_command openclaw; then
    OC_VERSION=$(openclaw --version 2>&1 | head -1)
    print_warning "OpenClaw ya está instalado: $OC_VERSION"
    read -p "¿Querés actualizarlo? (y/n): " UPDATE
    if [[ $UPDATE =~ ^[Yy]$ ]]; then
        print_step "Actualizando OpenClaw..."
        $PM update -g openclaw
        print_success "OpenClaw actualizado"
    fi
else
    print_step "Instalando OpenClaw globalmente..."
    $PM install -g openclaw@latest
    print_success "OpenClaw instalado"
fi

print_step "Verificando versión mínima (v2026.2.12+)..."
OC_VERSION=$(openclaw --version 2>&1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1 || echo "v0.0.0")
print_info "Versión detectada: $OC_VERSION"

pause

# ============================================================================
# FASE 3: Configuración Inicial
# ============================================================================
print_header "FASE 3: Configuracion Inicial ${EMOJI_FIX}"

print_step "Ejecutando asistente de onboarding..."
echo "Esto va a configurar:"
echo "  - Gateway daemon"
echo "  - Workspace inicial"
echo "  - Variables de entorno"
echo "  - Daemon de inicio automático"
echo ""
read -p "¿Continuar con el onboarding? (y/n): " ONBOARD
if [[ $ONBOARD =~ ^[Yy]$ ]]; then
    openclaw onboard --install-daemon
    print_success "Onboarding completado"
else
    print_warning "Saltando onboarding (podés ejecutarlo después con: openclaw onboard)"
fi

pause

# ============================================================================
# FASE 4: Configuración de Modelos y APIs
# ============================================================================
print_header "FASE 4: Modelos y APIs ${EMOJI_BRAIN}"

print_step "Configuración de proveedores de IA..."
echo ""
echo "OpenClaw soporta múltiples proveedores. Configurá los que tengas:"
echo ""
echo "1. NVIDIA NIM (FREE tier - recomendado)"
echo "   - minimax-m2.5, nemotron-340b, llama-70b"
echo "   - Gratis hasta cierto límite"
echo "   - Obtener key: https://build.nvidia.com/"
echo ""
echo "2. Alibaba DashScope"
echo "   - qwen3.5-plus, qwen-plus, qwen-turbo"
echo "   - Muy económico (~$0.50/mes para uso normal)"
echo "   - Obtener key: https://dashscope.console.aliyun.com/"
echo ""
echo "3. MiniMax"
echo "   - MiniMax M2.7, M2.5"
echo "   - Bueno para tareas diarias y coding"
echo ""

read -p "¿Tenés API keys configuradas? (y/n): " HAVE_KEYS
if [[ $HAVE_KEYS =~ ^[Yy]$ ]]; then
    print_success "Saltando configuración de APIs (ya están configuradas)"
else
    print_warning "Podés configurar las APIs después editando:"
    echo "  ~/.openclaw/openclaw.json"
    echo "  ~/.zshenv o ~/.bashrc"
    echo ""
    echo "Ver la guía completa en: ~/workspace/docs/OPENCLAW-0-TO-100.md"
fi

pause

# ============================================================================
# FASE 5: Instalación de Skills Esenciales
# ============================================================================
print_header "FASE 5: Skills Esenciales ${EMOJI_FIX}"

print_step "Skills recomendados para instalar:"
echo ""
echo "  ✅ openclaw-ops    - Monitoreo, salud, auto-reparación (CRÍTICO)"
echo "  ✅ skill-vetter    - Auditoría de seguridad de skills (CRÍTICO)"
echo "  ⚪ weather         - Clima y pronósticos"
echo "  ⚪ github          - Gestión de issues/PRs"
echo "  ⚪ summarize        - Resumir URLs/transcripts"
echo "  ⚪ healthcheck      - Hardening de seguridad"
echo ""

read -p "¿Instalar openclaw-ops y skill-vetter? (y/n): " INSTALL_SKILLS
if [[ $INSTALL_SKILLS =~ ^[Yy]$ ]]; then
    print_step "Clonando openclaw-ops..."
    git clone https://github.com/cathrynlavery/openclaw-ops.git ~/.openclaw/skills/openclaw-ops 2>/dev/null || print_warning "openclaw-ops ya existe"
    print_success "openclaw-ops instalado"
    
    print_step "Ejecutando heal.sh para verificar estado..."
    cd ~/.openclaw/skills/openclaw-ops && bash scripts/heal.sh 2>&1 | tail -5 || print_warning "heal.sh encontró problemas (revisar logs)"
    
    # Volver al directorio original
    cd - > /dev/null
    
    print_success "Skills esenciales instalados"
else
    print_warning "Podés instalar skills después manualmente"
fi

pause

# ============================================================================
# FASE 6: Configuración del Watchdog
# ============================================================================
print_header "FASE 6: Watchdog (Monitoreo Continuo) ${EMOJI_NET}"

print_step "El watchdog monitorea tu gateway cada 5 minutos y:"
echo "  - Reinicia el gateway si está caído"
echo "  - Ejecuta heal.sh automático si hay problemas"
echo "  - Te notifica después de 3 fallos consecutivos"
echo ""

if [[ "$(uname)" == "Darwin" ]]; then
    print_info "macOS detectado - puede instalarse como LaunchAgent"
    read -p "¿Instalar watchdog como LaunchAgent? (y/n): " INSTALL_WD
    if [[ $INSTALL_WD =~ ^[Yy]$ ]]; then
        cd ~/.openclaw/skills/openclaw-ops
        bash scripts/watchdog-install.sh
        print_success "Watchdog instalado como LaunchAgent"
        cd - > /dev/null
    fi
else
    print_info "Linux detectado - usar cron en lugar de LaunchAgent"
    echo "Agregá esta línea a tu crontab (crontab -e):"
    echo "*/5 * * * * bash ~/.openclaw/skills/openclaw-ops/scripts/watchdog.sh >> ~/.openclaw/logs/watchdog.log 2>&1"
fi

pause

# ============================================================================
# FASE 7: Security Scan
# ============================================================================
print_header "FASE 7: Security Scan ${EMOJI_SEC}"

print_step "Ejecutando security scan..."
if [[ -f ~/.openclaw/skills/openclaw-ops/scripts/security-scan.sh ]]; then
    cd ~/.openclaw/skills/openclaw-ops
    bash scripts/security-scan.sh 2>&1 | tail -20
    cd - > /dev/null
    print_success "Security scan completado"
else
    print_warning "openclaw-ops no encontrado - saltando security scan"
fi

pause

# ============================================================================
# FASE 8: Verificación Final
# ============================================================================
print_header "FASE 8: Verificacion Final ${EMOJI_OK}"

print_step "Estado del gateway..."
openclaw gateway status 2>&1 | head -10 || print_warning "No se pudo obtener estado del gateway"

echo ""
print_step "Skills instalados..."
ls -1 ~/.openclaw/skills/ 2>/dev/null | head -10 || print_warning "No se pudo listar skills"

echo ""
print_step "Canales configurados..."
openclaw channels list 2>&1 | head -10 || print_warning "No se pudo listar canales"

pause

# ============================================================================
# RESUMEN FINAL
# ============================================================================
print_header "🎉 ¡Instalación Completada!"

echo ""
echo "Resumen de lo realizado:"
echo "  ${EMOJI_OK} OpenClaw instalado y configurado"
echo "  ${EMOJI_OK} Gateway daemon configurado"
echo "  ${EMOJI_OK} Skills esenciales instalados (openclaw-ops, skill-vetter)"
if [[ "$(uname)" == "Darwin" && $INSTALL_WD =~ ^[Yy]$ ]]; then
    echo "  ${EMOJI_OK} Watchdog instalado como LaunchAgent"
fi
echo "  ${EMOJI_OK} Security scan ejecutado"
echo ""
echo "Próximos pasos recomendados:"
echo "  1. Configurá tus APIs en ~/.openclaw/openclaw.json"
echo "  2. Conectá al menos 1 canal (Telegram, Discord, etc.)"
echo "  3. Leé la guía completa: ~/workspace/docs/OPENCLAW-0-TO-100.md"
echo "  4. Personalizá tu agente en ~/workspace/SOUL.md"
echo ""
echo "Comandos útiles:"
echo "  openclaw status          - Ver estado general"
echo "  openclaw gateway status  - Ver estado del gateway"
echo "  openclaw doctor          - Diagnóstico automático"
echo "  tail -f ~/.openclaw/logs/gateway.log  - Ver logs en vivo"
echo ""
echo "Soporte:"
echo "  Docs: https://docs.openclaw.ai"
echo "  Discord: https://discord.com/invite/clawd"
echo "  GitHub: https://github.com/openclaw/openclaw"
echo ""
print_success "Bienvenido a OpenClaw! (🦞)"
echo ""
