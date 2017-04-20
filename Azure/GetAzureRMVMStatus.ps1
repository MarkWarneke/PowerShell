[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True)]
  [string]$Name,
   [Parameter(Mandatory=$True)]
  [string]$ResourceGroupName
)
Get-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $Name -Status | `
     select -ExpandProperty Statuses | `
     ?{ $_.Code -match "PowerState" } | `
     select -ExpandProperty DisplayStatus