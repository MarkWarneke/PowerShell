#REQUIRES -Version 4.0
#REQUIRES -Modules MyModule1,MyModule2
#REQUIRES -RunAsAdministrator

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
     Created: <06-07-2017>


HELP

     .SYNOPSIS
 Renames and moves the file (!) inside a collection of folders to the parent folder and naming them as the folder they are contained.

     .DESCRIPTION
         Gets alls the folders inside a specified path. Enumerates them and looks for files inside the folder.
         It renames the files inside the folder to the folders name and moves it to the parent folder.
         deletes the parent folder of the file.

#>


<#
Brief descirption of the fuction.
#>
function RenameMove-FilesInFolder {
    [CmdletBinding()]
    [OutputType([int])]
    param(
        [Parameter(Mandatory = $true)]
        [string] $path,
        [bool] $test = $false
    )
    
    begin {
    
        $oldverbose = $VerbosePreference

        if ($test) {
            $p = "1234"
            $f = "test.txt"

            mkdir $p
            mv ".\$p.txt" ".\$p\$f"

            $VerbosePreference = "continue"
        }
    }
    
    process {

        $dirs = get-childitem -dir -Path $path 

        foreach ($dir in $dirs) {
            write-verbose ("In directory $directoryName") 
            $directoryName = $dir.Name
            $directoryParentDir = $dir.PSParentPath
            $files = Get-ChildItem $name

            if (-Not $files.Length) {
                Write-Error ("More than one file in $dir found - abroat")
                exit
            }
   
            foreach ($file in $files) {

                write-verbose ("Got file $file")
                $fileName = $file.Name
                $fileDirectory = $file.DirectoryName

                try {
                    write-verbose ("Moving $file from $fileDirectory to $directoryParentDir with name $directoryName.txt")
                    move-item "$fileDirectory\$fileName" "$directoryParentDir\$directoryName.txt"

                    write-verbose ("Deleting $file parent directory $dir")
                    remove-item $dir

                    Get-ChildItem
                } catch {
                    write-error ("Unable to move-item $file to $dir")
                }

            }
        }

        $VerbosePreference = $oldverbose
    }
    
    end {
    }
}
