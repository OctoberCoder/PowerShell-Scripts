Batch Assign Group Policy

Set-ExecutionPolicy RemoteSigned
winrm get winrm/config/client/auth

Import-PSSession $Session -DisableNameChecking
Install-Module -Name AzureAD
Import-Module AzureAD
Install-Module AzureADPreview -Scope CurrentUser
Install-Module MSOnline
Import-Module MSOnline
$Msolcred = Get-credential
Connect-MsolService -Credential $MsolCred
$webclient=New-Object System.Net.WebClient
$webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
set-item WSMan:\localhost\Client\AllowUnencrypted $true
Get-CsTeamsMeetingPolicy

Register-PSRepository -SourceLocation https://www.poshtestgallery.com/api/v2 -Name PsTestGallery -InstallationPolicy Trusted
Install-Module MicrosoftTeams -Repository PSTestGallery -Force


New-CsGroupPolicyAssignment -GroupId 17b10073-5838-4cba-9b81-0b7f4caff06a -PolicyType TeamsMeetingPolicy -PolicyName EnableMeetingChat -Rank 1

Get-CsGroupPolicyAssignment -PolicyType EnableMeetingChat

GroupId                              PolicyType         PolicyName Rank CreatedTime           CreatedBy
-------                              ----------         ---------- ---- -----------           ---------
d8ebfa45-0f28-4d2d-9bcc-b158a49e2d17 TeamsMeetingPolicy AllOn      1    10/29/2019 3:57:27 AM aeb7c0e7-2f6d-43ef-bf33-bfbcb93fdc64
Get-Module
set-item WSMan:\localhost\Client\AllowUnencrypted $true
