function Get-HashInfoItem {

    $DriverList = Get-PSDrive -PSProvider "FileSystem" | Where-Object {$_.Used }
    $sha1 = New-Object -TypeName System.Security.Cryptography.sha1cryptoserviceprovider

    foreach ( $drive in $DriverList ){
        Get-ChildItem $drive.Root -include *.exe -r | Select-Object FullName | ForEach-Object {
            Write-Host -f Red $_.FullName
            $filehash = [System.BitConverter]::ToString($sha1.ComputeHash([System.IO.File]::ReadAllBytes($_.FullName))) -replace '-',''
            Write-Host -f Green $filehash
            New-Object PSObject -Property @{ 
                FileName = $_.FullName
                SHA1 = $filehash
            } | Select-Object -Property $properties 
            # Garbage Collector Call
            [System.GC]::Collect()
        }
    }
}

Get-HashInfoItem | Export-CSV -Path C:\TestReport2.csv -NoTypeInformation -Encoding Unicode