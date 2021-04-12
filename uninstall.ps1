$BIN = $HOME + "\.local\bin"
Get-Childitem $BIN |
Where-Object {$_.Name -match "libpulse.*\.dll|libprotocol-native\.dll|module.*\.dll$|pulseaudio\.exe$"} | ForEach-Object {Remove-Item -Path $_}
$CONF = $HOME + "\.config\pulse"
if( Test-Path $CONF ){
    Remove-Item -Recurse -Force $CONF
}
if( Test-Path tl-4.12.1-clients.zip ){
    Remove-Item tl-4.12.1-clients.zip
}