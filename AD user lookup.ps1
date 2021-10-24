$displayname = Read-Host "enter name"
$namelookup = "*$displayname*"
Get-ADUser -Filter {name -like $namelookup} -properties * | Select-Object displayname, samaccountname, UserPrincipalName, employeenumber, lockedout, enabled, PasswordLastSet, LastBadPasswordAttempt, title | sort displayname |
Format-Table -AutoSize 


#ambiguous name resolution
$partofname = Read-Host "enter name"
Get-ADUser -LDAPFilter "(anr=$partofname)" | select name, samaccountname, userprincipalname | sort Name


