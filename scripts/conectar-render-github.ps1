# Conecta GitHub privado ao Render para deploy automatico
. "$PSScriptRoot\helpers.ps1"

Write-Host ""
Write-Host "=== Conectar GitHub ao Render ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "O repo e PRIVADO. O Render precisa de permissao via GitHub App." -ForegroundColor Yellow
Write-Host ""
Write-Host "Passo 1: Conectar conta GitHub no Render" -ForegroundColor White
Open-Link "https://dashboard.render.com/github"
Start-Sleep -Seconds 2

Write-Host "Passo 2: Instalar app Render no GitHub (conta allisonrafaelyoutube)" -ForegroundColor White
Open-Link "https://github.com/apps/render/installations/new"
Start-Sleep -Seconds 2

Write-Host "Passo 3: Pagina do servico n8n (Manual Deploy depois de conectar)" -ForegroundColor White
Open-Link "https://dashboard.render.com/web/srv-daabc8u7bikc73fuqtt0"
Start-Sleep -Seconds 1

Write-Host ""
Write-Host "No GitHub App Render:" -ForegroundColor Yellow
Write-Host "  - Conta: allisonrafaelyoutube"
Write-Host "  - Repositorio: n8n-youtube-automation (Only select repositories)"
Write-Host ""
Write-Host "Depois clique Manual Deploy > Deploy latest commit no Render." -ForegroundColor Green
Write-Host ""
