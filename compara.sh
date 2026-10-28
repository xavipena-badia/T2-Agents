#!/bin/bash
# Envia el MATEIX prompt a diversos models i guarda cada resultat en una carpeta pròpia.
# Ús: bash compara.sh P1 "Crea un fitxer clock.html amb un rellotge analògic"
cd "$(dirname "$0")"
if [ $# -ne 2 ]; then
  echo "Ús: bash compara.sh <ID_PROMPT> \"<text del prompt>\""
  exit 1
fi
set -a; source keys.env; set +a
export OPENCODE_CONFIG="$(pwd)/opencode.json"

MODELS=(
  "litellm/spark-coder"       # IA local del centre
  "opencode/big-pickle"       # OpenCode ZEN (gratuït)
  "deepseek/deepseek-chat"    # DeepSeek
)

for m in "${MODELS[@]}"; do
  dir="resultats/$1/${m//\//_}"
  mkdir -p "$dir"
  echo "$2" > "$dir/prompt.txt"
  echo "=============== $m"
  inici=$(date +%s)
  opencode run --dir "$dir" -m "$m" "$2" | tee "$dir/resposta.txt"
  fi_=$(date +%s)
  echo "Temps: $((fi_ - inici)) s" | tee "$dir/temps.txt"
done
echo "Fet. Mira la carpeta resultats/$1 i executa 'opencode stats' per veure els tokens."
