#############################################################
# QRCode.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 10-25-13
# PowerShell Genertae a QR Code Image File Using QRServer.com
#############################################################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Web
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " Generate QR Code Image File"
$mainForm.StartPosition = "centerscreen"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "Wheat"
$mainForm.Size = "460, 460"
$mainForm.MinimumSize = "460, 460"

# Encode Text Label
$encodeLabel = New-Object System.Windows.Forms.Label
$encodeLabel.Location = "15,10"
$encodeLabel.ForeColor = "MediumBlue"
$encodeLabel.Size = "105, 22"
$encodeLabel.Text = "Text to Encode"
$mainForm.Controls.Add($encodeLabel)

# Encode Text TextBox
$encodeTextBox = New-Object System.Windows.Forms.TextBox
$encodeTextBox.Location = "120,10"
$encodeTextBox.Size = "300,20"
$encodeTextBox.ForeColor = "MediumBlue"
$encodeTextBox.BackColor = "White"
$encodeTextBox.Text = ""
$mainForm.Controls.Add($encodeTextBox)

# Size Label
$sizeLabel = New-Object System.Windows.Forms.Label
$sizeLabel.Location = "40,40"
$sizeLabel.ForeColor = "MediumBlue"
$sizeLabel.Size = "80, 22"
$sizeLabel.Text = "Image Size"
$mainForm.Controls.Add($sizeLabel)

# Size Help Label
$sizeHelpLabel = New-Object System.Windows.Forms.Label
$sizeHelpLabel.Location = "230,40"
$sizeHelpLabel.ForeColor = "DarkOrange"
$sizeHelpLabel.Size = "200, 22"
$sizeHelpLabel.Text = "10x10 - 1000x1000  (Square)"
$mainForm.Controls.Add($sizeHelpLabel)

# Size TextBox
$sizeTextBox = New-Object System.Windows.Forms.TextBox
$sizeTextBox.Location = "120,40"
$sizeTextBox.Size = "100,20"
$sizeTextBox.ForeColor = "MediumBlue"
$sizeTextBox.BackColor = "White"
$sizeTextBox.Text = "250x250"
$mainForm.Controls.Add($sizeTextBox)

# Fore Color Label
$foreColorLabel = New-Object System.Windows.Forms.Label
$foreColorLabel.Location = "45,70"
$foreColorLabel.ForeColor = "MediumBlue"
$foreColorLabel.Size = "75, 22"
$foreColorLabel.Text = "Fore Color"
$mainForm.Controls.Add($foreColorLabel)

# Fore Color TextBox
$foreColorTextBox = New-Object System.Windows.Forms.TextBox
$foreColorTextBox.Location = "120,70"
$foreColorTextBox.Size = "55,20"
$foreColorTextBox.ForeColor = "MediumBlue"
$foreColorTextBox.BackColor = "White"
$foreColorTextBox.Text = "000000"
$mainForm.Controls.Add($foreColorTextBox)

# Back Color Label
$backColorLabel = New-Object System.Windows.Forms.Label
$backColorLabel.Location = "195,70"
$backColorLabel.ForeColor = "MediumBlue"
$backColorLabel.Size = "75, 22"
$backColorLabel.Text = "Back Color"
$mainForm.Controls.Add($backColorLabel)

# Back Color TextBox
$backColorTextBox = New-Object System.Windows.Forms.TextBox
$backColorTextBox.Location = "270,70"
$backColorTextBox.Size = "55,20"
$backColorTextBox.ForeColor = "MediumBlue"
$backColorTextBox.BackColor = "White"
$backColorTextBox.Text = "ffffff"
$mainForm.Controls.Add($backColorTextBox)

# Format Label
$fileFormatLabel = New-Object System.Windows.Forms.Label
$fileFormatLabel.Location = "40,100"
$fileFormatLabel.ForeColor = "MediumBlue"
$fileFormatLabel.Size = "80, 22"
$fileFormatLabel.Text = "File Format"
$mainForm.Controls.Add($fileFormatLabel)

# Format ComboBox
$fileFormatComboBox = New-Object System.Windows.Forms.ComboBox
$fileFormatComboBox.Location = "120,100"
$fileFormatComboBox.Size = "60,20"
$fileFormatComboBox.ForeColor = "MediumBlue"
$fileFormatComboBox.BackColor = "White"
$fileFormatComboBox.Items.Add("gif")
$fileFormatComboBox.Items.Add("jpg")
$fileFormatComboBox.Items.Add("png")
$fileFormatComboBox.Text = "jpg"
$mainForm.Controls.Add($fileFormatComboBox)

# Quiet Zone Label
$qZoneLabel = New-Object System.Windows.Forms.Label
$qZoneLabel.Location = "190,100"
$qZoneLabel.ForeColor = "MediumBlue"
$qZoneLabel.Size = "80, 22"
$qZoneLabel.Text = "Quiet Zone"
$mainForm.Controls.Add($qZoneLabel)

# Quiet Zonet TextBox
$qZoneTextBox = New-Object System.Windows.Forms.TextBox
$qZoneTextBox.Location = "270,100"
$qZoneTextBox.Size = "30,20"
$qZoneTextBox.ForeColor = "MediumBlue"
$qZoneTextBox.BackColor = "White"
$qZoneTextBox.Text = "1"
$mainForm.Controls.Add($qZoneTextBox)

# ECC Label
$eccLabel = New-Object System.Windows.Forms.Label
$eccLabel.Location = "310,100"
$eccLabel.ForeColor = "MediumBlue"
$eccLabel.Size = "30, 22"
$eccLabel.Text = "ECC"
$mainForm.Controls.Add($eccLabel)

# ECC Help Label
$eccHelpLabel = New-Object System.Windows.Forms.Label
$eccHelpLabel.Location = "365,100"
$eccHelpLabel.ForeColor = "DarkOrange"
$eccHelpLabel.Size = "60, 22"
$eccHelpLabel.Text = "L,M,Q,H"
$mainForm.Controls.Add($eccHelpLabel)

# ECC TextBox
$eccTextBox = New-Object System.Windows.Forms.TextBox
$eccTextBox.Location = "345,100"
$eccTextBox.Size = "18,20"
$eccTextBox.ForeColor = "MediumBlue"
$eccTextBox.BackColor = "White"
$eccTextBox.Text = "L"
$mainForm.Controls.Add($eccTextBox)

# Completed Label
$completedLabel = New-Object System.Windows.Forms.Label
$completedLabel.Location = "15,310"
$completedLabel.Size = "60, 22"
$completedLabel.ForeColor = "Green"
$completedLabel.Text = ""
$mainForm.Controls.Add($completedLabel)

# PictureBox
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Location = "120, 150"
$pictureBox.ClientSize = "250, 250"
$pictureBox.SizeMode = "Zoom"
$mainForm.Controls.Add($pictureBox)

# Generate Button
$generateButton = New-Object System.Windows.Forms.Button 
$generateButton.Location = "15,340"
$generateButton.Size = "75,28"
$generateButton.ForeColor = "DarkBlue"
$generateButton.BackColor = "White"
$generateButton.Text = "Generate"
$generateButton.add_Click({GenerateQRCode($scriptPath)})
$mainForm.Controls.Add($generateButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "15,380"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

Function GenerateQRcode { 
    $error.clear() 
	$path = $scriptPath + "\QRCode_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + "." + $fileFormatComboBox.Text
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile(("http://api.qrserver.com/v1/create-qr-code/?data=" + $encodeTextBox.Text + `
        "&ecc=" + $eccTextBox.Text +`
        "&size=" + $sizeTextBox.Text +`
        "&qzone=" + $qZoneTextBox.Text + `
        "&color=" + $foreColorTextBox.Text + `
        "&bgcolor=" + $backColorTextBox.Text + `
        "&format=" + $fileFormatComboBox.Text), $path)
    If($error.count -gt 0) {
        $completedLabel.Text = "Error!"
        $completedLabel.ForeColor = "Red"
    }
    Else {
        $completedLabel.Text = "Success!"
        $completedLabel.ForeColor = "Green"
    }
    PictureBox($path)
    $WebClient.Dispose()
}

Function PictureBox {
    $file = (Get-Item $path)
    $image = [System.Drawing.Image]::Fromfile($file)
    $pictureBox.Image = $image
}

[void] $mainForm.ShowDialog()