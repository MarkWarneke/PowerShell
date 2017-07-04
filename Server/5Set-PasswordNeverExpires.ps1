wmic useraccount

$user = [adsi]"WinNT://$env:computername/administrator"
$user.UserFlags.value = $user.UserFlags.value -bor 0x10000
$user.CommitChanges()

# check PasswordExpires
wmic useraccount
