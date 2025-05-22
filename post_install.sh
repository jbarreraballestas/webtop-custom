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
  # Asegurar que npm esté disponible para laravel
  if ! command -v npm &> /dev/null; then
    echo "⚠️ NPM no está instalado o no está en el PATH."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
    sudo npm install -g npm
  fi
fi

# Agregar colores a la terminal bash
azul0='\[\033[0;34m\]'
azul1='\[\033[1;34m\]'
verde0='\[\033[0;32m\]'
verde1='\[\033[1;32m\]'
fncolor='\[\033[0;00m\]'
usuario='\u'
host='\h'
git='$(__git_ps1 " (%s)")'
directorio='\w'
export PS1='\u@\h\[\033[01;34m\] \w\[\033[0;32m\]$(__git_ps1 " (%s)")\[\033[01;34m\]$\[\033[00m\] '
command="export PS1='$verde1$usuario@$host $azul1$directorio$verde0$git$azul0$ $fncolor'"
echo $command >> /config/.bashrc
source /config/.bashrc

echo "✅ Configuración completada."
