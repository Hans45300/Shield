$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $repoRoot

if (-not (Test-Path -LiteralPath (Join-Path $repoRoot '.gitmodules'))) {
    throw "Fichier .gitmodules introuvable a la racine : $repoRoot"
}

function Invoke-Git {
    param([Parameter(Mandatory)][string[]]$Arguments)

    & git @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Échec de 'git $($Arguments -join ' ')' (code $LASTEXITCODE)."
    }
}

Write-Host 'Synchronisation et initialisation des sous-modules...'
Invoke-Git @('submodule', 'sync', '--recursive')
Invoke-Git @('submodule', 'update', '--init', '--recursive')

Write-Host 'Mise a jour des sous-modules vers leur derniere version distante...'
Invoke-Git @('submodule', 'update', '--remote', '--recursive')

Write-Host 'Sous-modules mis a jour.'
