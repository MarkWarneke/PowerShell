$RegistryPath = "HKLM:\SOFTWARE" 
$SearchProperty = "EnvironmentPathNode" 

Get-ChildItem -Path $RegistryPath | foreach { 
    $RegistryEntry = $_.Name
    Get-ItemProperty -Path $RegistryEntry | foreach {
        Write-Host $_
    }
}

# NOT WORKING