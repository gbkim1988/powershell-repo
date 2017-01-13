$a=Get-Content "C:\Users\YES24\Desktop\gurara.txt"
foreach ($i in $a)
{
    get-user $i | select displayname,samaccountname | Export-Csv output.csv -notype
}