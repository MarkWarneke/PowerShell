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
     Created: <mm-dd-yyyy>


HELP

     .SYNOPSIS
         Send an email to an recipient using ssl 

     .DESCRIPTION
         Send an email from an certain email adress to a recepient, provided as a parameter with a certain smtp

     .PARAMETER
         $To
         Email Recepient

    .PARAMETER
         $To
         Email Recepient

     .EXAMPLE
        Send-Email
#>


<#
Brief descirption of the fuction.
#>
function Send-Email {
    [CmdletBinding()]
    [OutputType([int])]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $To,
        [Parameter(Mandatory=$true)]
        [string]
        $Body,
        [string]
        $Subject  = "Notification",
        [string]
        $EmailFrom  = "from@mail.com",
        [string]
        $SMTPServer  = "YOUR.SMTP.MAIL.SERVER"
    )
    
    begin {
    }
    
    process {
        try {
            $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
            $SMTPClient.EnableSsl = $true 
            $SMTPClient.Credentials = Get-Credential $EmailFrom
            $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
        } catch {
            Write-Error "sending mail from $From to $To failed"
        }

    }
    
    end {
    }
}

# export-modulemember -function Send-Email