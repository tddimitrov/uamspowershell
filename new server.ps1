#Run the script under your .adm account
#Script adds the server to an update schedule of your choice, adds a "managed by" entry in AD, and also adds server to the
#shared connections list in Windows Admin Center
#added to Git Repo
#some more changes


#add to update schedule

$group1 = "SCCM-SVR-SU-Production1"
$group2 = "SCCM-SVR-SU-Production2"
$group3 = "SCCM - SVR - SU - Production 3"
$group4 = "SCCM - SVR - SU - Production 4"
$computername = Read-Host -Prompt "Please enter name of the server"
$group = Read-Host -Prompt "`n Please choose a production group (1-4):

1. Production 1 - 4th Tuesday
2. Production 2 - Thursday after 4rth Tuesday
3. Production 3 - 4th Saturday
4. Production 4 - Last Wednesday"

if ($group -eq 1) { Add-ADGroupMember -Identity $group1 -Members $computername'$' && Write-Host "$computername has been added to Production 1 `n"} 

    elseif ($group -eq 2) { Add-ADGroupMember -Identity $group2 -Members $computername'$' && Write-Output "$computername has been added to Production 2 `n"}

    elseif ($group -eq 3) { Add-ADGroupMember -Identity $group3 -Members $computername'$' && Write-Output "$computername has been added to Production 3 `n"}
    
    elseif ($group -eq 4) { Add-ADGroupMember -Identity $group4 -Members $computername'$' && Write-Output "$computername has been added to Production 4 `n"}

#add managed by
Write-Host "Enter Server POC:`n"
$serverPOCFirstName = Read-Host -Prompt "First Name"
$serverPOCLastName = Read-Host -Prompt "Last Name"
$serverPOC = Get-ADUser -Filter {(givenname -eq $serverPOCFirstName) -and (sn -eq $serverPOCLastName) -and (samaccountname -notlike '*.adm') }
Set-ADComputer $computername -ManagedBy $serverPOC && Write-Host `n $computername "is now managed by" $serverPOC

#add server to WAC - use implicit remoting method
#using PSWindowsAdminCenter module from https://github.com/rchaganti/PSWindowsAdminCenter
#documentation on add-wacconnection - https://github.com/rchaganti/PSWindowsAdminCenter/blob/master/docs/Add-WacConnection.md

$s = New-PSSession -ComputerName wac
Invoke-Command -Session $s -ScriptBlock {$ConnectionName = $ConnectionName}
Invoke-Command -Session $s -ScriptBlock {"$env:ProgramFiles\windows admin center\PowerShell\Modules\ConnectionTools"}
Invoke-Command -Session $s -ScriptBlock {Get-Command -Module 'PSWindowsAdminCenter' | Select-Object -Property Name, CommandType | Out-Null}
Invoke-Command -session $s -scriptblock {$ConnectionName = Read-Host "Enter FQDN ofserver to be added to Windows Admin Center"}
Invoke-Command -session $s -ScriptBlock {Add-WacConnection -GatewayEndpoint 'https://wac.ad.uams.edu' -ConnectionName $ConnectionName -ConnectionType 'msft.sme.connection-type.server' -SharedConnection}



