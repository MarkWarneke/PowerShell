
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon 

# $objNotifyIcon.Icon = "C:\Scripts\Forms\Folder.ico"
$objNotifyIcon.BalloonTipIcon = "Info" 
$objNotifyIcon.BalloonTipText = "Retrieving files from C:\Windows." 
$objNotifyIcon.BalloonTipTitle = "Retrieving Files" 

$objNotifyIcon.Visible = $True 
$objNotifyIcon.ShowBalloonTip(10000)

Get-ChildItem C:\Windows

$objNotifyIcon.BalloonTipText = "The script has finished running." 
$objNotifyIcon.BalloonTipTitle = "Files retrieved." 

$objNotifyIcon.Visible = $True 
$objNotifyIcon.ShowBalloonTip(10000)