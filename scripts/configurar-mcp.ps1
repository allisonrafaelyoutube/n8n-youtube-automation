# Configura MCP Render + Supabase para a conta allisonrafaelaraujo@gmail.com
# Execute no PowerShell: .\configurar-mcp.ps1

Write-Host ""
Write-Host "=== Configuracao MCP (Render + Supabase) ===" -ForegroundColor Cyan
Write-Host "Use a conta NOVA (allisonrafaelaraujo@gmail.com) nos sites que abrirem." -ForegroundColor Yellow
Write-Host ""

# Abre paginas para gerar as chaves
Start-Process "https://dashboard.render.com/u/settings#api-keys"
Start-Sleep -Seconds 1
Start-Process "https://supabase.com/dashboard/account/tokens"
Start-Sleep -Seconds 1
Start-Process "https://supabase.com/dashboard/project/_/settings/general"

Write-Host "1) Render: crie uma API Key e copie" -ForegroundColor White
$renderKey = Read-Host "Cole a RENDER API KEY"

Write-Host ""
Write-Host "2) Supabase: crie um Access Token (Account > Access Tokens)" -ForegroundColor White
$supabaseToken = Read-Host "Cole o SUPABASE ACCESS TOKEN"

Write-Host ""
Write-Host "3) Supabase: Project ID ja configurado -> enxnxtrymptxmwydqrus" -ForegroundColor Green
$projectRef = "enxnxtrymptxmwydqrus"
if ([string]::IsNullOrWhiteSpace($projectRef)) {
    $projectRef = Read-Host "Cole o SUPABASE PROJECT REF"
}

if ([string]::IsNullOrWhiteSpace($renderKey) -or [string]::IsNullOrWhiteSpace($supabaseToken) -or [string]::IsNullOrWhiteSpace($projectRef)) {
    Write-Host "Erro: todos os campos sao obrigatorios." -ForegroundColor Red
    exit 1
}

[Environment]::SetEnvironmentVariable("RENDER_API_KEY", $renderKey.Trim(), "User")
[Environment]::SetEnvironmentVariable("SUPABASE_ACCESS_TOKEN", $supabaseToken.Trim(), "User")
[Environment]::SetEnvironmentVariable("SUPABASE_PROJECT_REF", $projectRef.Trim(), "User")

Write-Host ""
Write-Host "Variaveis salvas no perfil do Windows:" -ForegroundColor Green
Write-Host "  RENDER_API_KEY"
Write-Host "  SUPABASE_ACCESS_TOKEN"
Write-Host "  SUPABASE_PROJECT_REF"
Write-Host ""
Write-Host "IMPORTANTE: Feche e reabra o Cursor completamente para carregar as variaveis." -ForegroundColor Yellow
Write-Host "Depois peca ao agente: 'lista os workspaces do Render'" -ForegroundColor Yellow
Write-Host ""
