<# practice001.ps1

Intro.
YES24.COM 에 근무하고 있는 필자는 어느날 개인정보보호법 컴플라이언스 준수를 위하여 주민등록번호, 카드번호등의 
정보를 적절한 접근제어가 없이 저장되어 있는 사례를 발견하기 위해 스크립트를 작성하기로 결심하였다. 스크립트를 작성
하기에 앞서 적절한 스크립트 언어를 선택하여야 하는데 Windows 운영체제를 주로 사용하는 내부 환경을 고려하여 powershell
스크립트를 사용하기로 결정하였다. 

여기서 문제는 다양한 환경에 대해 powershell 스크립트가 적절히 동작을 수행할 수 있느냐는 점이다. 이점에 대한 조사는 
추후에 진행하도록 한다. 그 이유는 XP 는 이미 폐기된 OS 이며, 변경을 해야하는 OS 이다. 또한 잔여 비율이 낮으므로 비용대비
효과가 미비하므로 지속적인 관리보다는 시스템을 개선하는 방향으로 선회하는 것이 옳다고 여겨진다. 

원제로 회귀하여 powershell의 구성방안에 대해 기술하고자 한다. powershell은 .NET과 연동되어 docx, xlsx 등의 Microsoft 운영
체제가 지원하는 COM Object에 대한 API 가 다른 언어와 비교하여 우수하며 성능과 안정성이 보장되어 있다. 이러한 장점을 기반으로
여러 파일 포맷에 대한 고려 시간을 최소화하고 수정이 용이한 powershell을 선택하였음에 합당한 선택이라고 생각한다. 

powershell을 활용하여 검색 표준에 정규표현식을 도입하려고 하였으나, COM Object의 API상에 정규표현식을 이용한 검색은 제한이
존재하는 것을 확인하였다. 이보다는 확장된 검색 기능을 활용하여 검색을 하는 것이 목적과 효율에 부합한다고 판단하였다. (와일드
카드를 사용한 검색) 우선 이 방식은 마이크로소프트에서 제공하는 문서 객체에 한하여 적용가능하고 나머지 파일에 대해서는 정규
표현식을 사용하는 것으로 우선 마무리한다. 

powershell 스크립트의 구체적인 구성 내용
해당 스크립트의 목적은 과탐이 발생하더라도 미탐이 발생하지 않는다는 것을 대전제로 한다. 미탐보다는 과탐이 낮고 과탐을 임의의
방식을 통해 정정하는거나 추후의 탐지룰의 교정에 활용하는 것이 더욱더 낮다고 여겨진다. 이를 위해서는 탐지 문자열 또한 수집
하는 것이 옳다. 수집된 문자열이 어디에서 기인하였는지를 추적하는 방법은 해당 PC 자산의 정보를 수집하는 것이다. 이에 대해서는 
점검 대상의 소유주의 동의가 필요하므로 이에 대한 동의를 수집한다. 

주민등록번호 추출 키워드 2016.12.17 여러번의 테스트를 통해 얻어낸 값이다. 
[0-9]{6,6}[^t -]*[0-9]{7,7}

#>
[cmdletBinding()]
Param(
 $Path = "D:\powershell-project\practice001"
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
            ForEach ($col in $row.Columns){
                $row.Row
                $col.Column
                $col.Value2
            }
            #$row.Columns.Value2
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