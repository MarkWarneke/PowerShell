#REQUIRES -Version 2.0

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
     Created: 05-30-2017


HELP

     .SYNOPSIS
         Funciton to get the start time of the service through the wmi api 

     .DESCRIPTION
         Funciton to get the start time of the service through the wmi api
        Gets the service by name and gets the actual process startet.

      .PARAMETER
        ComputerName

      .PARAMETER
        Name ServiceName


     .EXAMPLE
         C:\PS> .\Get-ServiceStartTime.ps1 -ComputerName “mytestpc1” -Name spooler

     .EXAMPLE
        C:\PS> .\Get-ServiceStartTime.ps1 -ComputerName “mytestpc1”, “mytestpc2” -Name spooler

      .Source
        http://techibee.com/powershell/powershell-query-windows-service-start-time/1336
#>


<#
Funciton to get the start time of the service through the wmi api
Gets the service by name and gets the actual process startet.
#>

[cmdletbinding()]            

param (
    [parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string[]]$ComputerName = $env:computername,            

    [ValidateNotNullOrEmpty()]
    [parameter(Mandatory = $true)]
    [Alias("ServiceName")]
    [string]$Name            

)            

begin {}            

Process {            

    foreach ($Computer in $ComputerName) {
        if (Test-Connection -ComputerName $Computer -Count 1 -ea 0) {
            Write-Verbose "$Computer is online"

            Write-Verbose "Query ServiceName $Name fom $Computer"
            $Service = Get-WmiObject -Class Win32_Service -ComputerName $Computer -Filter "Name='$Name'" -ea 0

            if ($Service) {

                Write-Verbose "Service $Name found, obtain PID"
                $ServicePID = $Service.ProcessID

                Write-Verbose "Query process information $ServicePID from ServiceName $Name fom $Computer"
                $ProcessInfo = Get-WmiObject -Class Win32_Process -ComputerName $Computer -Filter "ProcessID='$ServicePID'" -ea 0

                Write-Verbose "Create return object"
                $OutputObj = New-Object -Type PSObject
                $OutputObj | Add-Member -MemberType NoteProperty -Name ComputerName -Value $Computer.ToUpper()
                $OutputObj | Add-Member -MemberType NoteProperty -Name Name -Value $Name
                $OutputObj | Add-Member -MemberType NoteProperty -Name DisplayName -Value $Service.DisplayName
                $OutputObj | Add-Member -MemberType NoteProperty -Name StartTime -Value $($Service.ConvertToDateTime($ProcessInfo.CreationDate))
                $OutputObj

            }
            else {
                write-verbose "Service `($Name`) not found on $Computer"
            }
        }
        else {
            write-Verbose "$Computer is offline"
        }
    }            

}            

end {}