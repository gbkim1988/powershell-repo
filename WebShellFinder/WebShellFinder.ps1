function Get-Fuck  {
$DriverList = Get-PSDrive -PSProvider "FileSystem" | Where-Object {$_.Used }
$sha1 = New-Object -TypeName System.Security.Cryptography.sha1cryptoserviceprovider

foreach ( $drive in $DriverList ){

    Get-ChildItem $drive.Root -include *.exe -r | % { $_.FullName} | ForEach-Object {
        Write-Host -f Red $_ 
        $filehash = [System.BitConverter]::ToString($sha1.ComputeHash([System.IO.File]::ReadAllBytes($_))) -replace '-',''
        Write-Host -f Green $filehash
        New-Object PSObject -Property @{ 
            FileName = $_
            SHA1 = $filehash
        } | Select-Object -Property $properties 
    }
    }
}

Get-Fuck | Export-CSV -Path C:\TestReport.csv -NoTypeInformation