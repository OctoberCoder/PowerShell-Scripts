#Connect Teams Using PowerShell

Set-ExecutionPolicy RemoteSigned
winrm get winrm/config/client/auth
$UserCredential = Get-Credential
Import-Module SkypeOnlineConnector
$sfboSession = New-CsOnlineSession -Credential $UserCredential
Import-PSSession $sfboSession
$webclient=New-Object System.Net.WebClient
$webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
Install-Module MicrosoftTeams
Import-Module MicrosoftTeams
Connect-MicrosoftTeams
Get-CsOnlineUser -Identity admin@M365x869686.onmicrosoft.com