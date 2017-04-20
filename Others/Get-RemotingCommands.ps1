<#
.Synopsis
 Get a list of possible remoting PowerShell commands

.Description
 Gets a list of possible remotin PowerShell commands based on the ComputerName and Session property parameter

.Parameter 
 parameterDescription

.Example
 eampleDesciption

#>


<#
DISCLAIMER:

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability or fitness for a particular purpose. 
This mail message assumes that you are familiar with the programming language that is being demonstrated and the tools that are used to create and debug procedures.
#requires -version 2.0

Author: Mark Warneke
Created: 14-Apr-17
#>

Get-Command | where { $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}