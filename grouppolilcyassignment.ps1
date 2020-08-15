Install-Module -Name AzureAd
Import-Module -Name AzureAD
Connect-AzureAD
Install-Module -Name MicrosoftTeams
Connect-MicrosoftTeams
Get-CsGroupPolicyAssignment

Register-PSRepository -SourceLocation https://www.poshtestgallery.com/api/v2 -Name PsTestGallery -InstallationPolicy Trusted
Uninstall-Module MicrosoftTeams -AllVersions
Install-Module MicrosoftTeams -Repository PSTestGallery
Connect-MicrosoftTeams

Get-CsGroupPolicyAssignment -GroupId 8b57aac9-b3e7-44f7-8ae4-ff7d71d77ca9
New-CsGroupPolicyAssignment -GroupId 7c6adfa0-526e-4bfd-a179-757d99f2063b -PolicyType TeamsMeetingPolicy -PolicyName AllOn -Rank 1