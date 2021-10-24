#Use "Run Selection" to pick which code to execute.

#"Traditional" search by part of displayname
# output will be more verbose  and you can see more AD attributes
$displayname = Read-Host "enter name"
$namelookup = "*$displayname*"
Get-ADUser -Filter {name -like $namelookup} -properties * | Select-Object displayname, samaccountname, UserPrincipalName, employeenumber, lockedout, enabled, PasswordLastSet, LastBadPasswordAttempt, title | sort displayname |
Format-Table -AutoSize 


#Search based on ANR - ambiguous name resolution
#Quicker and more efficient searh but returns fewer attributes than the first one
$partofname = Read-Host "enter name"
Get-ADUser -LDAPFilter "(anr=$partofname)" | select name, samaccountname, userprincipalname | sort Name


