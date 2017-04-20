<#
Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability or fitness for a particular purpose. 
This mail message assumes that you are familiar with the programming language that is being demonstrated and the tools that are used to create and debug procedures.
#requires -version 2.0

.DESCRIPTION
.NOTES
Author: Mark Warneke
Created: 12-04-17
.LINK
#>

[CmdletBinding()]
Param(
    [
        Parameter(
            Mandatory=$True
        )
    ]
    [string] $Path,

    [
        Parameter(
            Mandatory=$True
        )
    ]
    [string] $SearchItemPropertyKeyName
)

# [string] $Path = "HKLM:\SYSTEM\ControlSet001\services\Dynamics Server\"
# [string] $Path = "HKLM:\SYSTEM\ControlSet001\Services\Dhcp"

# $SearchItemPropertyKeyName = "RegLocation"
# $SearchItemPropertyKeyValue = "SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\Interfaces\?\Dhcpv6DNSServers"

$Items = Get-ChildItem -Path $Path -Recurse 

foreach ($item in $Items) {

    $Propertys = Get-ItemProperty $item.PSPath
    
    foreach ($property in $Propertys) {
        if ( $property.$SearchItemPropertyKeyName  ) {
            $item
            $property
            Write-Host
        }
    }
    
}

