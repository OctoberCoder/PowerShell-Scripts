Set-ExecutionPolicy RemoteSigned
winrm get winrm/config/client/auth
$credential = Get-Credential rubygoldushers@mytekvm.onmicrosoft.com
Install-Module MsOnline
Import-Module MsOnline
Connect-MsolService -credential $credential
$exchSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
Import-PSSession $exchSession -DisableNameChecking
Import-Module SkypeOnlineConnector
$sfboSession = New-CsOnlineSession -Credential $credential
Import-PSSession $sfboSession
Get-MsolUser –UserPrincipalName rubygoldushers@mytekvm.onmicrosoft.com
Get-Mailbox rubygoldushers@mytekvm.onmicrosoft.com
Get-CsOnlineUser -Identity rubygoldushers@mytekvm.onmicrosoft.com

Get-MsolUser -UserPrincipalName roommailbox@mytekvm.onmicrosoft.com | FL
Get-Mailbox roommailbox@mytekvm.onmicrosoft.com
Get-CsOnlineUser -Identity roommailbox@mytekvm.onmicrosoft.com

$newUser="roommailbox@mytekvm.onmicrosoft.com"

New-Mailbox –MicrosoftOnlineServicesID $newUser -Name "EvertyOne Meeting Room" -Room -RoomMailboxPassword (ConvertTo-SecureString –String "P@ssw0rd" -AsPlainText -Force) -EnableRoomMailboxAccount $true
Set-CalendarProcessing -Identity $newUser -AutomateProcessing AutoAccept -AddOrganizerToSubject $false -RemovePrivateProperty $false -DeleteComments $false -DeleteSubject $false –AddAdditionalResponse $true –AdditionalResponse "Your meeting is now scheduled and if it was enabled as a Skype Meeting will provide a seamless click-to-join experience from the conference room."
Set-Mailbox -Identity $newUser -MailTip "This room is equipped to support Skype for Business Meetings"




$pool=Get-CsOnlineUser -Identity "roommailbox@mytekvm.onmicrosoft.com" | select -expand RegistrarPool
Enable-CsMeetingRoom -Identity "roommailbox@mytekvm.onmicrosoft.com" -RegistrarPool $pool -SipAddressType EmailAddress

Get-CsMeetingRoom | ft Disp*,SIP*

======================================================================================================================================================================================================================================
Set-ExecutionPolicy Unrestricted
$org = 'mytekvm.onmicrosoft.com'
$cred = Get-Credential $rubygoldushers@$org
$sess = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $sess -DisableNameChecking
New-Mailbox -MicrosoftOnlineServicesID 'chrisroom@mytekvm.onmicrosoft.com' -Alias NEWROOM01 -Name "ChrisRoom--01" -Room -EnableRoomMailboxAccount $true -RoomMailboxPassword (ConvertTo-SecureString -String "P@ssw0rd2356833" -AsPlainText -Force)
Set-CalendarProcessing -Identity 'chrisroom@mytekvm.onmicrosoft.com' -AutomateProcessing AutoAccept -AddOrganizerToSubject $false -AllowConflicts $false -DeleteComments $false -DeleteSubject $false -RemovePrivateProperty $false
Set-CalendarProcessing -Identity 'chrisroom@mytekvm.onmicrosoft.com' -AddAdditionalResponse $true -AdditionalResponse "This is a Skype Meeting room!"

Connect-MsolService -Credential $cred
Set-MsolUser -UserPrincipalName 'chrisroom@mytekvm.onmicrosoft.com' -UsageLocation 'US'
Get-MsolAccountSku
Set-MsolUserLicense -UserPrincipalName 'chrisroom@mytekvm.onmicrosoft.com' -AddLicenses $strLicense

Import-Module SkypeOnlineConnector
$cred = Get-Credential
$cssess = New-CsOnlineSession -Credential $cred  
Import-PSSession $cssess -AllowClobber

Get-CsOnlineUser -Identity 'chrisroom@mytekvm.onmicrosoft.com' | FL
 *registrarpool* *sippoolAM33E09.infra.lync.com*
Get-CsOnlineUser -Identity "sip:chrisroom@mytekvm.onmicrosoft.com"
$rm = 
Enable-CsMeetingRoom -Identity chrisroom@mytekvm.onmicrosoft.com -RegistrarPool 'sippoolAM33E09.infra.lync.com' -SipAddressType EmailAddress