# Deploy n8n no Render via Blueprint (Brave)
. "$PSScriptRoot\helpers.ps1"

$repo = "https://github.com/allisonrafaelyoutube/n8n-youtube-automation"
$projectRef = "enxnxtrymptxmwydqrus"

Write-Host ""
Write-Host "=== Deploy n8n no Render ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Passo 1: Conectar GitHub ao Render (se ainda nao conectou)" -ForegroundColor Yellow
Open-Link "https://dashboard.render.com/github"
Start-Sleep -Seconds 2

Write-Host "Passo 2: Deploy Blueprint do repo" -ForegroundColor Yellow
Open-Link "https://dashboard.render.com/blueprint/new?repo=$repo"
Start-Sleep -Seconds 2

Write-Host "Passo 3: Supabase - copiar senha do banco se precisar" -ForegroundColor Yellow
Open-Link "https://supabase.com/dashboard/project/$projectRef/settings/database"

Write-Host ""
Write-Host "No Blueprint, preencha:" -ForegroundColor White
Write-Host "  DB_POSTGRESDB_PASSWORD = N8nYoutube2026!Secure"
Write-Host "  N8N_HOST = (URL do servico, ex: n8n-youtube-xxxx.onrender.com)"
Write-Host "  WEBHOOK_URL = https://n8n-youtube-xxxx.onrender.com/"
Write-Host ""
Write-Host "Repo: $repo" -ForegroundColor Green
Write-Host ""
