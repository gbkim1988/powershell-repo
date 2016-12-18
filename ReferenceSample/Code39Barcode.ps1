###################################################################
# Code39Barcode.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 9-21-13
# PowerShell Generate a Code 39 Barcode Image File Using Web Service
####################################################################
Add-Type -AssemblyName System.Windows.Forms
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " Generate Code 39 Barcode Image File"
$mainForm.StartPosition = "centerscreen"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "Wheat"
$mainForm.Size = "830, 380"
$mainForm.MinimumSize = "830, 380"

# Encode Text Label
$encodeTextLabel = New-Object System.Windows.Forms.Label
$encodeTextLabel.Location = "50,10"
$encodeTextLabel.ForeColor = "MediumBlue"
$encodeTextLabel.Size = "110, 22"
$encodeTextLabel.Text = "Text to Encode"
$mainForm.Controls.Add($encodeTextLabel)

# Encode Text Help Label
$encodeTextHelpLabel = New-Object System.Windows.Forms.Label
$encodeTextHelpLabel.Location = "330,10"
$encodeTextHelpLabel.ForeColor = "DarkOrange"
$encodeTextHelpLabel.Size = "350, 22"
$encodeTextHelpLabel.Text = "Uppercase A-Z, 0-9 and - . $ / + % space"
$mainForm.Controls.Add($encodeTextHelpLabel)

# Encode Text TextBox
$encodeTextTextBox = New-Object System.Windows.Forms.TextBox
$encodeTextTextBox.Location = "160,10"
$encodeTextTextBox.Size = "150,20"
$encodeTextTextBox.ForeColor = "MediumBlue"
$encodeTextTextBox.BackColor = "White"
$encodeTextTextBox.Text = ""
$mainForm.Controls.Add($encodeTextTextBox)

# Bar Size Label
$barSizeLabel = New-Object System.Windows.Forms.Label
$barSizeLabel.Location = "90,40"
$barSizeLabel.ForeColor = "MediumBlue"
$barSizeLabel.Size = "70, 22"
$barSizeLabel.Text = "Bar Size"
$mainForm.Controls.Add($barSizeLabel)

# Bar Size Help Label
$barSizeHelpLabel = New-Object System.Windows.Forms.Label
$barSizeHelpLabel.Location = "330,40"
$barSizeHelpLabel.ForeColor = "DarkOrange"
$barSizeHelpLabel.Size = "300, 22"
$barSizeHelpLabel.Text = "Relative size of Barcode image"
$mainForm.Controls.Add($barSizeHelpLabel)

# Bar Size TextBox
$barSizeTextBox = New-Object System.Windows.Forms.TextBox
$barSizeTextBox.Location = "160,40"
$barSizeTextBox.Size = "150,20"
$barSizeTextBox.ForeColor = "MediumBlue"
$barSizeTextBox.BackColor = "White"
$barSizeTextBox.Text = "50"
$mainForm.Controls.Add($barSizeTextBox)

# Show Encode Label
$showEncodeLabel = New-Object System.Windows.Forms.Label
$showEncodeLabel.Location = "45,70"
$showEncodeLabel.ForeColor = "MediumBlue"
$showEncodeLabel.Size = "110,22"
$showEncodeLabel.Text = "Show Text (0/1)"
$mainForm.Controls.Add($showEncodeLabel)

# Show Encode Help Label
$showEncodeHelpLabel = New-Object System.Windows.Forms.Label
$showEncodeHelpLabel.Location = "330, 70"
$showEncodeHelpLabel.ForeColor = "DarkOrange"
$showEncodeHelpLabel.Size = "330,22"
$showEncodeHelpLabel.Text = "0 for No Text / 1 for Encoded Text below Barcode"
$mainForm.Controls.Add($showEncodeHelpLabel)

# Show Encode TextBox
$showEncodeTextBox = New-Object System.Windows.Forms.TextBox
$showEncodeTextBox.Location = "160,70"
$showEncodeTextBox.Size = "150,20"
$showEncodeTextBox.ForeColor = "MediumBlue"
$showEncodeTextBox.BackColor = "White"
$showEncodeTextBox.Text = "0"
$mainForm.Controls.Add($showEncodeTextBox)

# Bar Title Label
$barTitleLabel = New-Object System.Windows.Forms.Label
$barTitleLabel.Location = "60,100"
$barTitleLabel.ForeColor = "MediumBlue"
$barTitleLabel.Size = "100,22"
$barTitleLabel.Text = "Barcode Title "
$mainForm.Controls.Add($barTitleLabel)

# Bar Title Help Label
$barTitleHelpLabel = New-Object System.Windows.Forms.Label
$barTitleHelpLabel.Location = "330,100"
$barTitleHelpLabel.ForeColor = "DarkOrange"
$barTitleHelpLabel.Size = "300,22"
$barTitleHelpLabel.Text = "Title shows above Barcode "
$mainForm.Controls.Add($barTitleHelpLabel)

# Bat Title TextBox
$barTitleTextBox = New-Object System.Windows.Forms.TextBox
$barTitleTextBox.Location = "160,100"
$barTitleTextBox.Size = "150,20"
$barTitleTextBox.ForeColor = "MediumBlue"
$barTitleTextBox.BackColor = "White"
$barTitleTextBox.Text = ""
$mainForm.Controls.Add($barTitleTextBox)

# Completed Label
$completedLabel = New-Object System.Windows.Forms.Label
$completedLabel.Location = "710,80"
$completedLabel.Size = "60, 22"
$completedLabel.ForeColor = "Green"
$completedLabel.Text = ""
$mainForm.Controls.Add($completedLabel)

# PictureBox
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Location = "160, 150"
$pictureBox.ClientSize = "600, 130"
$pictureBox.SizeMode = "Zoom"
$mainForm.Controls.Add($pictureBox)

# Generate Button
$generateButton = New-Object System.Windows.Forms.Button 
$generateButton.Location = "700,10"
$generateButton.Size = "75,28"
$generateButton.ForeColor = "DarkBlue"
$generateButton.BackColor = "White"
$generateButton.Text = "Generate"
$generateButton.add_Click({GenerateBarcode($scriptPath)})
$mainForm.Controls.Add($generateButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "700,40"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

Function GenerateBarcode {
    $error.clear()
    $getBarCode = New-WebServiceProxy -uri "http://www.webservicex.net/barcode.asmx?WSDL"
    If ($showEncodeTextBox.Text -eq "0") {
        $returnedImage = $getBarCode.Code39( `
            $encodeTextTextBox.Text.ToUpper(), `
            $barSizeTextBox.Text, `
            $false, `
            $barTitleTextBox.Text)
    } Else {
         $returnedImage = $getBarCode.Code39( `
            $encodeTextTextBox.Text.ToUpper(), `
            $barSizeTextBox.Text, `
            $true, `
            $barTitleTextBox.Text)
    }
    $outFile = $scriptPath + "\"  + "Barcode_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".jpg"
    Set-Content -Path $outFile -Value $returnedImage -Encoding Byte
    If($error.count -gt 0) {
        $completedLabel.Text = "Error!"
        $completedLabel.ForeColor = "Red"
    }
    Else {
        $completedLabel.Text = "Success!"
        $completedLabel.ForeColor = "Green"
    }
    PictureBox($outFile)
    $getBarCode.Dispose()
}

Function PictureBox {
    $file = (Get-Item $outFile)
    $image = [System.Drawing.Image]::Fromfile($file)
    $pictureBox.Image = $image
}

[void] $mainForm.ShowDialog()