#!/bin/bash

# Asegurar que se ejecuta como usuario no root
if [ "$EUID" -eq 0 ]; then
  echo "Por favor, ejecuta este script como un usuario normal (no root)."
  exit 1
fi

echo "Instalando Laravel global y extensiones de VSCode para el usuario: $USER"
echo "HOME actual: $HOME"
# Asegurar que npm esté disponible para laravel, angular
if ! command -v npm &> /dev/null; then
  echo "⚠️ NPM no está instalado o no está en el PATH."
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt install -y nodejs
  sudo npm install -g npm
fi
# Asegurar que Composer está disponible
if ! command -v composer &> /dev/null; then
  echo "❌ Composer no está instalado o no está en el PATH."
  exit 1
fi
# Agregar vendor bin al PATH si no está ya
if ! grep -q 'composer/vendor/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> "$HOME/.bashrc"
fi
# Agregar angular si el usuario quiere
read -p "¿Deseas instalar angular? (y/N): " angular
if [[ "$angular" == "y" ]]; then
  echo "🔀 Es necesario configurar git"
  read -p "¿Tu nombre?: " name
  read -p "¿Tu correo?: " email
  git config --global user.name "$name"
  git config --global user.email "$email"
  git config --global init.defaultBranch main
  sudo npm install -g @angular/cli
fi
# agregar el instalador de laravel si el usuario quiere
read -p "¿Deseas instalar laravel? (y/N): " laravel
if [[ "$laravel" == "y" ]]; then
  echo "📦 Instalando Laravel globalmente..."
  composer global require laravel/installer
  # Instalar extensión de Laravel para VSCode
  read -p "¿Deseas instalar las extensiones de laravel recomendadas? (y/N): " laravel
  if [[ "$laravel" == "y" ]]; then
    echo "Instalando extensión Laravel Pack by Novato Pro en VSCode..."
    code --install-extension JhordyBarrera.laravel-pack-by-novato-pro \
        --user-data-dir="$HOME/.vscode" --no-sandbox
  fi
fi
  # Instalar extensiones de desarrollo remote de microsoft para VSCode
  read -p "¿Deseas instalar las extensiones de Microsoft Remote Development? (y/N): " remote
  if [[ "$remote" == "y" ]]; then
    echo "Instalando extensiones de desarrollo remoto en VSCode..."
    code --install-extension ms-vscode-remote.vscode-remote-extensionpack \
        --user-data-dir="$HOME/.vscode" --no-sandbox
  fi
echo "✅ Configuración completada."
