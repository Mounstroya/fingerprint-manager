#!/bin/bash
set -e

echo "==> Instalando Fingerprint Manager..."

# Verificar dependencias del sistema
MISSING_PKGS=()
command -v fprintd &>/dev/null || MISSING_PKGS+=(fprintd)
python3 -c "import gi" &>/dev/null || MISSING_PKGS+=(python3-gi gir1.2-gtk-3.0)
python3 -c "import dbus" &>/dev/null || MISSING_PKGS+=(python3-dbus)

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo "==> Instalando dependencias: ${MISSING_PKGS[*]}"
    sudo apt install -y "${MISSING_PKGS[@]}"
fi

# Instalar la app
mkdir -p ~/.local/bin
cp fingerprint-manager ~/.local/bin/fingerprint-manager
chmod +x ~/.local/bin/fingerprint-manager

# Entrada de menú
mkdir -p ~/.local/share/applications
cp fingerprint-manager.desktop ~/.local/share/applications/
update-desktop-database ~/.local/share/applications/ 2>/dev/null || true

# Asegurar que ~/.local/bin esté en PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo "==> Se agregó ~/.local/bin a tu PATH en ~/.bashrc"
fi

echo ""
echo "✓ Instalación completa."
echo "  Lanza la app con: fingerprint-manager"
echo "  O búscala en el menú: Configuración → Huellas dactilares"
