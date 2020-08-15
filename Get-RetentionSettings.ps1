#
# Get-RetentionSettings.ps1
# by Rui Tabares (rupereir@microsoft.com)
#
# Note: Microsoft Teams PS module is required
#

write-host
write-host "Enter tenant admin credentials:"
$UserCredential = Get-Credential

write-host
write-host "Connecting to Exchange Online..."
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking -AllowClobber

write-host
write-host "Connecting to Security & Compliance Center..."
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking -AllowClobber

write-host
write-host "Connecting to Microsoft Teams..."
Import-Module MicrosoftTeams
$null = Connect-MicrosoftTeams -Credential $UserCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

write-host
write-host
$MailboxSmtp= Read-host "Enter mailbox"
$Mailbox=Get-mailbox -identity $Mailboxsmtp
Get-MailboxFolderStatistics -Identity $Mailbox.PrimarySmtpAddress -IncludeAnalysis | sort name|?{$_.TopSubjectClass -like "IPM.SkypeTeams.Message"}| select folderpath,ItemsInFolder,Deletepolicy,Archivepolicy,LastModifiedTime

write-host
if ($Mailbox.ArchiveGuid -like "00000000-0000-0000-0000-000000000000"){
write-host "Archive Mailbox: True"
}else {
write-host "Archive Mailbox: False"
write-host "Archive Mailbox Name:" $Mailbox.ArchiveName
Get-MailboxFolderStatistics -Identity $Mailbox.PrimarySmtpAddress -IncludeAnalysis -archive | sort name|?{$_.TopSubjectClass -like "IPM.SkypeTeams.Message"}| select folderpath,ItemsInFolder,Deletepolicy,Archivepolicy,LastModifiedTime
}
write-host "Litigation Hold Enabled:" $Mailbox.LitigationHoldEnabled    
write-host "Retention Hold Enabled:" $Mailbox.RetentionHoldEnabled     
Write-host "Delay Hold Applied:" $Mailbox.DelayHoldApplied
write-host "In-place Hold:" $Mailbox.InPlaceHolds 
Write-host "Retention Policy:" $Mailbox.RetentionPolicy
Write-host "Retention Policy from the mailbox:"
Get-RetentionPolicy -Identity $Mailbox.RetentionPolicy

write-host
write-host "Teams Retention Policies:"
Get-TeamsRetentionCompliancePolicy | select Name,Mode,Enabled,Type,Workload

write-host
write-host "Teams Retention Policy Rules:"
Get-TeamsRetentionComplianceRule | select Name,RetentionDuration,RetentionComplianceAction,ExpirationDateOption,Disabled,Mode

write-host
Get-PSSession | where {$_.ConfigurationName -eq "Microsoft.Exchange"} | Remove-PSSession