<#
MosaicFramedImages.ps1

Wayne Lindimore
wlindimore@gmail.com
AdminsCache.Wordpress.com

7-2-14
PowerShell Draw Image Framed by Mosaic Patterns and Write Resultant Bitmap to File
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:numberObjects = 1000
$global:reductionSize = 80
$global:backgroundText = "Black"
$global:outFile = ""

# WinForm Setup
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Location = "200, 200"
$mainForm.Font = "Comic Sans MS,8.5"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.ForeColor = "Black"
$mainForm.BackColor = "Cornsilk"
$mainForm.Text = " Mosaic Pattern Framed Images"
$mainForm.Width = 1030
$mainForm.Height = 500

#Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = "380, 5"
$titleLabel.Font = "Comic Sans MS,11"
$titleLabel.Size = "300, 23"
$titleLabel.ForeColor = "DarkRed" 
$titleLabel.Text = "Mosaic Pattern Framed Images"
$mainForm.Controls.Add($titleLabel)

# Fill Style Label
$styleLabel = New-Object System.Windows.Forms.Label
$styleLabel.Location = "15, 10"
$styleLabel.Size = "300, 23"
$styleLabel.ForeColor = "MediumBlue" 
$styleLabel.Text = "Brush Fill Style"
$mainForm.Controls.Add($styleLabel)

# Curves Object
$radioButtonCurves = New-Object System.Windows.Forms.RadioButton
$radioButtonCurves.Location = "15,35"
$radioButtonCurves.ForeColor = "Indigo"
$radioButtonCurves.Size = "80,23"
$radioButtonCurves.Text = "Curves"
$radioButtonCurves.add_Click({
    $global:selectedObject = "Curves"
})
$mainForm.Controls.Add($radioButtonCurves)

# Ellipses Object
$radioButtonEllipses = New-Object System.Windows.Forms.RadioButton
$radioButtonEllipses.Location = "105,35"
$radioButtonEllipses.ForeColor = "Indigo"
$radioButtonEllipses.Size = "80,23"
$radioButtonEllipses.Text = "Ellipses"
$radioButtonEllipses.add_Click({
    $global:selectedObject = "Ellipses"
})
$mainForm.Controls.Add($radioButtonEllipses)

# Polygons Object
$radioButtonPolygons = New-Object System.Windows.Forms.RadioButton
$radioButtonPolygons.Location = "200,35"
$radioButtonPolygons.ForeColor = "Indigo"
$radioButtonPolygons.Size = "80,23"
$radioButtonPolygons.Text = "Polygons"
$radioButtonPolygons.add_Click({
    $global:selectedObject = "Polygons"
})
$mainForm.Controls.Add($radioButtonPolygons)

# Rectangles Object
$radioButtonRectangles = New-Object System.Windows.Forms.RadioButton
$radioButtonRectangles.Location = "295,35"
$radioButtonRectangles.ForeColor = "Indigo"
$radioButtonRectangles.Size = "80,23"
$radioButtonRectangles.Text = "Rectangles"
$radioButtonRectangles.add_Click({
    $global:selectedObject = "Rectangles"
})
$mainForm.Controls.Add($radioButtonRectangles)

# Squares Object
$radioButtonSquares = New-Object System.Windows.Forms.RadioButton
$radioButtonSquares.Location = "400,35"
$radioButtonSquares.ForeColor = "Indigo"
$radioButtonSquares.Size = "80,23"
$radioButtonSquares.Text = "Squares"
$radioButtonSquares.Checked = $true
$radioButtonSquares.add_Click({
    $global:selectedObject = "Squares"
})
$mainForm.Controls.Add($radioButtonSquares)

# Input Box
$textBoxIn = New-Object System.Windows.Forms.TextBox
$textBoxIn.Location = "15, 90"
$textBoxIn.Size = "460, 20"
$mainForm.Controls.Add($textBoxIn)

# Input Box Label
$inputLabel = New-Object System.Windows.Forms.Label
$inputLabel.Location = "15, 67"
$inputLabel.Size = "300, 23"
$inputLabel.ForeColor = "MediumBlue" 
$inputLabel.Text = "Input Image File"
$mainForm.Controls.Add($inputLabel)

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
$numberTrackBar.Location = "160,120"
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
$numberTrackBarLabel.Location = "15,120"
$numberTrackBarLabel.Size = "160,23"
$numberTrackBarLabel.ForeColor = "MediumBlue"
$numberTrackBarLabel.Text = "Number Images ($numberTrackBarValue)"
$mainForm.Controls.Add($numberTrackBarLabel)

# Size of Center Image TrackBar
$centerImageTrackBar = New-Object Windows.Forms.TrackBar
$centerImageTrackBar.Location = "160,160"
$centerImageTrackBar.Orientation = "Horizontal"
$centerImageTrackBar.Width = 325
$centerImageTrackBar.Height = 40
$centerImageTrackBar.LargeChange = 10
$centerImageTrackBar.SmallChange = 1
$centerImageTrackBar.TickFrequency = 10
$centerImageTrackBar.TickStyle = "TopLeft"
$centerImageTrackBar.SetRange(1, 100)
$centerImageTrackBar.Value = 80
$centerImageTrackBarValue = 80
$centerImageTrackBar.add_ValueChanged({
    $centerImageTrackBarValue = $centerImageTrackBar.Value
    $centerImageTrackBarLabel.Text = "Center Frame Size % ($centerImageTrackBarValue)"
    $global:reductionSize = $centerImageTrackBarValue
})
$mainForm.Controls.add($centerImageTrackBar)

# Size of Center Image TrackBar Label
$centerImageTrackBarLabel = New-Object System.Windows.Forms.Label 
$centerImageTrackBarLabel.Location = "15,160"
$centerImageTrackBarLabel.Size = "160,23"
$centerImageTrackBarLabel.ForeColor = "MediumBlue"
$centerImageTrackBarLabel.Text = "Center Frame Size % ($centerImageTrackBarValue)"
$mainForm.Controls.Add($centerImageTrackBarLabel)

# Background ComboBox
$backgroundComboBox = New-Object System.Windows.Forms.ComboBox
$backgroundComboBox.Location = "670,30"
$backgroundComboBox.Size = "90,20"
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
$backgroundComboBoxLabel.Location = "560,30"
$backgroundComboBoxLabel.Size = "120,20"
$backgroundComboBoxLabel.ForeColor = "MediumBlue"
$backgroundComboBoxLabel.Text = "Background Color"
$mainForm.Controls.Add($backgroundComboBoxLabel)

# Border Width ComboBox
$borderComboBox = New-Object System.Windows.Forms.ComboBox
$borderComboBox.Location = "910,30"
$borderComboBox.Size = "30,20"
$borderComboBox.ForeColor = "Indigo"
$borderComboBox.BackColor = "White"
[void]$borderComboBox.items.add("0")
[void]$borderComboBox.items.add("1")
[void]$borderComboBox.items.add("2")
[void]$borderComboBox.items.add("3")
[void]$borderComboBox.items.add("4")
[void]$borderComboBox.items.add("5")           
$borderComboBox.SelectedIndex = 2
$mainForm.Controls.Add($borderComboBox)

# Border Width ComboBox Label
$borderComboBoxLabel = New-Object System.Windows.Forms.Label 
$borderComboBoxLabel.Location = "830,30"
$borderComboBoxLabel.Size = "90,23"
$borderComboBoxLabel.ForeColor = "MediumBlue"
$borderComboBoxLabel.Text = "Border Width"
$mainForm.Controls.Add($borderComboBoxLabel)

# Completion Label
$completeLabel = New-Object System.Windows.Forms.Label
$completeLabel.Location = "678, 60"
$completeLabel.Size = "60, 18"
$completeLabel.ForeColor = "Green"
$completeLabel.Text = "        "
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
$inputPicture.Location = "90, 210"
$inputPicture.ClientSize = "320, 200"
$inputPicture.BackColor = "Black"
$inputPicture.SizeMode = "Zoom"
$mainForm.Controls.Add($inputPicture)

# Output Label
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Location = "15, 435"
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
    $error.clear()
    $completeLabel.Text = "        " 

    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)

    # Image Brush
    $image = [System.Drawing.Image]::FromFile($textBoxIn.Text)
    $brush = New-Object System.Drawing.TextureBrush($image, "Tile")
    $brushBlack = New-Object System.Drawing.SolidBrush("Black")

    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap($image.Width,$image.Height)
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

    # Call Selected Fill
    $borderWidth = $borderComboBox.Text
    $reduction = $global:reductionSize*.01
    Invoke-Expression $global:selectedObject
} # End ProcessButton

Function Curves {
    $i = 0; $curve = @()
    While ($i -le $global:numberObjects) { $i++
        $CurveNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $image.width), `
             (Get-Random -minimum 0 -maximum $image.height))
        $curve += $curveNext
    }
    $bitmapGraphics.FillClosedCurve($brush, $Curve)
    # Paint central image
    If ([int]$borderWidth -ge 1) {
        $bitmapGraphics.FillEllipse($brushBlack, `
            (([int]$image.width-($image.width*$reduction))/2)-$borderWidth, `
            (([int]$image.height-($image.height*$reduction))/2)-$borderWidth, `
            ($image.width*$reduction)+([int]$borderWidth*2), `
            ($image.height*$reduction)+([int]$borderWidth*2))
    }
    $bitmapGraphics.FillEllipse($brush, `
            (([int]$image.width-($image.width*$reduction))/2), `
            (([int]$image.height-($image.height*$reduction))/2), `
            $image.width*$reduction, `
            $image.height*$reduction)

    $global:outFile = $scriptPath + "\"  + "MosaicFramedCurves_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($global:outFile)

    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End Curves

Function Ellipses {
    $i = 0;
    While ($i -le $global:numberObjects) { $i++
        $upperLeftX = (Get-Random -minimum -100 -maximum $image.width)
        $upperLeftY = (Get-Random -minimum -100 -maximum $image.height)
        $width = (Get-Random -minimum 10 -maximum ([int]$image.width * .25))
        $height = (Get-Random -minimum 10 -maximum ([int]$image.width * .25))
        If ([int]$borderWidth -ge 1) {
            $bitmapGraphics.FillEllipse($brushBlack, `
                $upperLeftX-$borderWidth, `
                $upperLeftY-$borderWidth, `
                $width+([int]$borderWidth*2), `
                $height+([int]$borderWidth*2))
        }
        $bitmapGraphics.FillEllipse($brush, $upperLeftX, $upperLeftY, $width, $height)
    }
    # Paint central image
    If ([int]$borderWidth -ge 1) {
        $bitmapGraphics.FillEllipse($brushBlack, `
            (([int]$image.width-($image.width*$reduction))/2)-$borderWidth, `
            (([int]$image.height-($image.height*$reduction))/2)-$borderWidth, `
            ($image.width*$reduction)+([int]$borderWidth*2), `
            ($image.height*$reduction)+([int]$borderWidth*2))
    }
    $bitmapGraphics.FillEllipse($brush, `
            (([int]$image.width-($image.width*$reduction))/2), `
            (([int]$image.height-($image.height*$reduction))/2), `
            $image.width*$reduction, `
            $image.height*$reduction)


    $global:outFile = $scriptPath + "\"  + "MosaicFramedEllipses_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($global:outFile)

    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End Ellipses

Function Polygons {
    $i = 0; $polygon = @()
    While ($i -le $global:numberObjects) { $i++
        $polygonNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $image.width), (Get-Random -minimum 0 -maximum $image.height))
        $polygon += $polygonNext
    }
    $bitmapGraphics.FillPolygon($brush, $polygon)
    # Paint central image
    If ([int]$borderWidth -ge 1) {
        $bitmapGraphics.FillRectangle($brushBlack, `
            (([int]$image.width-($image.width*$reduction))/2)-$borderWidth, `
            (([int]$image.height-($image.height*$reduction))/2)-$borderWidth, `
            ($image.width*$reduction)+([int]$borderWidth*2), `
            ($image.height*$reduction)+([int]$borderWidth*2))
    }
    $bitmapGraphics.FillRectangle($brush, `
            (([int]$image.width-($image.width*$reduction))/2), `
            (([int]$image.height-($image.height*$reduction))/2), `
            $image.width*$reduction, `
            $image.height*$reduction)


    $global:outFile = $scriptPath + "\"  + "MosaicFramedPolygons_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($global:outFile)

    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End Polygons

Function Rectangles {
    $i = 0;
    While ($i -le $global:numberObjects) { $i++
        $pointX = (Get-Random -minimum -100 -maximum ([int]$image.width + 100))
        $pointY = (Get-Random -minimum -100 -maximum ([int]$image.height + 100))
        $width = (Get-Random -minimum 1 -maximum ([int]$image.width * .25))
        $height = (Get-Random -minimum 1 -maximum ([int]$image.height * .25))
        If ([int]$borderWidth -ge 1) {
            $bitmapGraphics.FillRectangle($brushBlack, `
                $pointX-$borderWidth, $pointY-$borderWidth, `
                $width+([int]$borderWidth*2), `
                $height+([int]$borderWidth*2))
        }
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }
    # Paint central image
    If ([int]$borderWidth -ge 1) {
        $bitmapGraphics.FillRectangle($brushBlack, `
            ((([int]$image.width-($image.width*$reduction))/2)-$borderWidth), `
            ((([int]$image.height-($image.height*$reduction))/2)-$borderWidth), `
            ($image.width*$reduction)+([int]$borderWidth*2), `
            ($image.height*$reduction)+([int]$borderWidth*2))
    }
    $bitmapGraphics.FillRectangle($brush, `
            (([int]$image.width-($image.width*$reduction))/2), `
            (([int]$image.height-($image.height*$reduction))/2), `
            $image.width*$reduction, `
            $image.height*$reduction)

    $global:outFile = $scriptPath + "\"  + "MosaicFramedRectangles_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($global:outFile)

    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End Rectangles

Function Squares {
    $i = 0;
    While ($i -le $global:numberObjects) { $i++
        $pointX = (Get-Random -minimum -100 -maximum ([int]$image.width + 100))
        $pointY = (Get-Random -minimum -100 -maximum ([int]$image.height + 100))
        $width = (Get-Random -minimum 1 -maximum ([int]$image.width * .25))
        $height = $width
        If ([int]$borderWidth -ge 1) {
            $bitmapGraphics.FillRectangle($brushBlack, `
                $pointX-$borderWidth, `
                $pointY-$borderWidth, `
                $width+([int]$borderWidth*2), `
                $height+([int]$borderWidth*2))
        }
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }
    # Paint central image
    If ([int]$borderWidth -ge 1) {
        $bitmapGraphics.FillRectangle($brushBlack, `
            ((([int]$image.width-($image.width*$reduction))/2)-$borderWidth), `
            ((([int]$image.height-($image.height*$reduction))/2)-$borderWidth), `
            ($image.width*$reduction)+([int]$borderWidth*2), `
            ($image.height*$reduction)+([int]$borderWidth*2))
    }
    $bitmapGraphics.FillRectangle($brush, `
            (([int]$image.width-($image.width*$reduction))/2), `
            (([int]$image.height-($image.height*$reduction))/2), `
            $image.width*$reduction, `
            $image.height*$reduction)

    $global:outFile = $scriptPath + "\"  + "MosaicFramedSquares_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($global:outFile)
    FinalPicture($global:outFile)

    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    If($error.count -gt 0) {
        $completeLabel.ForeColor = "Red"
        $completeLabel.Text = "Error!"
    } Else {
        $completeLabel.ForeColor = "Green"
        $completeLabel.Text = "Success!"
    }
} # End Squares

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