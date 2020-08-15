Connecting to Exchange Online
*******************************

Before connecting to Office 365, need to update the Execution Policy on management station to RemoteSigned. To do this, run a PowerShell session as Administrator, run the following, and answer Y when prompted:

Set-ExecutionPolicy RemoteSigned

Next, connect to Office 365 Exchange Online.

$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session


Export Shared Mailboxes Permissions
***********************************

Get all Shared Mailboxes and users who have access rights

Get-Mailbox -Identity "HR" -RecipientTypeDetails SharedMailbox | Get-MailboxPermission | FT Identity, User, AccessRights

Get all Shared Mailboxes and users who have access rights

Get-Mailbox -RecipientTypeDetails SharedMailbox | Get-MailboxPermission | FT Identity, User, AccessRights
 
If you want to export the results in a .csv file, you can use following the cmdlet

Get-Mailbox -RecipientTypeDetails SharedMailbox | Get-MailboxPermission | Select Identity,User,@{Name='Access Rights';Expression={[string]::join(', ', $_.AccessRights)}} | Export-Csv C:\Temp\sharedmailboxpermission.csv –NoTypeInformation


Assign Permissions to Shared Mailboxes
**************************************

Assign Full Access permissions to a Shared Mailbox

Add-MailboxPermission -Identity Sales -User user1 -AccessRights FullAccess -InheritanceType All

Assign Full Access permissions to a User on all Mailboxes (Bulk mode)

Get-Mailbox -ResultSize unlimited -RecipientTypeDetails SharedMailbox | Add-MailboxPermission -User User1 -AccessRights FullAccess -InheritanceType all -AutoMapping $False


Assign Bulk permissions to Shared mailboxes

Create CSV file 
Name	            Email
HR	              User1@domain.com
Marketing	      User1@Domain.com

Import-csv "c:\Temp\Permissions.csv" | foreach { Add-MailboxPermission $_.name -User $_.email -AccessRights FullAccess }


Assign Full Access permissions to a User on multiple Exchange mailboxes | Mailboxes that have a specific mail address suffix

Get-Mailbox -ResultSize unlimited -RecipientTypeDetails SharedMailbox -Filter {(Email Addresses -like "*tech.com*")} | Add-MailboxPermission -User User1 -AccessRights FullAccess -InheritanceType all -AutoMapping $False