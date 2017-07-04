cmdkey /generic:DOMAIN/"computername or IP" /user:"username" /pass:"password"
# call RDP connection using
Start-Process -FilePath "$env:windir\system32\mstsc.exe" -ArgumentList "/v:computer name/IP" -Wait
# If you want to delete the credentials run
cmdkey /delete:DOMAIN/"Computer name or IP"