[cmdletBinding()]
Param(
 $Path = "D:\powershell-project\powershell-repo\SearchPersonalInformation"
) #end param

# Create Main Object 
$wordApplication = New-Object -comobject word.application
$wordApplication.visible = $false

# Find All Word Documents 

$wordDocs = Get-ChildItem -Path $Path -Recurse -Include *.docx,*.doc

# If you want to search word files that were last written to between
# certain date1 and certain date2, you could add pipelines to statements.
# Like, 
$wordDocs2 = Get-ChildItem -Path $Path -Recurse -Include *.docx,*.doc |
            Where-Object {$_.LastWriteTime -gt [datetime]"7/1/11" -and 
            $_.LastWriteTime -le [datetime]"6/30/12"} 
# For counting Words Files
$wordCounts = 1 
$searchText = "[0-9]{6,6}[\t\n\r\w\W -]*[0-9]{7,7}"
$searchTotal = 0

ForEach ( $word in $wordDocs ) {
    # Show Progress bar for Checking This Script is working ! 
    Write-Progress -Activity "워드 파일에서 패턴을 추출중입니다." -status "처리 중 $($word.FullName)" -PercentComplete ($wordCounts/$wordDocs.Count * 100)
    
    $document = $wordApplication.documents.open($word.FullName,$false,$true)
    $document.Paragraphs | ForEach-Object{
        # 출처 : https://www.reddit.com/r/PowerShell/comments/38dcm7/getting_specific_data_out_of_a_word_document/
        
        $_.Range.Text | Where-Object { $_ -match $searchText } | ForEach-Object { $_, $_.Range }
    }
    $document.close($false)
}
$wordApplication.quit()

#clean up stuff
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($document) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($wordApplication) | Out-Null
Remove-Variable -Name wordApplication
[gc]::collect()
[gc]::WaitForPendingFinalizers()

# Create Main Object 
$excelApplication = New-Object -comobject Excel.application
$excelApplication.visible = $false

# Find All Word Documents 

$excelDocs = Get-ChildItem -Path $Path -Recurse -Include *.xlsx,*.xls

# For counting Words Files
$excelCounts = 1 
$searchText = "[0-9]{6,6}[\t\n\r\w\W -]*[0-9]{7,7}"
$searchTotal = 0

ForEach ( $excel in $excelDocs ) {
    # Show Progress bar for Checking This Script is working ! 
    Write-Progress -Activity "엑셀 파일에서 패턴을 추출중입니다." -status "처리 중 $($excel.FullName)" -PercentComplete ($excelCounts/$excelDocs.Count * 100)
    $excel.FullName
    $workbook = $excelApplication.Workbooks.open($excel.FullName,$false,$true)
    $workbook.sheets | Select-Object -ExpandProperty Name | ForEach-Object{
        # 출처 : https://www.reddit.com/r/PowerShell/comments/38dcm7/getting_specific_data_out_of_a_word_document/
        $worksheet = $workbook.sheets.item($_)       
        $range = $worksheet.usedrange
        ForEach ($row in $range.rows) {
            #"($($row.Rows.Row), $($row.Columns.Column))"
            $row.Columns.Value2 | Where-Object { $_ -match $searchText } | ForEach-Object { $_, $_.Range }
        }   
    }
    $workbook.close($false)
}
$excelApplication.quit()

#clean up stuff
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($document) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($excelApplication) | Out-Null
Remove-Variable -Name excelApplication
[gc]::collect()
[gc]::WaitForPendingFinalizers()