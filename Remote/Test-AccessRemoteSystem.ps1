$name = $(Get-WmiObject Win32_Computersystem).name
Test-WsMan $name