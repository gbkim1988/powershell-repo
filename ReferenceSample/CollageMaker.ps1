<#
CollageMaker.ps1

Wayne Lindimore
wlindimore@gmail.com
AdminsCache.Wordpress.com

2-2-14
PowerShell Make Image Collage Randomly From Folder of Images
    and Write Resultant Bitmap to File
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:reductionPercent = 10
$global:backgroundText = "Black"
$global:imageWidth = 1024
$global:imageHeight = 768
$global:imageBorder = 2
$global:imageBorderColor = "Black"
$Global:outFile = ""

# WinForm Setup
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Location = "200, 200"
$mainForm.Font = "Comic Sans MS,9"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.ForeColor = "Black"
$mainForm.BackColor = "Cornsilk"
$mainForm.Text = " Image Collage Maker"
$mainForm.Width = 1030
$mainForm.Height = 380

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
$ProcessLabel.Text = "Input Images Folder"
$mainForm.Controls.Add($ProcessLabel)

# Browse Input Button
$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Location = "30, 290"
$buttonBrowse.Size = "75, 23"
$buttonBrowse.ForeColor = "MediumBlue" 
$buttonBrowse.Text = "Browse"
$buttonBrowse.add_Click({selectFolder})
$mainForm.Controls.Add($buttonBrowse)

# Image Reduction TrackBar
$reductionTrackBar = New-Object System.Windows.Forms.TrackBar
$reductionTrackBar.Location = "200,140"
$reductionTrackBar.Orientation = "Horizontal"
$reductionTrackBar.Width = 280
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

# Image Reduction Label
$reductionTrackBarLabel = New-Object System.Windows.Forms.Label 
$reductionTrackBarLabel.Location = "15,140"
$reductionTrackBarLabel.Size = "180,23"
$reductionTrackBarLabel.ForeColor = "MediumBlue"
$reductionTrackBarLabel.Text = "Images Reduction Size ($reductionTrackBarValue%)"
$mainForm.Controls.Add($reductionTrackBarLabel)

# Number of Objects TrackBar
$numberTrackBar = New-Object System.Windows.Forms.TrackBar
$numberTrackBar.Location = "160, 80"
$numberTrackBar.Orientation = "Horizontal"
$numberTrackBar.Width = 325
$numberTrackBar.Height = 40
$numberTrackBar.LargeChange = 100
$numberTrackBar.SmallChange = 10
$numberTrackBar.TickFrequency = 100
$numberTrackBar.TickStyle = "TopLeft"
$numberTrackBar.SetRange(1, 2000)
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

# Background ComboBox
$backgroundComboBox = New-Object System.Windows.Forms.ComboBox
$backgroundComboBox.Location = "120,200"
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
$backgroundComboBoxLabel.Location = "15,200"
$backgroundComboBoxLabel.Size = "120,20"
$backgroundComboBoxLabel.ForeColor = "MediumBlue"
$backgroundComboBoxLabel.Text = "Background Color"
$mainForm.Controls.Add($backgroundComboBoxLabel)

# Image Size ComboBox
$imageComboBox = New-Object System.Windows.Forms.ComboBox
$imageComboBox.Location = "350,200"
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
$imageComboBoxLabel.Location = "255,200"
$imageComboBoxLabel.Size = "100,40"
$imageComboBoxLabel.ForeColor = "MediumBlue"
$imageComboBoxLabel.Text = "Output Image"
$mainForm.Controls.Add($imageComboBoxLabel)

# Image Border ComboBox
$borderComboBox = New-Object System.Windows.Forms.ComboBox
$borderComboBox.Location = "350,245"
$borderComboBox.Size = "120,20"
$borderComboBox.ForeColor = "Indigo"
$borderComboBox.BackColor = "White"
For ($i=0; $i -le 10; $i++) {
    [void]$borderComboBox.items.add($i)
}
$borderComboBox.SelectedIndex = 2
$mainForm.Controls.Add($borderComboBox)

# Image Border ComboBox Label
$borderComboBoxLabel = New-Object System.Windows.Forms.Label 
$borderComboBoxLabel.Location = "255,245"
$borderComboBoxLabel.Size = "100,40"
$borderComboBoxLabel.ForeColor = "MediumBlue"
$borderComboBoxLabel.Text = "Border Width"
$mainForm.Controls.Add($borderComboBoxLabel)

# Image Border Color ComboBox
$borderColorComboBox = New-Object System.Windows.Forms.ComboBox
$borderColorComboBox.Location = "120,245"
$borderColorComboBox.Size = "120,20"
$borderColorComboBox.ForeColor = "Indigo"
$borderColorComboBox.BackColor = "White"
[void]$borderColorComboBox.items.add("Black")
[void]$borderColorComboBox.items.add("White")
[void]$borderColorComboBox.items.add("Random")       
$borderColorComboBox.SelectedIndex = 0
$mainForm.Controls.Add($borderColorComboBox)

# Image Border Color ComboBox Label
$borderColorComboBoxLabel = New-Object System.Windows.Forms.Label 
$borderColorComboBoxLabel.Location = "15,245"
$borderColorComboBoxLabel.Size = "100,40"
$borderColorComboBoxLabel.ForeColor = "MediumBlue"
$borderColorComboBoxLabel.Text = "Border Color"
$mainForm.Controls.Add($borderColorComboBoxLabel)

# Completion Label
$completeLabel = New-Object System.Windows.Forms.Label
$completeLabel.Location = "160, 270"
$completeLabel.Size = "60, 18"
$completeLabel.ForeColor = "Green"
$completeLabel.Text = ""
$mainForm.Controls.Add($completeLabel)

# Final PictureBox
$finalPicture = New-Object System.Windows.Forms.PictureBox
$finalPicture.Location = "520, 20"
$finalPicture.ClientSize = "480, 300"
$finalPicture.BackColor = "Black"
$finalPicture.SizeMode = "Zoom"
$mainForm.Controls.Add($finalPicture)

# Output Label
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Location = "30, 320"
$outputLabel.Size = "900, 20"
$outputLabel.ForeColor = "DarkBlue"
$outputLabel.Text = "Output Files Written to - " + $scriptPath
$mainForm.Controls.Add($outputLabel)

# Process Button
$buttonProcess = New-Object System.Windows.Forms.Button
$buttonProcess.Location = "145,290"
$buttonProcess.Size = "75, 23"
$buttonProcess.ForeColor = "Green" 
$buttonProcess.Text = "Process"
$buttonProcess.add_Click({ProcessImage})
$mainForm.Controls.Add($buttonProcess)

# Display Button
$buttonDisplay = New-Object System.Windows.Forms.Button
$buttonDisplay.Location = "260,290"
$buttonDisplay.Size = "75, 23"
$buttonDisplay.ForeColor = "Green" 
$buttonDisplay.Text = "Launch"
$buttonDisplay.add_Click({DisplayImage})
$mainForm.Controls.Add($buttonDisplay)

# Exit Button
$buttonExit = New-Object System.Windows.Forms.Button
$buttonExit.Location = "375,290"
$buttonExit.Size = "75, 23"
$buttonExit.ForeColor = "Red" 
$buttonExit.Text = "Exit"
$buttonExit.add_Click({$mainForm.close()})
$mainForm.Controls.Add($buttonExit)

Function ProcessImage {
    $global:imageWidth  = [int]$imageComboBox.Text.Split("x")[0]
    $global:imageHeight = [int]$imageComboBox.Text.Split("x")[1]
    $global:imageBorder = [int]$borderComboBox.Text
    $completeLabel.Text = ""
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)

    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap($global:imageWidth,$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $brushBorder = New-Object System.Drawing.SolidBrush("Black")

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

    # Image Border Color
    If ($borderColorComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $borderColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $brushBorder = New-Object System.Drawing.SolidBrush($borderColor)
    } Else {
        $brushBorder = New-Object System.Drawing.SolidBrush($borderColorComboBox.Text)
    }

    $i = 0; $folderName = $textBoxIn.Text
    $files = @()
    $files = Get-ChildItem $folderName
    While ($files.Length-2 -le $numberTrackbar.Value) {
        $files += Get-ChildItem $folderName  
    }
    While ($i -le $numberTrackBar.Value) { $i++
        $fileName = $folderName + "\" + $files[$i]
        Try {
            $imageFile = [System.Drawing.Image]::FromFile($fileName)
        }
        Catch {
        }
        $pointX = (Get-Random -minimum -100 -maximum ([int]$global:imageWidth + 100))
        $pointY = (Get-Random -minimum -100 -maximum ([int]$global:imageHeight + 100))
        $height = $imageFile.Height * ([int]$global:reductionPercent * .01)
        $width = $imageFile.Width * ([int]$global:reductionPercent * .01)
        If ($global:imageBorder -gt 0) {
	        $bitmapGraphics.FillRectangle($brushBorder, `
                $pointX-$global:imageBorder, `
                $pointY-$global:imageBorder, `
                $width +($global:imageBorder*2), `
                $height+($global:imageBorder*2))
        }
        $bitmapGraphics.DrawImage($imageFile, $pointX, $pointY, $width, $height)
    }

    $error.clear()
    $Global:outFile = $scriptPath + "\"  + "Collage_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($Global:outFile)
    FinalPicture($Global:outFile)

    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    }
} # End ProcessImage

function selectFolder {
	$selectForm = New-Object System.Windows.Forms.FolderBrowserDialog
	$getKey = $selectForm.ShowDialog()
	If ($getKey -eq "OK") {
        	$textBoxIn.Text = $selectForm.SelectedPath
        	$completeLabel.Text = "      "
	}
} # End SelectFolder

Function FinalPicture {
    $file = (Get-Item $Global:outFile)
    $image = [System.Drawing.Image]::Fromfile($file)
    $finalPicture.Image = $image
}

Function DisplayImage {
    If ($Global:outFile.Length -gt 0) {
        Invoke-Item $Global:outFile
    }
}

[void] $mainForm.ShowDialog()