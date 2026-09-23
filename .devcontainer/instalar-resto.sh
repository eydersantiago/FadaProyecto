#!/usr/bin/env bash
# Fase 2 del devcontainer: lo que no hace falta para abrir el editor.
# Corre en segundo plano; el progreso queda en /tmp/instalar-resto.log
# y al terminar aparece /tmp/adaceen-entorno-listo.
#
# Para mirarlo desde la terminal del Codespace:
#     tail -f /tmp/instalar-resto.log
set -uo pipefail

MARCA=/tmp/adaceen-entorno-listo
rm -f "$MARCA"
echo "=== $(date +%T) fase 2: instalando JDK y Ant"

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq
sudo apt-get install -y -qq --no-install-recommends openjdk-17-jdk-headless ant

if command -v javac >/dev/null && command -v ant >/dev/null; then
  echo "=== $(date +%T) listo: $(javac -version 2>&1) / $(ant -version 2>&1 | head -n 1)"
  echo "Recarga la ventana una vez (Ctrl+Shift+P -> Developer: Reload Window)"
  echo "para que la extension de Java encuentre el JDK."
  touch "$MARCA"
else
  echo "=== $(date +%T) FALLO: revisa arriba. Puedes reintentar con:"
  echo "    bash .devcontainer/instalar-resto.sh"
  exit 1
fi
