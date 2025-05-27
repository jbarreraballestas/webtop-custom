#!/bin/bash
read -p "¿Eliminar carpeta ./config local? Esto eliminará toda la información del directorio home del usuario, ¿Está seguro que desea eliminar /config? (y/N): " wipe
docker compose down --volumes --remove-orphans
if [[ "$wipe" == "y" ]]; then
  rm -rf ./config
fi
docker compose build --no-cache
docker compose up -d
