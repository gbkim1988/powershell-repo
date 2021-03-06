<#
ImageConverter.ps1

Wayne Lindimore
wlindimore@gmail.com
AdminsCache.Wordpress.com

6-16-14
PowerShell Convert Image to GrayScale, Sepia or Negative
    and Write Resultant Bitmap to File
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:selectedObject = "GrayScale"
$global:outFile = ""

# WinForm Setup
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Location = "200, 200"
$mainForm.Font = "Comic Sans MS,9"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.ForeColor = "Black"
$mainForm.BackColor = "Bisque"
$mainForm.Text = " PowerShell Image Converter"
$mainForm.Width = 1030
$mainForm.Height = 520

# GrayScale RadioButton
$radioButtonGrayScale = New-Object System.Windows.Forms.RadioButton
$radioButtonGrayScale.Location = "40,15"
$radioButtonGrayScale.ForeColor = "Indigo"
$radioButtonGrayScale.Text = "Grayscale"
$radioButtonGrayScale.Checked = $true
$radioButtonGrayScale.add_Click({
    $global:selectedObject = "GrayScale"
})
$mainForm.Controls.Add($radioButtonGrayScale)

# Negative RadioButton
$radioButtonNegative = New-Object System.Windows.Forms.RadioButton
$radioButtonNegative.Location = "200,15"
$radioButtonNegative.ForeColor = "Indigo"
$radioButtonNegative.Text = "Negative"
$radioButtonNegative.add_Click({
    $global:selectedObject = "Negative"
})
$mainForm.Controls.Add($radioButtonNegative)

# Sepia RadioButton
$radioButtonSepia = New-Object System.Windows.Forms.RadioButton
$radioButtonSepia.Location = "360,15"
$radioButtonSepia.ForeColor = "Indigo"
$radioButtonSepia.Text = "Sepia"
$radioButtonSepia.add_Click({
    $global:selectedObject = "Sepia"
})
$mainForm.Controls.Add($radioButtonSepia)

# Input Box
$textBoxIn = New-Object System.Windows.Forms.TextBox
$textBoxIn.Location = "15, 50"
$textBoxIn.Size = "460, 20"
$textBoxIn.Text = "Input Image File"
$mainForm.Controls.Add($textBoxIn)

# Browse Input Button
$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Location = "480, 50"
$buttonBrowse.Size = "75, 23"
$buttonBrowse.ForeColor = "MediumBlue" 
$buttonBrowse.Text = "Browse"
$buttonBrowse.add_Click({selectFiles})
$mainForm.Controls.Add($buttonBrowse)

# Completion Label
$completeLabel = New-Object System.Windows.Forms.Label
$completeLabel.Location = "750, 30"
$completeLabel.Size = "60, 18"
$completeLabel.ForeColor = "Green"
$completeLabel.Text = ""
$mainForm.Controls.Add($completeLabel)

# Input PictureBox
$inputPicture = New-Object System.Windows.Forms.PictureBox
$inputPicture.Location = "15, 90"
$inputPicture.ClientSize = "480, 300"
$inputPicture.BackColor = "Black"
$inputPicture.SizeMode = "Zoom"
$mainForm.Controls.Add($inputPicture)

# Final PictureBox
$finalPicture = New-Object System.Windows.Forms.PictureBox
$finalPicture.Location = "520, 90"
$finalPicture.ClientSize = "480, 300"
$finalPicture.BackColor = "Black"
$finalPicture.SizeMode = "Zoom"
$mainForm.Controls.Add($finalPicture)

# Output Label
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Location = "15, 400"
$outputLabel.Size = "900, 20"
$outputLabel.ForeColor = "DarkBlue"
$outputLabel.Text = "Output Files Written to - " + $scriptPath
$mainForm.Controls.Add($outputLabel)

# Process Button
$buttonProcess = New-Object System.Windows.Forms.Button
$buttonProcess.Location = "740,50"
$buttonProcess.Size = "75, 23"
$buttonProcess.ForeColor = "Green" 
$buttonProcess.Text = "Process"
$buttonProcess.add_Click({ProcessButton})
$mainForm.Controls.Add($buttonProcess)

# Display Button
$buttonDisplay = New-Object System.Windows.Forms.Button
$buttonDisplay.Location = "830,50"
$buttonDisplay.Size = "75, 23"
$buttonDisplay.ForeColor = "Green" 
$buttonDisplay.Text = "Display"
$buttonDisplay.add_Click({DisplayImage})
$mainForm.Controls.Add($buttonDisplay)

# Exit Button
$buttonExit = New-Object System.Windows.Forms.Button
$buttonExit.Location = "920,50"
$buttonExit.Size = "75, 23"
$buttonExit.ForeColor = "Red" 
$buttonExit.Text = "Exit"
$buttonExit.add_Click({$mainForm.close()})
$mainForm.Controls.Add($buttonExit)

# Progress Bar
$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Location = "8, 430"
$ProgressBar.Maximum = 1000
$ProgressBar.Minimum = 0
$ProgressBar.Size = "1000, 20"
$progressBar.Step = 10
$progressBar.Style = "Continuous"
$mainForm.Controls.Add($ProgressBar)

# Progress Bar Status Strip & Label
$statusStrip = New-Object System.Windows.Forms.StatusStrip
$statusStrip.BackColor = "Bisque"

$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
[void]$statusStrip.Items.Add($statusLabel)
$statusLabel.AutoSize = $true
$statusLabel.BackColor = "Bisque"
$statusLabel.Text = "Ready"
$mainForm.Controls.Add($statusStrip)

Function ProcessButton {
    $completeLabel.Text = "        "
    $progressBar.Value = 0
    $finalPicture.Image = $null
    $statusLabel.Text = "Ready"
    Start-Sleep -Milliseconds 200
    Invoke-Expression $global:selectedObject
}

Function GrayScale {
    $error.clear()
    # Input Image
    $filename = $textBoxIn.Text
    $image = New-Object System.Drawing.Bitmap $filename
    $total = $image.Width * $image.Height

    # Output Image
    $bitmap = New-Object System.Drawing.Bitmap($image.Width,$image.Height)

    $percentStep = 0
    foreach($x in 0..($image.Width-1)) {
        foreach($y in 0..($image.Height-1)) {
            $percentDone = ((($x * $image.Height + $y) / $total ) * 100)
            If ([int]$percentDone -gt $percentStep) {
                $progressBar.PerformStep()
                $statusLabel.Text = "{0:N0}" -f $percentDone + "% Complete"
                $percentStep = $percentStep + 1
            }
            $pixelColor = $image.GetPixel($x, $y)
	        $red   = $pixelColor.R
	        $green = $pixelColor.G
	        $blue  = $pixelColor.B
	        # $gray  = ($red + $green + $blue) / 3  # Average Method
	        $gray = ($red*.2126)+($green*.7152)+($blue*.0722)  # Luminosity Method
	        $bitmap.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($gray, $gray, $gray))
        }
    }

    $global:outFile = $scriptPath + "\"  + "GrayScale_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($Global:outFile)

    $bitmap.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End GrayScale Function


Function Negative {
    $error.clear()
    # Input Image
    $filename = $textBoxIn.Text
    $image = New-Object System.Drawing.Bitmap $filename
    $total = $image.Width * $image.Height

    # Output Image
    $bitmap = New-Object System.Drawing.Bitmap($image.Width,$image.Height)

    $percentStep = 0
    foreach($x in 0..($image.Width-1)) {
        foreach($y in 0..($image.Height-1)) {
            $percentDone = ((($x * $image.Height + $y) / $total ) * 100)
            If ([int]$percentDone -gt $percentStep) {
                $progressBar.PerformStep()
                $statusLabel.Text = "{0:N0}" -f $percentDone + "% Complete"
                $percentStep = $percentStep + 1
            }
            $pixelColor = $image.GetPixel($x, $y)
	        $red   = $pixelColor.R
	        $green = $pixelColor.G
	        $blue  = $pixelColor.B
	        $newRed   = (255 - $red)
	        $newGreen = (255 - $green)
	        $newBlue  = (255 - $blue)
	        $bitmap.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($newRed, $newGreen, $newBlue))
        }
    }    

    $global:outFile = $scriptPath + "\"  + "Negative_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($Global:outFile)

    $bitmap.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End Negative Function

Function Sepia {
    $error.clear()
    # Input Image
    $filename = $textBoxIn.Text
    $image = New-Object System.Drawing.Bitmap $filename
    $total = $image.Width * $image.Height

    # Output Image
    $bitmap = New-Object System.Drawing.Bitmap($image.Width,$image.Height)

    $percentStep = 0
    foreach($x in 0..($image.Width-1)) {
        foreach($y in 0..($image.Height-1)) {
            $percentDone = ((($x * $image.Height + $y) / $total ) * 100)
            If ([int]$percentDone -gt $percentStep) {
                $progressBar.PerformStep()
                $statusLabel.Text = "{0:N0}" -f $percentDone + "% Complete"
                $percentStep = $percentStep + 1
            }
            $pixelColor = $image.GetPixel($x, $y)
            $red   = $pixelColor.R
	        $green = $pixelColor.G
	        $blue  = $pixelColor.B
            $outRed   = ($red * 0.393) + ($green * 0.769) + ($blue * 0.189)
            $outGreen = ($red * 0.349) + ($green * 0.686) + ($blue * 0.168)
            $outBlue  = ($red * 0.272) + ($green * 0.534) + ($blue * 0.131)
            If ($outRed   -gt 255) {$outred   = 255}
            If ($outGreen -gt 255) {$outGreen = 255}
            If ($outBlue  -gt 255) {$outBlue  = 255}
	        $bitmap.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($outRed, $outGreen, $outBlue))
        }
    }    

    $global:outFile = $scriptPath + "\"  + "Sepia_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($Global:outFile)

    $bitmap.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End Sepia Function

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
    $file = (Get-Item $global:outFile)
    $image = [System.Drawing.Image]::Fromfile($file)
    $finalPicture.Image = $image
}

Function InputPicture {
    $file = (Get-Item $selectForm.FileName)
    $image = [System.Drawing.Image]::Fromfile($file)
    $inputPicture.Image = $image
}

Function DisplayImage {
    If ($global:outFile.Length -gt 0) {
        Invoke-Item $global:outFile
    }
}

[void] $mainForm.ShowDialog()
