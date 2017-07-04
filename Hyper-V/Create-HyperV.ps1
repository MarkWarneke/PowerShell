#REQUIRES -Version 3.0

<#
DISCLAIMER:

     This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment.

             THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED AS IS
             WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
             TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.

     We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and
     to reproduce and distribute the object code form of the Sample Code,
     provided that You agree:
     (i) 	 to not use Our name, logo, or trademarks to market Your software
             product in which the Sample Code is embedded; 
     (ii) 	 include a valid copyright notice on Your software product in which 
             the Sample Code is embedded; and 
     (iii) 	 to indemnify, hold harmless, and defend Us and Our suppliers from and 
             against any claims or lawsuits, including attorneys' fees, that arise 
             or result from the use or distribution of the Sample Code.

     Please note: None of the conditions outlined in the disclaimer above will supersede terms and conditions contained within the Premier Customer Services Description.

     ALL CODE MUST BE TESTED BY ANY RECIPIENTS AND SHOULD NOT BE RUN IN A PRODUCTION ENVIRONMENT WITHOUT MODIFICATION BY THE RECIPIENT.

     Author: Mark Warneke <mark.warneke@microsoft.com>
     Created: <05-19-2017>


HELP

     .SYNOPSIS
         Creates a new Hyper-V Virtual Machine on the default location

     .DESCRIPTION
          Creates a new Hyper-V Virtual Machine on the default location with the mandatroy parameters
#>

function Create-HyperV {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $VmName = "NewVirtualMachine",
        $VmRam = 4GB,
        $VmVhdSize = 40GB,
        [string]  $VmPath = "C:\VMs",
        [string]  $VmNetworkSwitch = "Internal Virtual Switch",	
        [string]  $IsoFile = "C:\VMs\en_windows_server_2016_x64_dvd_9718492.iso"	

    )
    
    begin {
       
        if (-Not (Test-Path -Path $VmPath)) {
            Write-Verbose -Message "Create $VmPath directory"
            mkdir $VmPath -ErrorAction SilentlyContinue
        }

        if (-Not (Test-Path -Path $IsoFile)) {
            Write-Error -Message "Iso-File not found"
        }
    }
    
    process {
        
        $Switch = Get-VMSwitch -Name $VmNetworkSwitch -ErrorAction SilentlyContinue

        if ($Switch.Count -EQ 0){
            Write-Verbose -Message "Create Private $VmNetworkSwitch VMSwitch"
            New-VMSwitch -Name $VmNetworkSwitch -SwitchType Private
        }
 
        Write-Verbose -Message "Create new VM $VmName in $VmPath with $VmRam RAM $VmVhdSize GB"
        New-VM -Name $VmName -Path $VmPath -MemoryStartupBytes $VmRam -NewVHDPath $VmPath\$VmName.vhdx -NewVHDSizeBytes $VmVhdSize -SwitchName $VmNetworkSwitch

        Write-Verbose -Message "Configure VM $VmName drive $IsoFile"
        Set-VMDvdDrive -VMName $VmName -Path $IsoFile

        Start-VM $SRV1
    }
    
    end {
    }
}

export-modulemember -function Create-HyperV

