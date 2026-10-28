#!/bin/bash
# Inicia OpenCode carregant les claus de keys.env com a variables d'entorn.
# Ús: bash run_opencode.sh   (accepta els mateixos arguments que opencode)
cd "$(dirname "$0")"
if [ ! -f keys.env ]; then
  echo "No trobo keys.env. Copia keys.env.example a keys.env i posa-hi les teves claus."
  exit 1
fi
set -a; source keys.env; set +a
exec opencode "$@"
