# Inscreve o canal YouTube no PubSubHubbub (WebSub)
# Requer: workflow "YouTube WebSub - Comentario instantaneo" ATIVO no n8n
# Execute: .\scripts\subscribe-youtube-websub.ps1

. "$PSScriptRoot\helpers.ps1"

$ChannelId = if ($env:YOUTUBE_CHANNEL_ID) { $env:YOUTUBE_CHANNEL_ID } else { "UCoMiD3PXLj944Tj6sYeuUPA" }
$CallbackUrl = "https://n8n-youtube-xs7s.onrender.com/webhook/youtube-websub"
$TopicUrl = "https://www.youtube.com/xml/feeds/videos.xml?channel_id=$ChannelId"

Write-Host ""
Write-Host "=== YouTube WebSub Subscribe ===" -ForegroundColor Cyan
Write-Host "Canal:  $ChannelId"
Write-Host "Topic:  $TopicUrl"
Write-Host "Callback: $CallbackUrl"
Write-Host ""

$body = @{
    "hub.mode"         = "subscribe"
    "hub.topic"        = $TopicUrl
    "hub.callback"     = $CallbackUrl
    "hub.verify"       = "async"
    "hub.lease_seconds" = "604800"
}

try {
    $response = Invoke-WebRequest -Uri "https://pubsubhubbub.appspot.com/subscribe" `
        -Method POST `
        -Body $body `
        -UseBasicParsing

    Write-Host "[OK] Inscricao enviada! Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "O Google vai validar o webhook em alguns segundos." -ForegroundColor Yellow
    Write-Host "Confirme no n8n > Executions do workflow WebSub receiver." -ForegroundColor Yellow
}
catch {
    Write-Host "[ERRO] Falha ao inscrever: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
