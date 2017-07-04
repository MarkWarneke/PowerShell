$Name = (Get-WMIObject Win32_ComputerSystem).name

Install-WindowsFeature -Name DNS, AD-Domain-Services -ComputerName $Name