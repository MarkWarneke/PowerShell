function rdpvm ($ServiceName,$Name) {
  $vm = (Get-AzureVM -ServiceName $ServiceName -Name $Name)
  if($vm -and $vm.InstanceStatus -eq 'ReadyRole') {
    $rdp = (Get-AzureEndpoint -VM $vm | where { $_.LocalPort -eq 3389})
    $fqdn = (New-Object System.URI $vm.DNSName).Authority
    $port = $rdp.Port
    Write-Verbose "Opening Remote Desktop Session with $($fqdn):$($port)..."
    Start-Process "mstsc" -ArgumentList "/V:$($fqdn):$($port)"
  }
  else {
    Write-Warning "The VM $($vm.Name) is not running ($($vm.InstanceStatus)).  You should start it first"
  }
}