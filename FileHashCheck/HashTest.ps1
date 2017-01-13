# Powershell 의 자원 소모를 20MB 로 제한
# sl WSMan:\Localhost\Shell
# Set-Item .\MaxMemoryPerShellMB 20

# Driver List 호출
# 아래의 명령으로 드라이버를 출력 시 CD Drive 를 필터하지 못함 
# Root 칼럼만 추출
Measure-Command {
$DriverList = Get-PSDrive -PSProvider "FileSystem" | Where-Object {$_.Used }
$sha1 = New-Object -TypeName System.Security.Cryptography.sha256cryptoserviceprovider

foreach ( $drive in $DriverList ){
    Write-Host -f Green "Searching ", $_.Root
    try{
        Get-ChildItem $drive.Root -include *.exe,*.dll -r | % { $_.FullName} | ForEach-Object {
            #Write-Host -f Red $_ 
            $filehash = [System.BitConverter]::ToString($sha1.ComputeHash([System.IO.File]::ReadAllBytes($_))) -replace '-',''
            #$filehash
            New-Object PSObject -Property @{ 
                FileName = $_
                SHA1 = $filehash
            } | Select-Object -Property $properties 
        } 
    }catch [PathNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand]{
        Write-Host "error"
    }finally{
        Write-Host "finally"
    }
    #$someFilePath = "C:\foo.txt"
    #
    #$hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($someFilePath)))
}
}

# powershell 시간 소요 측정
# https://www.pluralsight.com/blog/tutorials/measure-powershell-scripts-speed

# 아래의 구문은 Get-WmiObject 명령을 사용하여 드라이브를 불러온다.
# 아래의 명령은 시스템 예약 영역도 보여주는데 음 .... 의미가 있을지...

#Get-WmiObject Win32_Volume | Format-Table Name, Label, FreeSpace, Capacity
<#
Get-WmiObject Win32_Volume -Filter "DriveType='3'" | ForEach {
    New-Object PSObject -Property @{
        Name = $_.Name
        Label = $_.Label
        FreeSpace_GB = ([Math]::Round($_.FreeSpace /1GB,2))
        TotalSize_GB = ([Math]::Round($_.Capacity /1GB,2))
    }
}#>

# EXE, DLL 의 파일 목록을 호출

