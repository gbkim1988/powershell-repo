##########################################################################
# Text2SpeechDemo-PowershellWPF.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 2-17-13
# Uses SAPI.SpVoice for Text to Speech
# Uses ShowUI interface to the Windows Presentation Foundation for the GUI
##########################################################################
If(-Not (Get-Module ShowUI)) { Import-Module ShowUI }

[System.Collections.ArrayList]$global:RateListItems = "-10","-9","-8","-7","-6","-5","-4","-3","-2","-1","0","1","2","3","4","5","6","7","8","9","10"
[System.Collections.ArrayList]$global:VolumeListItems = "0","05","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"

$VoiceItemList = @()
$Voice = New-Object -com SAPI.SpVoice
$VoiceList = $Voice.GetVoices()
for ($i=0; $i -lt $VoiceList.Count; $i++) {
	$VoiceItemList = $VoiceItemList + ($VoiceList.Item($i).GetDescription() )}      
[System.Collections.ArrayList]$global:PersonsListItems = $VoiceItemList

New-Window -Title "Text2Speech Demo" `
    -WindowStartupLocation CenterScreen `
    -Width 546 -Height 245  `
    -Background LightGray `
    -ResizeMode NoResize {
  New-StackPanel -Margin 15 {
        New-Label "Text2Speech Demo" `
            -FontSize 14 -FontWeight Bold `
            -HorizontalAlignment Center
        New-Label "Text" -Height 23 `
            -HorizontalAlignment Left
        New-TextBox -Name Text2Speak `
            -Width 500 -Height 23 `
            -HorizontalAlignment Left
    New-Grid -Rows 28, 28, 28, 28 ,28 -Columns 166, 166, 166 {
        New-Label "Rate" `
            -Row 0 -Column 0 -Height 23 `
            -HorizontalAlignment Left
        New-ComboBox -Name RateList `
            -Row 1 -Column 0 `
            -IsEditable:$false `
            -SelectedIndex 10 `
            -Height 23 -Width 121 `
            -Items $global:RateListItems `
            -HorizontalAlignment Left
 
        New-Label "Voice" `
            -Row 0 -Column 1 -Height 23 `
            -HorizontalAlignment Center
        New-ComboBox -Name PersonList `
            -Row 1 -Column 1 `
            -IsEditable:$false `
            -SelectedIndex 0 `
            -Height 23 -Width 121 `
            -Items $global:PersonsListItems `
            -HorizontalAlignment Center
 
        New-Label "Volume" `
            -Row 0 -Column 2 -Height 23 `
            -HorizontalAlignment Right
        New-ComboBox -Name VolumeList `
            -Row 1 -Column 2 `
            -IsEditable:$false `
            -SelectedIndex 20 `
            -Height 23 -Width 121 `
            -Items $global:VolumeListItems `
            -HorizontalAlignment Right
            
        New-Button "Speak" `
            -Row 3 -Column 1 `
            -Width 75 -Height 23 `
            -HorizontalAlignment Right `
            -On_Click {
            $Text  = $Window | Get-ChildControl Text2Speak
            $Rate  = $Window | Get-ChildControl RateList
            $Person  = $Window | Get-ChildControl PersonList
            $Volume  = $Window | Get-ChildControl VolumeList 
            $Voice.Voice = $Voice.GetVoices().Item(0)
            $Voice.Rate = $Rate.SelectedValue
            $Voice.Volume = $Volume.SelectedValue
            [void] $Voice.Speak($Text.Text) 
        } # End New-Button

        New-Button "Exit" `
            -Row 3 -Column 2 `
            -Width 75 -Height 23 `
            -HorizontalAlignment Right `
            -On_Click {
            $window.Close()
        } # End New-Button

      } # End Grid
   } # End StackPanel
} -show # End Window