<#
SingleImageCollage.ps1

Wayne Lindimore
wlindimore@gmail.com
AdminsCache.Wordpress.com

1-4-14
PowerShell Draw Image File Randomly
    and Write Resultant Bitmap to File
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:numberObjects = 1000
$global:reductionPercent = 10
$global:backgroundText = "Black"
$global:imageWidth = 1024
$global:imageHeight = 768
$Global:outFile = ""

# WinForm Setup
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Location = "200, 200"
$mainForm.Font = "Comic Sans MS,9"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.ForeColor = "Black"
$mainForm.BackColor = "Cornsilk"
$mainForm.Text = " Single Image Collage Maker"
$mainForm.Width = 1030
$mainForm.Height = 500

# Input Box
$textBoxIn = New-Object System.Windows.Forms.TextBox
$textBoxIn.Location = "15, 30"
$textBoxIn.Size = "460, 20"
$mainForm.Controls.Add($textBoxIn)

# Input Box Label
$ProcessLabel = New-Object System.Windows.Forms.Label
$ProcessLabel.Location = "15, 12"
$ProcessLabel.Size = "300, 23"
$ProcessLabel.ForeColor = "MediumBlue" 
$ProcessLabel.Text = "Input Image File"
$mainForm.Controls.Add($ProcessLabel)

# Browse Input Button
$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Location = "560, 80"
$buttonBrowse.Size = "75, 23"
$buttonBrowse.ForeColor = "MediumBlue" 
$buttonBrowse.Text = "Browse"
$buttonBrowse.add_Click({selectFiles})
$mainForm.Controls.Add($buttonBrowse)

# Number of Objects TrackBar
$numberTrackBar = New-Object Windows.Forms.TrackBar
$numberTrackBar.Location = "160,80"
$numberTrackBar.Orientation = "Horizontal"
$numberTrackBar.Width = 325
$numberTrackBar.Height = 40
$numberTrackBar.LargeChange = 500
$numberTrackBar.SmallChange = 1
$numberTrackBar.TickFrequency = 500
$numberTrackBar.TickStyle = "TopLeft"
$numberTrackBar.SetRange(1, 5000)
$numberTrackBar.Value = 1000
$numberTrackBarValue = 1000
$numberTrackBar.add_ValueChanged({
    $numberTrackBarValue = $numberTrackBar.Value
    $numberTrackBarLabel.Text = "Number Images ($numberTrackBarValue)"
    $global:numberObjects = $numberTrackBarValue
})
$mainForm.Controls.add($numberTrackBar)

# Object Number Label
$numberTrackBarLabel = New-Object System.Windows.Forms.Label 
$numberTrackBarLabel.Location = "15,80"
$numberTrackBarLabel.Size = "160,23"
$numberTrackBarLabel.ForeColor = "MediumBlue"
$numberTrackBarLabel.Text = "Number Images ($numberTrackBarValue)"
$mainForm.Controls.Add($numberTrackBarLabel)

# Image Reduction TrackBar
$reductionTrackBar = New-Object Windows.Forms.TrackBar
$reductionTrackBar.Location = "190,140"
$reductionTrackBar.Orientation = "Horizontal"
$reductionTrackBar.Width = 295
$reductionTrackBar.Height = 40
$reductionTrackBar.LargeChange = 20
$reductionTrackBar.SmallChange = 1
$reductionTrackBar.TickFrequency = 5
$reductionTrackBar.TickStyle = "TopLeft"
$reductionTrackBar.SetRange(1, 100)
$reductionTrackBar.Value = 10
$reductionTrackBarValue = 10
$reductionTrackBar.add_ValueChanged({
    $reductionTrackBarValue = $reductionTrackBar.Value
    $reductionTrackBarLabel.Text = "Image Reduced Size ($reductionTrackBarValue%)"
    $global:reductionPercent = $reductionTrackBarValue
})
$mainForm.Controls.add($reductionTrackBar)

# Image Size Label
$reductionTrackBarLabel = New-Object System.Windows.Forms.Label 
$reductionTrackBarLabel.Location = "15,140"
$reductionTrackBarLabel.Size = "180,23"
$reductionTrackBarLabel.ForeColor = "MediumBlue"
$reductionTrackBarLabel.Text = "Images Reduction Size ($reductionTrackBarValue%)"
$mainForm.Controls.Add($reductionTrackBarLabel)

# Background ComboBox
$backgroundComboBox = New-Object System.Windows.Forms.ComboBox
$backgroundComboBox.Location = "630,30"
$backgroundComboBox.Size = "120,20"
$backgroundComboBox.ForeColor = "Indigo"
$backgroundComboBox.BackColor = "White"
[void]$backgroundComboBox.items.add("Black")
[void]$backgroundComboBox.items.add("White")
[void]$backgroundComboBox.items.add("Random")
[void]$backgroundComboBox.items.add("Transparent")         
$backgroundComboBox.SelectedIndex = 0
$mainForm.Controls.Add($backgroundComboBox)

# Background ComboBox Label
$backgroundComboBoxLabel = New-Object System.Windows.Forms.Label 
$backgroundComboBoxLabel.Location = "520,30"
$backgroundComboBoxLabel.Size = "120,20"
$backgroundComboBoxLabel.ForeColor = "MediumBlue"
$backgroundComboBoxLabel.Text = "Background Color"
$mainForm.Controls.Add($backgroundComboBoxLabel)

# Image Size ComboBox
$imageComboBox = New-Object System.Windows.Forms.ComboBox
$imageComboBox.Location = "870,30"
$imageComboBox.Size = "120,20"
$imageComboBox.ForeColor = "Indigo"
$imageComboBox.BackColor = "White"
[void]$imageComboBox.items.add("800 x600 ")
[void]$imageComboBox.items.add("1024x768 ")
[void]$imageComboBox.items.add("1280x1024")
[void]$imageComboBox.items.add("1600x1200") 
[void]$imageComboBox.items.add("1366x768") 
[void]$imageComboBox.items.add("1920x1200")        
$imageComboBox.SelectedIndex = 1
$mainForm.Controls.Add($imageComboBox)

# Image Size ComboBox Label
$imageComboBoxLabel = New-Object System.Windows.Forms.Label 
$imageComboBoxLabel.Location = "770,30"
$imageComboBoxLabel.Size = "100,40"
$imageComboBoxLabel.ForeColor = "MediumBlue"
$imageComboBoxLabel.Text = "Output Image"
$mainForm.Controls.Add($imageComboBoxLabel)

# Completion Label
$completeLabel = New-Object System.Windows.Forms.Label
$completeLabel.Location = "678, 60"
$completeLabel.Size = "60, 18"
$completeLabel.ForeColor = "Green"
$completeLabel.Text = ""
$mainForm.Controls.Add($completeLabel)

# Final PictureBox
$finalPicture = New-Object System.Windows.Forms.PictureBox
$finalPicture.Location = "520, 125"
$finalPicture.ClientSize = "480, 300"
$finalPicture.BackColor = "Black"
$finalPicture.SizeMode = "Zoom"
$mainForm.Controls.Add($finalPicture)

# Input PictureBox
$inputPicture = New-Object System.Windows.Forms.PictureBox
$inputPicture.Location = "90, 200"
$inputPicture.ClientSize = "320, 200"
$inputPicture.BackColor = "Black"
$inputPicture.SizeMode = "Zoom"
$mainForm.Controls.Add($inputPicture)

# Output Label
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Location = "90, 435"
$outputLabel.Size = "900, 20"
$outputLabel.ForeColor = "DarkBlue"
$outputLabel.Text = "Output Files Written to - " + $scriptPath
$mainForm.Controls.Add($outputLabel)

# Process Button
$buttonProcess = New-Object System.Windows.Forms.Button
$buttonProcess.Location = "665,80"
$buttonProcess.Size = "75, 23"
$buttonProcess.ForeColor = "Green" 
$buttonProcess.Text = "Process"
$buttonProcess.add_Click({ProcessButton})
$mainForm.Controls.Add($buttonProcess)

# Display Button
$buttonDisplay = New-Object System.Windows.Forms.Button
$buttonDisplay.Location = "770,80"
$buttonDisplay.Size = "75, 23"
$buttonDisplay.ForeColor = "Green" 
$buttonDisplay.Text = "Display"
$buttonDisplay.add_Click({DisplayImage})
$mainForm.Controls.Add($buttonDisplay)

# Exit Button
$buttonExit = New-Object System.Windows.Forms.Button
$buttonExit.Location = "870,80"
$buttonExit.Size = "75, 23"
$buttonExit.ForeColor = "Red" 
$buttonExit.Text = "Exit"
$buttonExit.add_Click({$mainForm.close()})
$mainForm.Controls.Add($buttonExit)

Function ProcessButton {
    $global:imageWidth  = [int]$imageComboBox.Text.Split("x")[0]
    $global:imageHeight = [int]$imageComboBox.Text.Split("x")[1]
    $error.clear()
    $i = 0; $completeLabel.Text = ""
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)

    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap($global:imageWidth,$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)

    # Image Background Color
    If ($backgroundComboBox.Text -eq "Transparent") {
        $bitmap.MakeTransparent()
    } Else {
        If ($backgroundComboBox.Text -eq "Random") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
            $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
            $bitmapGraphics.Clear($backColor)
        } Else {
            $bitmapGraphics.Clear($backgroundComboBox.Text)
        }
    }

    $imageFile = [System.Drawing.Image]::FromFile($textBoxIn.Text)
    While ($i -le $global:numberObjects) { $i++
        $pointX = (Get-Random -minimum -100 -maximum ([int]$global:imageWidth + 100))
        $pointY = (Get-Random -minimum -100 -maximum ([int]$global:imageHeight + 100))
        $height = $imageFile.Height * ([int]$global:reductionPercent * .01)
        $width = $imageFile.Width * ([int]$global:reductionPercent * .01)
        $bitmapGraphics.DrawImage($imageFile, $pointX, $pointY, $width, $height)
    }

    $Global:outFile = $scriptPath + "\"  + "Images_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($Global:outFile)
    FinalPicture($Global:outFile)

    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End ProcessButton

function selectFiles {
	$selectForm = New-Object System.Windows.Forms.OpenFileDialog
	$selectForm.Filter = "All Files (*.*)|*.*"
	$selectForm.InitialDirectory = ".\"
	$selectForm.Title = "Select a File to Process"
	$getKey = $selectForm.ShowDialog()
	If ($getKey -eq "OK") {
            $textBoxIn.Text = $selectForm.FileName
            $completeLabel.Text = "      "
            InputPicture($selectForm.FileName)
	}
} # End SelectFile

Function FinalPicture {
    $file = (Get-Item $Global:outFile)
    $image = [System.Drawing.Image]::Fromfile($file)
    $finalPicture.Image = $image
}

Function InputPicture {
    $file = (Get-Item $selectForm.FileName)
    $image = [System.Drawing.Image]::Fromfile($file)
    $inputPicture.Image = $image
}

Function DisplayImage {
    If ($Global:outFile.Length -gt 0) {
        Invoke-Item $Global:outFile
    }
}

[void] $mainForm.ShowDialog()