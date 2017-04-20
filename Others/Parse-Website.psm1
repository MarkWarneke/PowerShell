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
     Created: 14-Apr-17


HELP

     .SYNOPSIS
         Parses a website by url and search criteria

     .DESCRIPTION
         Parses a certain ebsite by url based on the parameters provided like tags, classes or ids and returns the value found.
         Can be set to exit after one entry is found

     .PARAMETER URL
         The URL the script should get the content from.

     .EXAMPLE
         C:\PS>
         Parse-Website -Url $url -BestMatch -Element $Element -ElementId $id -ElementClass $class

     .INPUTS
         $url = the URL to get the content from
         $BestMatch = switch if only the first best match is returned or every match found
         $Element = the html element to search for
         $ElementId = the html id property to search for
         $ElementClass = the html class property to search for


     .OUTPUTS
         A string or a list of strings containing the values parsed from a website

     .NOTES
         Caveat: 
         Scraping a site isn’t illegal, but it might void the terms of some sites out there.  
         Furthermore, if you scrape too often, you might be blocked from the site temporarily or forever.  
         Don’t get greedy in scraping, or try to use it commercially.

        If a site provides an API, go that route instead, 
        as API are sanctioned and provided by the company to use, 
        and require 1% of the resources of loading a full page.

        Finally, some Content Management Systems will never update an existing page, 
        but create a new one with a new URL and update all links accordingly.  
        If you’re not careful, you could end up querying a page that will never change. 

#>


<#
Parses the website
#>
function Parse-Website {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Url,

        [int]
        $SecondsForRetry = (60*90),

        [int]
        $Attampts = 1,

        [switch]
        $BestMatch,

        [string]
        $ElemantName = "",

        [string]
        $ElementId = "",

        [string]
        $ElementClass = "text-uppercase"
    )
    
    begin {
        Write-Host "Parse site $Url"
    }
    
    process {


        for ($i = 0; $i -lt $attampts; $i++) {

            # Don't sleep at first try
            if (-not ($i -eq 0))  { Start-Sleep -Seconds ($SecondsForRetry) }

            $response = Invoke-WebRequest -Uri $Url
            $content = $response.ParsedHtml.body.getElementsByClassName($ElementClass) 

           $content | Select-Object -expand innerHTML

            if ($content) {
                $return = New-Object PSObject -Property @{            
                    InnerHTML   = $content.innerHTML                 
                    innerText   = $content.innerText        
                    TagName     = $content.tagName
                    ClassName   = $conten.className          
                    Id          = $content.id          
                    Url         = $Url      
                }                           
            } else {
                Write-Verbose "No match found."
            }

            
        }
    }
    
    end {
        return $return
    }
}

export-modulemember -function Parse-Website