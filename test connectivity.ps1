#Grab servers from a list, iterate and test connectivity, outputing the results to a csv file

$servers = Get-Content C:\Users\dimitrovtheodore.adm\Desktop\2008servers.txt

foreach ($server in $servers) {
    Test-NetConnection $server | Export-Csv -Path C:\Users\dimitrovteodord\Desktop\2008pingtest.csv -Append
}