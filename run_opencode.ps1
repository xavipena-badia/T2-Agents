# Inicia OpenCode carregant les claus de keys.env com a variables d'entorn.
# Ús: .\run_opencode.ps1   (accepta els mateixos arguments que opencode)
Set-Location $PSScriptRoot
if (-not (Test-Path "keys.env")) {
  Write-Host "No trobo keys.env. Copia keys.env.example a keys.env i posa-hi les teves claus."
  exit 1
}
Get-Content "keys.env" | ForEach-Object {
  if ($_ -match '^\s*([^#=\s][^=]*)=(.*)$') {
    [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), "Process")
  }
}
opencode @args
