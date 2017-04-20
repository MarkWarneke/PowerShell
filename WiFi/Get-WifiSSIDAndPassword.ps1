#Make a list with all WiFi SSID's and passwords stored locally on Windows OS.

$output = netsh.exe wlan show profiles
$profileRows = $output | Select-String -Pattern 'All User Profile'
$profileNames = New-Object System.Collections.ArrayList

#for each profile name get the SSID and password
for($i = 0; $i -lt $profileRows.Count; $i++){
    $profileName = ($profileRows[$i] -split ":")[-1].Trim()
    
    $profileOutput = netsh.exe wlan show profiles name="$profileName" key=clear
    
    $SSIDSearchResult = $profileOutput| Select-String -Pattern 'SSID Name'
    $profileSSID = ($SSIDSearchResult -split ":")[-1].Trim() -replace '"'

    $passwordSearchResult = $profileOutput| Select-String -Pattern 'Key Content'
    if($passwordSearchResult){
        $profilePw = ($passwordSearchResult -split ":")[-1].Trim()
    } else {
        $profilePw = ''
    }
    
    $networkObject = New-Object -TypeName psobject -Property @{
        ProfileName = $profileName
        SSID = $profileSSID
        Password = $profilePw
    }
    $profileNames.Add($networkObject)
}

$profileNames | Sort-Object ProfileName | Select-Object ProfileName, SSID, Password

#blog help source: https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/23/get-wireless-network-ssid-and-password-with-powershell/