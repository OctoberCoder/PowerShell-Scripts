#Powershell script to Archive an MS team  
#Created By: Isaac George
# Variable - Change the parameter as it need  
$ApplicationID = "9381bf0d-6128-478e-b1fd-5a0ed48d37d5"  
# Application ID as we have created during the Register application process  
$ClientSecret = "jvo0J3hmDk.Be_1ZE31dkCt0GPDhM.1S~-"  
# Application ID as we have created during the Register application process  
$ActiveDirectorydomainName = "263994CTS.onmicrosoft.com"  
# Active Directory Domain name  
$TeamName = "Test Team to Archive"  
# Display Name of the Team you want to archive.You can use other condition as well to archive the team Like there is no conversation or SPO activity for last 90 days  
#Ends  
#Connect App  
Connect - PnPOnline - AppId $ApplicationID - AppSecret $ClientSecret - AADDomain $ActiveDirectorydomainName  
# Get Access token of the App  
$token = Get - PnPAccessToken  
# Get all Teams availabe in Tenant  
$GetAllTeamsAPIURL = "https://graph.microsoft.com/beta/groups?`$filter=resourceProvisioningOptions/Any(x:x eq 'Team')"  
$headers = @ {  
    "Authorization" = "Bearer " + $token;  
    "Content-Type" = "application/json";
}  
$output = Invoke - RestMethod - Uri $GetAllTeamsAPIURL - Headers $headers - Method GET
#Ends  
#Loop all the Teams, Match with Team name we want to archive and call Archive Team Graph API  
foreach($value in $output.value) {  
    if ($value.displayName - eq $TeamName) {  
        $TeamID = $value.id  
        $ArchiveTeamAPIURL = "https://graph.microsoft.com/v1.0/teams/" + $TeamID + "/archive"  
        $response = Invoke - RestMethod - Uri $ArchiveTeamAPIURL - Headers $headers - Method "POST"
    }  
}  
#Ends
#https://www.c-sharpcorner.com/article/how-to-archive-ms-teams-using-graph-api-in-powershell/