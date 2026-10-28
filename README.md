# T2 · Sessió 1 — Mateix prompt, models diferents

Projecte base de la pràctica. Enviareu el mateix prompt a tres models i comparareu els resultats.

| Model | Proveïdor | On s'executa |
| --- | --- | --- |
| `litellm/spark-coder` | IA local del centre (LiteLLM) | Servidor del centre (només des de la xarxa del centre) |
| `opencode/big-pickle` | OpenCode ZEN | Núvol, gratuït amb límit per hora |
| `deepseek/deepseek-chat` | DeepSeek | Núvol |

## 1. Configuració (una sola vegada)

```bash
cp keys.env.example keys.env      # Windows: copy keys.env.example keys.env
```

Obre `keys.env` i posa-hi les teves claus. **Aquest fitxer no es puja mai al repositori**: comprova amb `git status` que no hi apareix.

Prova que tot funciona:

```bash
bash run_opencode.sh              # Windows: .\run_opencode.ps1
```

El model per defecte és `spark-coder` (la IA local). Pregunta-li "Hola, quin model ets?".

## 2. Experiment

```bash
bash compara.sh P1 "Crea un fitxer clock.html amb un rellotge analògic"
bash compara.sh P2 "Crea una funció Python per validar un formulari de registre"
bash compara.sh P3 "Explica en 5 línies què és un agent d'IA"
```

A Windows: `.\compara.ps1 P1 "Crea un fitxer clock.html amb un rellotge analògic"`.

Cada execució queda a `resultats/<prompt>/<model>/` amb el codi generat, `prompt.txt`, `resposta.txt` i `temps.txt`. Per als tokens: `opencode stats`.

## 3. Graella

Omple `graella.md` i respon les tres preguntes de conclusions.

## Normes

- No enviïs cap clau, contrasenya ni dada personal en un prompt.
- Els models gratuïts tenen límit de consultes: no repeteixis execucions sense motiu.
- No corregeixis el que genera el model: volem veure el resultat tal com surt.
