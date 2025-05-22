# 🧰 Webtop Custom - Laravel + PHP 8.4 + VS Code

Contenedor Docker personalizado basado en [linuxserver/webtop](https://github.com/linuxserver/docker-webtop) con entorno de desarrollo optimizado para proyectos Laravel y herramientas comunes de desarrollo.

## 📦 Características

- Visual Studio Code
- PHP 8.4 (FPM + CLI + SQLite + Composer)
- Laravel CLI global vía Composer
- Alias global para `code` sin sandbox
- Volumen persistente: configuración y extensiones sobreviven reinicios
- Script opcional de instalación `post_install.sh`

## 📁 Archivos incluidos

```
.
├── Dockerfile
├── docker-compose.yml
├── rebuild.sh
├── .env.example
├── post_install.sh         # Script opcional para extensiones y Laravel
└── config/                 # Volumen persistente montado por Docker
```

## 🚀 Uso

### 1. Crear archivo `.env`

Copia el archivo de ejemplo y ajusta tus credenciales:

```bash
cp .env.example .env
```

Contenido por defecto:

```env
USER=webtop
PASSWORD=insecure_changeme
```

### 2. Construir y levantar el contenedor

```bash
chmod +x rebuild.sh
./rebuild.sh
```

El script preguntará si deseas eliminar el volumen `./config`.

### 3. Acceder a Webtop (interfaz gráfica)

Abre tu navegador en:

```
http://localhost:3000
```

- Usuario: el definido en `.env` (`USER`)
- Contraseña: el definido en `.env` (`PASSWORD`)

## 🧪 Instalación opcional de herramientas adicionales

Puedes ejecutar manualmente el script `post_install.sh` para instalar:

- Laravel global con Composer
- Extensiones de VS Code recomendadas

### Ejecutar desde el contenedor:

```bash
docker exec -u abc -it webtop-custom bash /config/post_install.sh
```

> 💡 El usuario `abc` tiene como `$HOME` el volumen `/config`.

## 📂 Volúmenes persistentes

- `./config`: configuración completa del usuario `abc`, incluyendo VS Code y Composer.
- `post_install.sh`: montado en modo de solo lectura para evitar alteraciones accidentales.

## 🧹 Limpieza

Puedes reconstruir desde cero con:

```bash
./rebuild.sh
```

Y si eliges `y` en la pregunta inicial, se eliminará todo el contenido de `./config`.

## ⚠️ Notas

- Asegúrate de no eliminar `post_install.sh` si necesitas reinstalar herramientas.
- Para ejecutar automáticamente `post_install.sh` al primer arranque, puedes moverlo como script ejecutable a `config/custom-cont-init.d/` (ver documentación de Webtop para más info).

## 📝 Licencia

Basado en [LinuxServer.io Webtop](https://github.com/linuxserver/docker-webtop), distribuido bajo licencia [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.html).
