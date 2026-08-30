$script:BravePath = "${env:ProgramFiles}\BraveSoftware\Brave-Browser\Application\brave.exe"

function Open-Link {
    param([Parameter(Mandatory = $true)][string]$Url)

    if (Test-Path $script:BravePath) {
        Start-Process $script:BravePath $Url
    } else {
        Start-Process $Url
    }
}
