#!/bin/bash

# Asegurar que se ejecuta como usuario no root
if [ "$EUID" -eq 0 ]; then
  echo "Por favor, ejecuta este script como un usuario normal (no root)."
  exit 1
fi

echo "Instalando Laravel global y extensiones de VSCode para el usuario: $USER"
echo "HOME actual: $HOME"

# Asegurar que Composer está disponible
if ! command -v composer &> /dev/null; then
  echo "❌ Composer no está instalado o no está en el PATH."
  exit 1
fi

# Laravel installer
echo "📦 Instalando Laravel globalmente..."
composer global require laravel/installer

# Agregar vendor bin al PATH si no está ya
if ! grep -q 'composer/vendor/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> "$HOME/.bashrc"
fi

# Instalar extensión de Laravel para VSCode
echo "🔌 Instalando extensión Laravel Pack by Novato Pro en VSCode..."
code --install-extension JhordyBarrera.laravel-pack-by-novato-pro \
     --user-data-dir="$HOME/.vscode" --no-sandbox

echo "✅ Configuración completada."
