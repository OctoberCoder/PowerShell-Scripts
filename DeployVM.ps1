Connect-AzAccount
New-AzResourceGroup -Name TutorialResources -Location eastus
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."
$vmParams = @{
  ResourceGroupName = 'TutorialResources'
  Name = 'TutorialVM1'
  Location = 'eastus'
  ImageName = 'Win2016Datacenter'
  PublicIpAddressName = 'tutorialPublicIp'
  Credential = $cred
  OpenPorts = 3389
}
$newVM1 = New-AzVM @vmParams
$newVM1
$newVM1.OSProfile | Select-Object ComputerName,AdminUserName
$newVM1 | Get-AzNetworkInterface |
  Select-Object -ExpandProperty IpConfigurations |
    Select-Object Name,PrivateIpAddress

$publicIp = Get-AzPublicIpAddress -Name tutorialPublicIp -ResourceGroupName TutorialResources

$publicIp | Select-Object Name,IpAddress,@{label='FQDN';expression={$_.DnsSettings.Fqdn}}

mstsc.exe /v 52.188.202.117

#Creating a new VM on the existing subnet

$vm2Params = @{
  ResourceGroupName = 'TutorialResources'
  Name = 'TutorialVM2'
  ImageName = 'Win2016Datacenter'
  VirtualNetworkName = 'TutorialVM1'
  SubnetName = 'TutorialVM1'
  PublicIpAddressName = 'tutorialPublicIp2'
  Credential = $cred
  OpenPorts = 3389
}
$newVM2 = New-AzVM @vm2Params
$newVM2

$newVM2.OSProfile | Select-Object ComputerName,AdminUserName
$newVM2 | Get-AzNetworkInterface |
  Select-Object -ExpandProperty IpConfigurations |
    Select-Object Name,PrivateIpAddress

$publicIp = Get-AzPublicIpAddress -Name tutorialPublicIp2 -ResourceGroupName TutorialResources

$publicIp | Select-Object Name,IpAddress,@{label='FQDN';expression={$_.DnsSettings.Fqdn}}

mstsc.exe /v 52.188.113.62

$job = Remove-AzResourceGroup -Name TutorialResources -Force -AsJob

$job

Wait-Job -Id $job.Id