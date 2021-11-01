#Grab servers from a list, iterate and test connectivity, outputing the results to a csv file
#Obviously change location and name of source and output files to suit your needs.

$servers = Get-Content C:\Users\dimitrovtheodore.adm\Desktop\2008servers.txt

foreach ($server in $servers) {
    Test-NetConnection $server | Export-Csv -Path C:\Users\dimitrovteodord\Desktop\2008pingtest.csv -Append
}