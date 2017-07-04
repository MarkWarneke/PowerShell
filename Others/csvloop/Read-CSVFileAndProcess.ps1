<#
DISCLAIMER:

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability or fitness for a particular purpose. 
This mail message assumes that you are familiar with the programming language that is being demonstrated and the tools that are used to create and debug procedures.
#requires -version 2.0

Author: Mark Warneke
Created: 13-Apr-17
#>

<#
.Synopsis
 synopsis

.Description
 Short script to load csv into an array and process this information

.Parameter CsvPath
 Path to the CSV file

.Example
 

#>


function Read-CSVFileAndProcess {
    [CmdletBinding()]
    param (
         [Parameter (
             Mandatory = $True, 
             ValueFromPipelineByPropertyName = $True
        )] 
        [string] $CsvPath
    )
    

    $Dirs = Import-Csv $CsvPath

    foreach ($dir in $Dirs) {
        $number = $dir.sub(4,4)
        Write-Host $dir
        $new = New-Item $dir -type directory -value $number+1
        "test" > $new
    }

}

export-modulemember -function Read-CSVFileAndProcess