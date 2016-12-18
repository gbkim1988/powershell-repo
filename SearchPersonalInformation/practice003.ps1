Add-Type -AssemblyName System.Windows.Forms
# WinForm Setup
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,9"
$mainForm.ForeColor = "Black"
$mainForm.BackColor = "PaleGoldenrod"
$mainForm.Text = " Image2Base64 Converter"
$mainForm.Width = 570
$mainForm.Height = 200
 
# Output Box
$textBoxOut = New-Object System.Windows.Forms.TextBox
$textBoxOut.Location = "35, 85"
$textBoxOut.Size = "415, 20"
$mainForm.Controls.Add($textBoxOut)
 
# Input Box
$textBoxIn = New-Object System.Windows.Forms.TextBox
$textBoxIn.Location = "35, 25"
$textBoxIn.Size = "415, 20"
$mainForm.Controls.Add($textBoxIn)

# Browse Input Button
$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Location = "460, 25"
$buttonBrowse.Size = "75, 23"
$buttonBrowse.Text = "Browse"
$buttonBrowse.add_Click({selectFiles})
$mainForm.Controls.Add($buttonBrowse)
 
function selectFiles {
    $selectForm = New-Object System.Windows.Forms.OpenFileDialog
    $selectForm.Filter = "All Files (*.*)|*.*"
    $selectForm.InitialDirectory = ".\"
    $selectForm.Title = "Select a File to Process"
    $getKey = $selectForm.ShowDialog()
    If ($getKey -eq "OK") {
            $textBoxIn.Text  = $selectForm.FileName
            $work = $selectForm.FileName
            $work = $work.SubString(0, ($work.Length -3)) + "txt"
            $textBoxOut.Text = $work
            $completeLabel.Text = "      "
    }
} # End SelectFile

Function convertButton {
    $error.clear()
    $inFileName = $textBoxIn.Text
    $outFileName = $textBoxOut.Text
    $encodedImage = [convert]::ToBase64String((get-content $inFileName -encoding byte))
    $encodedImage -replace ".{80}" , "$&`r`n" | set-content $outFileName
    If ($error.count -gt 0) {
        $completeLabel.Text = "Error!"
    }
    Else {
        $completeLabel.Text = "Done!"
    }
} # End convertButton