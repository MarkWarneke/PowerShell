<#
.SYNOPSIS
 Create a New Perfmon Data Collector Set from an XML input
.DESCRIPTION
 Create a New Perfmon Data Collector Set from an XML input
 Use PowerShell remoting to create these on a remote server.
 Remoting must be enabled on target servers
.NOTES
 Authors:  Jonathan Medd
.PARAMETER CSVFilePath
 Path of CSV file to import
.PARAMETER XMLFilePath
 Path of XML file to import
.PARAMETER DataCollectorName
 Name of new Data Collector. This should match the name in the XML file
.EXAMPLE
 New-DataCollectorSet -CSVFilePath C:\Scripts\Servers.csv -XMLFilePath C:\Scripts\PerfmonTemplate.xml -DataCollectorName CPUIssue
#>
param (
 [parameter(Mandatory=$True,HelpMessage='Path of CSV file to import')]
 $CSVFilePath
 ,
 [parameter(Mandatory=$True,HelpMessage='Path of XML file to import')]
 $XMLFilePath
 ,
 [parameter(Mandatory=$True,HelpMessage='Name of new Data Collector')]
 $DataCollectorName
 )

# Test for existence of supplied CSV and XML files
if (Test-Path $CSVFilePath){
 }
else{
 Write-Host "Path to CSV file is invalid, exiting script"
 Exit
 }
if (Test-Path $XMLFilePath){
 }
else{
 Write-Host "Path to XML file is invalid, exiting script"
 Exit
 }

# Generate list of servers to create Perfmon Data Collector Sets on
$servers = Get-Content $CSVFilePath

foreach ($server in $servers){

Write-Host "Creating Data Collector Set on $Server"

# Test if the folder C:\temp exists on the target server
if (Test-Path "\\$server\c$\Temp"){

 # Copy the XML file to the target server
 Copy-Item $XMLFilePath "\\$server\c$\Temp"

 # Use PowerShell Remoting to execute script block on target server
 Invoke-Command -ComputerName $server -ArgumentList $DataCollectorName -ScriptBlock {param($DataCollectorName)

 # Create a new DataCollectorSet COM object, read in the XML file,
 # use that to set the XML setting, create the DataCollectorSet,
 # start it.
 $datacollectorset = New-Object -COM Pla.DataCollectorSet
 $xml = Get-Content C:\temp\PerfmonTemplate.xml
 $datacollectorset.SetXml($xml)
 $datacollectorset.Commit("$DataCollectorName" , $null , 0x0003) | Out-Null
 $datacollectorset.start($false)
 }

 # Remove the XML file from the target server
 Remove-Item "\\$server\c$\Temp\PerfmonTemplate.xml"
 }
else{
 Write-Host "Target Server does not contain the folder C:\Temp"
 }
}
