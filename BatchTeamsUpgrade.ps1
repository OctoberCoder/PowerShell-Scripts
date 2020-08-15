<#
=============================================================================================
Name:           Batch TeamsUpgrade User
Description:    This script performs the action of upgrading users in a .csv file to TeamsOnly coexistence mode
Version:        1.0
Released date:  15/03/2020
website:        lighthousemedia.netlify.app
Script by:      Lighthouse Coders Team (Proud Creators of Office 365 Reporting Tool)


To run the script
./BatchTeamsUpgrade.ps1
============================================================================================
#>

Set-ExecutionPolicy RemoteSigned
winrm get winrm/config/client/auth
$UserCredential = Get-Credential
Import-Module SkypeOnlineConnector
$sfboSession = New-CsOnlineSession -Credential $UserCredential
Import-PSSession $sfboSession -AllowClobber
$webclient=New-Object System.Net.WebClient
$webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
Install-Module MicrosoftTeams
Import-Module MicrosoftTeams
Connect-MicrosoftTeams


$dataSetFilePath = "C:\Users\isaac.george\Desktop\grouphr.csv"

$dataSet = Import-Csv "$($dataSetFilePath)" -Header UserId –delimiter ","

 foreach($line in $dataSet)
 {
    $userId = $line.UserId
    Write-Host $userId
    Grant-CsTeamsUpgradePolicy -Identity @UserId -PolicyName Upgragetoteams
}