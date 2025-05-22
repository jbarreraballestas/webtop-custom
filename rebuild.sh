#!/bin/bash
read -p "¿Eliminar carpeta ./config local? (y/N): " wipe
docker compose down --volumes --remove-orphans
if [[ "$wipe" == "y" ]]; then
  rm -rf ./config
fi
docker compose build --no-cache
docker compose up -d
