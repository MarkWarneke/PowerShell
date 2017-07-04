gci 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' |
sort pschildname -des                                  |
select -fi 1 -exp pschildname