if( !(Test-Path tl-4.12.1-clients.zip) ){
    Invoke-WebRequest https://www.cendio.com/downloads/clients/tl-4.12.1-clients.zip -Outfile tl-4.12.1-clients.zip
}
Expand-Archive tl-4.12.1-clients.zip -DestinationPath . -Force
$BIN = $HOME + "\.local\bin"
if(!(Test-Path $BIN)){
    $BIN = New-Item $BIN -ItemType Directory
}
Get-Childitem ".\tl-4.12.1-clients\client-windows\tl-4.12.1-client-windows-x64\" |
Where-Object {$_.Name -match "libpulse.*\.dll|libprotocol-native\.dll|module.*\.dll$|pulseaudio\.exe$"} | ForEach-Object {Copy-Item -Path $_ -Destination $BIN}
Remove-Item -Force -Recurse tl-4.12.1-clients
$CONFDIR = $HOME + "\.config\pulse\"
if(!(Test-Path $CONFDIR)){
    New-Item $CONFDIR -ItemType Directory
}
$DAEMONCONF = $CONFDIR + "daemon.conf"
$DEFAULTPA = $CONFDIR + "default.pa"

Set-Content -Path $DAEMONCONF -Value "exit-idle-time = -1"
Set-Content -Path $DEFAULTPA -Value "load-module module-waveout sink_name=output source_name=input record=0`nload-module module-native-protocol-tcp auth-anonymous=1"
