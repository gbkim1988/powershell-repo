[cmdletBinding()] 
Param( 
$wordFile = “C:\fso1\words.CSV”, 
$docPath = “C:\fso1\TestHSG.Doc” 
) #end param 
add-type -AssemblyName “Microsoft.Office.Interop.Word” 
$wdunits = “Microsoft.Office.Interop.Word.wdunits” -as [type] 
$application = New-Object -comobject word.application 
$application.visible = $False 
$words = Import-Csv $wordFile 
$docs = Get-childitem -Path $docPath -Include *.doc,*.docx -Recurse 
Foreach ($doc in $docs) 
{ 
Write-Verbose -Message “Processing $($doc.fullname)” 
$document = $application.documents.open($doc.FullName) 
$range = $document.content 
$null = $range.movestart($wdunits::wdword,$range.start) 
$matchCase = $false 
$matchWholeWord = $true 
$matchWildCards = $false 
$matchSoundsLike = $false 
$matchAllWordForms = $false 
$forward = $true 
$wrap = 1 
Foreach ($word in $words) 
{ 
$findText = $word.Word 
write-verbose -Message “looking for $($findText)” 
$wordFound = $range.find.execute($findText,$matchCase, 
$matchWholeWord,$matchWildCards,$matchSoundsLike, 
$matchAllWordForms,$forward,$wrap) 
Write-Verbose -Message “$($findText) returned $wordFound” 
if($wordFound) 
{ 
if($Range.style.namelocal -eq “normal”) 
{$null = $document.HyperLinks.Add($Range, $word.URL,$null,$null,$FindText)} 
ELSE 
{ 
Write-Verbose -Message ` 
“$($findText) not modified because it is $($Range.style.namelocal)” 
} 
} #end if $wordFound 
$range = $document.content 
$null = $range.movestart($wdunits::wdword,$range.start) 
$wordFound = $false 
} #end foreach $word 
$document.save() 
$document.close() 
} #end foreach $doc 
$application.quit() 
Remove-Variable -Name application 
[gc]::collect() 
[gc]::WaitForPendingFinalizers()