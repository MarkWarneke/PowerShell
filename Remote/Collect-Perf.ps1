# http://sqlblog.com/blogs/aaron_bertrand/archive/2011/01/31/how-i-use-powershell-to-collect-performance-counter-data.aspx

param([string]$server, [string]$role, [string]$test, [int]$delay, [int]$count, [string]$path)            
            
function CollectPerf {            
  param(            
    [string]$server,            
    [string]$role,            
    [string]$test,            
    [int]$delay,            
    [int]$count,            
    [string]$path            
  )            
            
    if ($role -eq "app server")            
    {            
      $counters = @("\Processor(_Total)\% Processor Time",            
        "\System\Processor Queue Length"            
        # -- other counters            
      )            
    }            
            
    if ($role -eq "db server")            
    {            
      $counters = @("\PhysicalDisk(_Total)\Avg. Disk sec/Read",            
        "\SQLServer:SQL Statistics\Batch Requests/sec"            
        # -- other counters            
      )            
    }            
            
    # other roles...            
            
    $sequence = 1;            
            
    $metrics = Get-Counter -ComputerName $server -Counter $counters -SampleInterval $delay -MaxSamples $count            
            
    foreach($metric in $metrics)            
    {            
      $obj = $metric.CounterSamples | Select-Object -Property Path, CookedValue, Timestamp;            
      # add these columns as data            
      $obj | Add-Member -MemberType NoteProperty -Name Sequence -Value $sequence -Force;            
      $obj | Add-Member -MemberType NoteProperty -Name LoadTest -Value $test     -Force;            
      $obj | Add-Member -MemberType NoteProperty -Name Computer -Value $server   -Force;            
      # export with unique file name            
      $obj | Export-Csv -Path "$path$server.$test.$sequence.csv" -NoTypeInformation;            
      $sequence += 1;            
    }            
}            
CollectPerf -server $server -role $role -test $test -delay $delay -count $count -path $path