Get-WindowsFeature
$Name = (Get-WMIObject Win32_ComputerSystem).name

Rename-Computer -NewName "Demo" -restart 

$Name = (Get-WMIObject Win32_ComputerSystem).name

Install-WindowsFeature -Name DNS, AD-Domain-Services -ComputerName $Name

Install-ADDSForest -DomainName “CONTOSO.com” 

Write-Verbose "Install .NET Framework 3.5 from WinSrv12 ISO"
Install-WindowsFeature -Name Net-Framework-Feature -Source D:\sources\sxs


# install sql server

netsh firewall set portopening protocol = TCP port = 1433 name = SQLPort mode = ENABLE scope = SUBNET profile = CURRENT  


# install sp1 for visual studio download

Install-WindowsFeature Windows-Identiy-Foundation