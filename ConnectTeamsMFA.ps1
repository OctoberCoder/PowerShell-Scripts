#Connect Microsoft Teams with MFA

Start-Transcript -Path "C:\transcripts\transcript2.txt" -NoClobber
Set-ExecutionPolicy RemoteSigned
Enable-PSRemoting
winrm get winrm/config/client/auth

Install-Module SkypeOnlineConnector
Import-Module SkypeOnlineConnector
$sfboSession = New-CsOnlineSession
Import-PSSession $sfboSession -AllowClobber
$webclient=New-Object System.Net.WebClient
$webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
Install-Module MicrosoftTeams
Import-Module MicrosoftTeams
Connect-MicrosoftTeams -Credential $UserCredential
#Get-Team
Get-CsOnlineUser -Identity rubygoldushers@mytekvm.onmicrosoft.com | FL
Stop-Transcript