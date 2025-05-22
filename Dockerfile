FROM lscr.io/linuxserver/webtop:ubuntu-xfce

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Actualizamos sistema y herramientas básicas
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    htop \
    curl \
    wget \
    pgp \
    net-tools \
    gnupg2 \
    software-properties-common \
    ca-certificates \
    lsb-release \
    apt-transport-https \
    unzip \
    locales \
    sqlite3 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# -------------------- PHP 8.4 + Composer --------------------
    RUN add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install -y \
    php8.4 php8.4-cli php8.4-common \
    php8.4-fpm php8.4-mbstring php8.4-xml \
    php8.4-curl php8.4-mysql php8.4-zip \
    php8.4-sqlite3 && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> /etc/bash.bashrc

# -------------------- Visual Studio Code --------------------
RUN wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868 && \
    apt install ./vscode.deb && \
    rm -f vscode.deb && \
    echo "alias code='code --no-sandbox --user-data-dir=/tmp/vscode-data'" >> /etc/bash.bashrc

# Limpieza final
RUN apt autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN chmod -R 777 /config