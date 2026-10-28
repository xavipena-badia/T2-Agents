# Envia el MATEIX prompt a diversos models i guarda cada resultat en una carpeta pròpia.
# Ús: .\compara.ps1 P1 "Crea un fitxer clock.html amb un rellotge analògic"
param([Parameter(Mandatory)][string]$Id, [Parameter(Mandatory)][string]$Prompt)
Set-Location $PSScriptRoot
Get-Content "keys.env" | ForEach-Object {
  if ($_ -match '^\s*([^#=\s][^=]*)=(.*)$') {
    [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), "Process")
  }
}
$env:OPENCODE_CONFIG = Join-Path $PSScriptRoot "opencode.json"

$models = @(
  "litellm/spark-coder",      # IA local del centre
  "opencode/big-pickle",      # OpenCode ZEN (gratuït)
  "deepseek/deepseek-chat"    # DeepSeek
)

foreach ($m in $models) {
  $dir = "resultats/$Id/" + ($m -replace '/', '_')
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $Prompt | Set-Content "$dir/prompt.txt"
  Write-Host "=============== $m"
  $t = Measure-Command { opencode run --dir $dir -m $m $Prompt | Tee-Object "$dir/resposta.txt" | Out-Host }
  "Temps: $([math]::Round($t.TotalSeconds)) s" | Tee-Object "$dir/temps.txt"
}
Write-Host "Fet. Mira la carpeta resultats/$Id i executa 'opencode stats' per veure els tokens."
