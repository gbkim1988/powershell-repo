###################################################################
# Text2Braille.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 12-27-14
# PowerShell Convert Text to Braille Image
####################################################################
Add-Type -AssemblyName System.Windows.Forms
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:outFile = ""

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Location = "200, 200"
$mainForm.Font = "Comic Sans MS,9"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.Text = " Convert Text to Braille Image"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "Wheat"
$mainForm.Size = "610, 410"

# Input Text Label
$inputTextLabel = New-Object System.Windows.Forms.Label
$inputTextLabel.Location = "100,8"
$inputTextLabel.ForeColor = "MediumBlue"
$inputTextLabel.Size = "50, 22"
$inputTextLabel.Text = "Text"
$mainForm.Controls.Add($inputTextLabel)

# Input Text TextBox
$inputTextTextBox = New-Object System.Windows.Forms.TextBox
$inputTextTextBox.Location = "20,30"
$inputTextTextBox.Size = "230,330"
$inputTextTextBox.MultiLine = $true
$inputTextTextBox.ForeColor = "MediumBlue"
$inputTextTextBox.BackColor = "White"
$inputTextTextBox.Text = ""
$mainForm.Controls.Add($inputTextTextBox)

# Completed Label
$completedLabel = New-Object System.Windows.Forms.Label
$completedLabel.Location = "520,170"
$completedLabel.Size = "60, 22"
$completedLabel.ForeColor = "Green"
$completedLabel.Text = ""
$mainForm.Controls.Add($completedLabel)

# PictureBox
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Location = "260, 30"
$pictureBox.ClientSize = "230, 330"
$pictureBox.BackColor = "Black"
$pictureBox.SizeMode = "StretchImage"
$mainForm.Controls.Add($pictureBox)

# PictureBox Label
$PictureBoxLabel = New-Object System.Windows.Forms.Label
$PictureBoxLabel.Location = "350,8"
$PictureBoxLabel.ForeColor = "MediumBlue"
$PictureBoxLabel.Size = "110, 22"
$PictureBoxLabel.Text = "Braille"
$mainForm.Controls.Add($PictureBoxLabel)

# Generate Button
$generateButton = New-Object System.Windows.Forms.Button 
$generateButton.Location = "510,30"
$generateButton.Size = "75,28"
$generateButton.ForeColor = "DarkBlue"
$generateButton.BackColor = "White"
$generateButton.Text = "Convert"
$generateButton.add_Click({GetBraille($scriptPath)})
$mainForm.Controls.Add($generateButton)

# Display Button
$displayButton = New-Object System.Windows.Forms.Button
$displayButton.Location = "510,60"
$displayButton.Size = "75, 28"
$displayButton.BackColor = "White"
$displayButton.ForeColor = "DarkBlue" 
$displayButton.Text = "Display"
$displayButton.add_Click({DisplayImage})
$mainForm.Controls.Add($displayButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "510,90"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)


# Font Size Label
$fontSizeLabel = New-Object System.Windows.Forms.Label
$fontSizeLabel.Location = "500,130"
$fontSizeLabel.ForeColor = "MediumBlue"
$fontSizeLabel.Size = "60, 22"
$fontSizeLabel.Text = "Font Size"
$mainForm.Controls.Add($fontSizeLabel)

# Font Size TextBox
$fontSizeTextBox = New-Object System.Windows.Forms.TextBox
$fontSizeTextBox.Location = "560,130"
$fontSizeTextBox.Size = "30,20"
$fontSizeTextBox.ForeColor = "MediumBlue"
$fontSizeTextBox.BackColor = "White"
$fontSizeTextBox.Text = "18"
$mainForm.Controls.Add($fontSizeTextBox)

Function GetBraille {
    $error.clear()
    $getBraille = New-WebServiceProxy -uri "http://www.webservicex.net/braille.asmx?WSDL"
    $returnedImage = $getBraille.BrailleText($inputTextTextBox.Text, $fontSizeTextBox.Text)
    $global:outFile = $scriptPath + "\"  + "Text2Braille_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".jpg"
    Set-Content -Path $global:outFile -Value $returnedImage -Encoding Byte
    If($error.count -gt 0) {
        $completedLabel.Text = "Error!"
        $completedLabel.ForeColor = "Red"
    }
    Else {
        $completedLabel.Text = "Success!"
        $completedLabel.ForeColor = "Green"
    }
    PictureBox($global:outFile)
    $getBraille.Dispose()
}

Function PictureBox {
    $file = (Get-Item $global:outFile)
    $image = [System.Drawing.Image]::Fromfile($file)
    $pictureBox.Image = $image
}

Function DisplayImage {
    If ($global:outFile.Length -gt 0) {
        Invoke-Item $global:outFile
    }
}

[void] $mainForm.ShowDialog()

# Sample Returned XML data
#
# <?xml version="1.0" encoding="UTF-8"?>
# <base64Binary xmlns="http://www.webserviceX.NET">9jaH...AA==</base64Binary>