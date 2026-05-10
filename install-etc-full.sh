#!/usr/bin/env bash
# ETC — Instalador completo (14 agentes, 46+ skills)
# Uso: bash install-etc-full.sh [destino]
#   destino: directorio donde instalar (default: ~/.config/opencode)

set -euo pipefail

VERSION="3.0.0"
REPO_A="https://github.com/felixmoto44-spec/ETC-El-Septeto-Calavera.git"
REPO_B="https://github.com/felixmoto44-spec/ETC-System-Agents.git"
TEMP_DIR="/tmp/etc-install-$$"
TARGET="${1:-$HOME/.config/opencode}"

echo "═══ ETC Installer v${VERSION} ═══"
echo "Destino: ${TARGET}"
echo ""

# Detectar SO
OS="$(uname -s)"
case "${OS}" in
    Linux)  OPENCODE_DIR="${HOME}/.config/opencode" ;;
    Darwin) OPENCODE_DIR="${HOME}/Library/Application Support/opencode" ;;
    *)      echo "⚠️  SO no detectado automáticamente. Usando: ${TARGET}" ;;
esac

# Usar TARGET si se especificó, si no usar OPENCODE_DIR
TARGET="${1:-${OPENCODE_DIR:-$HOME/.config/opencode}}"

echo "📥 Clonando repositorios..."
git clone "${REPO_A}" "${TEMP_DIR}/septeto" --depth 1 --quiet
git clone "${REPO_B}" "${TEMP_DIR}/system" --depth 1 --quiet

echo "📦 Instalando agentes..."
mkdir -p "${TARGET}/agents"
cp "${TEMP_DIR}/septeto/.opencode/agents/"*.md "${TARGET}/agents/"
cp "${TEMP_DIR}/system/.opencode/agents/"*.md "${TARGET}/agents/"

echo "📦 Instalando skills..."
mkdir -p "${TARGET}/skills"
for skill_dir in "${TEMP_DIR}/septeto/.opencode/skills/"*/; do
    cp -r "$skill_dir" "${TARGET}/skills/"
done
for skill_dir in "${TEMP_DIR}/system/.opencode/skills/"*/; do
    cp -r "$skill_dir" "${TARGET}/skills/"
done

echo "📦 Instalando prompts..."
mkdir -p "${TARGET}/prompts"
cp "${TEMP_DIR}/septeto/prompts/"*.md "${TARGET}/prompts/"

echo "📦 Instalando configuración..."
cp "${TEMP_DIR}/septeto/opencode.json" "${TARGET}/opencode.json"

echo ""
echo "✅ Instalación completada"
echo "   Agentes: $(ls "${TARGET}/agents/"*.md 2>/dev/null | wc -l)"
echo "   Skills: $(ls -d "${TARGET}/skills/"*/ 2>/dev/null | wc -l)"
echo "   Prompts: $(ls "${TARGET}/prompts/"*.md 2>/dev/null | wc -l)"
echo ""
echo "🧹 Limpiando..."
rm -rf "${TEMP_DIR}"
echo "✅ Listo."
