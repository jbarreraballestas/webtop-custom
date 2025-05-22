#!/bin/bash
read -p "¿Eliminar carpeta ./config local? (y/N): " wipe
if [[ "$wipe" == "y" ]]; then
  rm -rf ./config
fi

docker compose down --volumes --remove-orphans
docker compose build --no-cache
docker compose up -d
