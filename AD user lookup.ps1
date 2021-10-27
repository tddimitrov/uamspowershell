#Use hilight each section ("traditional" or ANR serach) and then use "Run Selection" to execute.

#"Traditional" search by part of displayname
# output will be more verbose  and you can see more AD attributes
$displayname = Read-Host "enter name"
$namelookup = "*$displayname*"
Get-ADUser -Filter { name -like $namelookup } -Properties * | Select-Object displayname, samaccountname, UserPrincipalName, employeenumber, lockedout, enabled, PasswordLastSet, LastBadPasswordAttempt, title | Sort-Object displayname |
Format-Table -AutoSize 


#Search based on ANR - ambiguous name resolution
#Quicker and more efficient searh but returns fewer attributes than the first one
$partofname = Read-Host "enter name"
Get-ADUser -LDAPFilter "(anr=$partofname)" | Select-Object name, samaccountname, userprincipalname | Sort-Object Name
