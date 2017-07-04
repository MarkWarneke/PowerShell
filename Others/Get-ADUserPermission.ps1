Import-Module ActiveDirectory
(Get-ACL "AD:$((Get-ADUser Twon.of.An).distinguishedname)").access