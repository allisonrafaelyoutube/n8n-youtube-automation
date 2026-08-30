# Conecta CLI + MCP ao projeto Supabase
# Execute: .\conectar-supabase.ps1

$ProjectRef = "enxnxtrymptxmwydqrus"
$ProjectDir = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
if (Test-Path (Join-Path $PSScriptRoot "..\supabase\config.toml")) {
    $ProjectDir = Split-Path $PSScriptRoot -Parent
}

Set-Location $ProjectDir

Write-Host ""
Write-Host "=== Conectar Supabase: $ProjectRef ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command supabase -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando Supabase CLI..." -ForegroundColor Yellow
    npm install -g supabase | Out-Null
}

if (-not (Test-Path "supabase\config.toml")) {
    Write-Host "Rodando supabase init..." -ForegroundColor Yellow
    supabase init
}

Write-Host "Abra estas paginas (conta allisonrafaelaraujo@gmail.com):" -ForegroundColor Yellow
Start-Process "https://supabase.com/dashboard/account/tokens"
Start-Sleep -Seconds 1
Start-Process "https://supabase.com/dashboard/project/$ProjectRef/settings/database"

Write-Host ""
Write-Host "1) Access Token: Account > Access Tokens > Generate new token" -ForegroundColor White
$token = Read-Host "Cole o SUPABASE ACCESS TOKEN"

Write-Host ""
Write-Host "2) Database Password: Project Settings > Database > Database password" -ForegroundColor White
$dbPassword = Read-Host "Cole a senha do Postgres" -AsSecureString
$dbPasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($dbPassword)
)

if ([string]::IsNullOrWhiteSpace($token) -or [string]::IsNullOrWhiteSpace($dbPasswordPlain)) {
    Write-Host "Erro: token e senha sao obrigatorios." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Fazendo login na CLI..." -ForegroundColor Yellow
supabase login --token $token.Trim()
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Linkando projeto $ProjectRef..." -ForegroundColor Yellow
supabase link --project-ref $ProjectRef --password $dbPasswordPlain --yes
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

[Environment]::SetEnvironmentVariable("SUPABASE_ACCESS_TOKEN", $token.Trim(), "User")
[Environment]::SetEnvironmentVariable("SUPABASE_PROJECT_REF", $ProjectRef, "User")

Write-Host ""
Write-Host "[OK] Supabase conectado!" -ForegroundColor Green
Write-Host "  Project ref: $ProjectRef"
Write-Host "  Host: db.$ProjectRef.supabase.co"
Write-Host "  MCP vars salvas no Windows"
Write-Host ""
Write-Host "Reinicie o Cursor e teste: 'lista projetos supabase'" -ForegroundColor Yellow
Write-Host ""
