<#
GeometricPatterns.ps1

Wayne Lindimore
wlindimore@gmail.com
AdminsCache.Wordpress.com

1-4-14
PowerShell Draw 12 Types of Random Geometric Patterns
    and Write Image to File
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main Form
$mainForm = New-Object Windows.Forms.Form
$mainForm.Location = "200,200"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.BackColor = "Cornsilk"
$mainForm.Font = “Comic Sans MS,8.25"
$mainForm.Text = "Draw Random Geometric Patterns"
$mainForm.Size = "580,550"

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:numberObjects = 100
$global:penWidth = 1
$global:colorText = "Multi(Random)"
$global:backgroundText = "Black"
$global:selectedObject = "Beziers"
$global:imageWidth = 1024
$global:imageHeight = 768

# Arcs Object
$radioButtonArcs = New-Object System.Windows.Forms.RadioButton
$radioButtonArcs.Location = "80,30"
$radioButtonArcs.ForeColor = "Indigo"
$radioButtonArcs.Text = "Arcs"
$radioButtonArcs.add_Click({
    $global:selectedObject = "Arcs"
})
$mainForm.Controls.Add($radioButtonArcs)

# Beziers Object
$radioButtonBeziers = New-Object System.Windows.Forms.RadioButton
$radioButtonBeziers.Location = "80,60"
$radioButtonBeziers.ForeColor = "Indigo"
$radioButtonBeziers.Text = "Beziers"
$radioButtonBeziers.add_Click({
    $global:selectedObject = "Beziers"
})
$mainForm.Controls.Add($radioButtonBeziers)

# BeziersConnected Object
$radioButtonBeziersConnected = New-Object System.Windows.Forms.RadioButton
$radioButtonBeziersConnected.Location = "80,90"
$radioButtonBeziersConnected.ForeColor = "Indigo"
$radioButtonBeziersConnected.Size = "160,23"
$radioButtonBeziersConnected.Text = "Beziers - Connected"
$radioButtonBeziersConnected.add_Click({
    $global:selectedObject = "BeziersConnected"
})
$mainForm.Controls.Add($radioButtonBeziersConnected)

# Curves Object
$radioButtonCurves = New-Object System.Windows.Forms.RadioButton
$radioButtonCurves.Location = "80,120"
$radioButtonCurves.ForeColor = "Indigo"
$radioButtonCurves.Size = "160,23"
$radioButtonCurves.Text = "Curves (Single Color Only)"
$radioButtonCurves.add_Click({
    $global:selectedObject = "Curves"
})
$mainForm.Controls.Add($radioButtonCurves)

# Ellipses Object
$radioButtonEllipses = New-Object System.Windows.Forms.RadioButton
$radioButtonEllipses.Location = "80,150"
$radioButtonEllipses.ForeColor = "Indigo"
$radioButtonEllipses.Text = "Ellipses"
$radioButtonEllipses.add_Click({
    $global:selectedObject = "Ellipses"
})
$mainForm.Controls.Add($radioButtonEllipses)

# Lines Object
$radioButtonLines = New-Object System.Windows.Forms.RadioButton
$radioButtonLines.Location = "80,180"
$radioButtonLines.ForeColor = "Indigo"
$radioButtonLines.Text = "Lines"
$radioButtonLines.add_Click({
    $global:selectedObject = "Lines"
})
$mainForm.Controls.Add($radioButtonLines)

# LinesConnected Object
$radioButtonLinesConnected = New-Object System.Windows.Forms.RadioButton
$radioButtonLinesConnected.Location = "350,30"
$radioButtonLinesConnected.ForeColor = "Indigo"
$radioButtonLinesConnected.Size = "160,23"
$radioButtonLinesConnected.Text = "Lines - Connected"
$radioButtonLinesConnected.add_Click({
    $global:selectedObject = "LinesConnected"
})
$mainForm.Controls.Add($radioButtonLinesConnected)

# LinesCornerburst Object
$radioButtonLinesCornerburst = New-Object System.Windows.Forms.RadioButton
$radioButtonLinesCornerburst.Location = "350,60"
$radioButtonLinesCornerburst.ForeColor = "Indigo"
$radioButtonLinesCornerburst.Size = "160,23"
$radioButtonLinesCornerburst.Text = "Lines - Cornerburst"
$radioButtonLinesCornerburst.add_Click({
    $global:selectedObject = "LinesCornerburst"
})
$mainForm.Controls.Add($radioButtonLinesCornerburst)

# LinesStarburst Object
$radioButtonLinesStarburst = New-Object System.Windows.Forms.RadioButton
$radioButtonLinesStarburst.Location = "350,90"
$radioButtonLinesStarburst.ForeColor = "Indigo"
$radioButtonLinesStarburst.Size = "160,23"
$radioButtonLinesStarburst.Text = "Lines - Starburst"
$radioButtonLinesStarburst.add_Click({
    $global:selectedObject = "LinesStarburst"
})
$mainForm.Controls.Add($radioButtonLinesStarburst)

# Pies Object
$radioButtonPies = New-Object System.Windows.Forms.RadioButton
$radioButtonPies.Location = "350,120"
$radioButtonPies.ForeColor = "Indigo"
$radioButtonPies.Text = "Pie Shapes"
$radioButtonPies.add_Click({
    $global:selectedObject = "Pies"
})
$mainForm.Controls.Add($radioButtonPies)

# Polygons Object
$radioButtonPolygons = New-Object System.Windows.Forms.RadioButton
$radioButtonPolygons.Location = "350,150"
$radioButtonPolygons.ForeColor = "Indigo"
$radioButtonPolygons.Size = "180,23"
$radioButtonPolygons.Text = "Polygons (Single Color Only)"
$radioButtonPolygons.add_Click({
    $global:selectedObject = "Polygons"
})
$mainForm.Controls.Add($radioButtonPolygons)

# Rectangles Object
$radioButtonRectangles = New-Object System.Windows.Forms.RadioButton
$radioButtonRectangles.Location = "350,180"
$radioButtonRectangles.ForeColor = "Indigo"
$radioButtonRectangles.Text = "Rectangles"
$radioButtonRectangles.add_Click({
    $global:selectedObject = "Rectangles"
})
$mainForm.Controls.Add($radioButtonRectangles)

# Select Label
$configureLabel = New-Object System.Windows.Forms.Label
$configureLabel.Font = “Comic Sans MS,10" 
$configureLabel.Location = "210,10"
$configureLabel.Size = "100,20"
$configureLabel.ForeColor = "OrangeRed"
$configureLabel.Text = "Select Object"
$mainForm.Controls.Add($configureLabel)

# Select Label
$configureLabel = New-Object System.Windows.Forms.Label
$configureLabel.Font = “Comic Sans MS,10" 
$configureLabel.Location = "205,230"
$configureLabel.Size = "160,20"
$configureLabel.ForeColor = "OrangeRed"
$configureLabel.Text = "Configure Pattern"
$mainForm.Controls.Add($configureLabel)

# Line Label
$lineLabel = New-Object System.Windows.Forms.Label 
$lineLabel.Location = "0,210"
$lineLabel.Size = "580,20"
$lineLabel.ForeColor = "MediumBlue"
$lineLabel.Text = "_________________________________________________________________________________"
$mainForm.Controls.Add($lineLabel)


# Number of Objects TrackBar
$numberTrackBar = New-Object Windows.Forms.TrackBar
$numberTrackBar.Location = "180,280"
$numberTrackBar.Orientation = "Horizontal"
$numberTrackBar.Width = 350
$numberTrackBar.Height = 40
$numberTrackBar.LargeChange = 500
$numberTrackBar.SmallChange = 10
$numberTrackBar.TickFrequency = 500
$numberTrackBar.TickStyle = "TopLeft"
$numberTrackBar.SetRange(1, 5000)
$numberTrackBar.Value = 200
$numberTrackBarValue = 200
$numberTrackBar.add_ValueChanged({
    $numberTrackBarValue = $numberTrackBar.Value
    $numberTrackBarLabel.Text = "Number Objects ($numberTrackBarValue)"
    $global:numberObjects = $numberTrackBarValue
})
$mainForm.Controls.add($numberTrackBar)

# Object Number Label
$numberTrackBarLabel = New-Object System.Windows.Forms.Label 
$numberTrackBarLabel.Location = "10,280"
$numberTrackBarLabel.Size = "160,23"
$numberTrackBarLabel.ForeColor = "MediumBlue"
$numberTrackBarLabel.Text = "Number Objects ($numberTrackBarValue)"
$mainForm.Controls.Add($numberTrackBarLabel)

# Pen Width TrackBar
$widthTrackBar = New-Object Windows.Forms.TrackBar
$widthTrackBar.Location = "180,320"
$widthTrackBar.Orientation = "Horizontal"
$widthTrackBar.Width = 350
$widthTrackBar.Height = 40
$widthTrackBar.LargeChange = 3
$widthTrackBar.SmallChange = 1
$widthTrackBar.TickFrequency = 1
$widthTrackBar.TickStyle = "TopLeft"
$widthTrackBar.SetRange(1, 10)
$widthTrackBar.Value = 1
$widthTrackBarValue = 1
$widthTrackBar.add_ValueChanged({
    $widthTrackBarValue = $widthTrackBar.Value
    $widthTrackBarLabel.Text = "Drawing Pen Width ($widthTrackBarValue)"
    $global:penWidth = $widthTrackBarValue
})
$mainForm.Controls.add($widthTrackBar)

# Pen Width Label
$widthTrackBarLabel = New-Object System.Windows.Forms.Label 
$widthTrackBarLabel.Location = "10,320"
$widthTrackBarLabel.Size = "160,23"
$widthTrackBarLabel.ForeColor = "MediumBlue"
$widthTrackBarLabel.Text = "Drawing Pen Width ($widthTrackBarValue)"
$mainForm.Controls.Add($widthTrackBarLabel)

# Colors ComboBox
$colorsComboBox = New-Object System.Windows.Forms.ComboBox
$colorsComboBox.Location = "350,380"
$colorsComboBox.Size = "120,20"
$colorsComboBox.ForeColor = "Indigo"
$colorsComboBox.BackColor = "White"
[void]$colorsComboBox.items.add("MultiColored")
[void]$colorsComboBox.items.add("Single Color")        
$colorsComboBox.SelectedIndex = 0
$mainForm.Controls.Add($colorsComboBox)

# Colors ComboBox Label
$colorsComboBoxLabel = New-Object System.Windows.Forms.Label 
$colorsComboBoxLabel.Location = "200,380"
$colorsComboBoxLabel.Size = "150,23"
$colorsComboBoxLabel.ForeColor = "MediumBlue"
$colorsComboBoxLabel.Text = "Object Color (Random)"
$mainForm.Controls.Add($colorsComboBoxLabel)

# Background ComboBox
$backgroundComboBox = New-Object System.Windows.Forms.ComboBox
$backgroundComboBox.Location = "350,420"
$backgroundComboBox.Size = "120,20"
$backgroundComboBox.ForeColor = "Indigo"
$backgroundComboBox.BackColor = "White"
[void]$backgroundComboBox.items.add("Black")
[void]$backgroundComboBox.items.add("White")
[void]$backgroundComboBox.items.add("Random")         
$backgroundComboBox.SelectedIndex = 0
$mainForm.Controls.Add($backgroundComboBox)

# Background ComboBox Label
$backgroundComboBoxLabel = New-Object System.Windows.Forms.Label 
$backgroundComboBoxLabel.Location = "200,420"
$backgroundComboBoxLabel.Size = "100,23"
$backgroundComboBoxLabel.ForeColor = "MediumBlue"
$backgroundComboBoxLabel.Text = "Background Color"
$mainForm.Controls.Add($backgroundComboBoxLabel)

# Iamge Size ComboBox
$imageComboBox = New-Object System.Windows.Forms.ComboBox
$imageComboBox.Location = "350,460"
$imageComboBox.Size = "120,20"
$imageComboBox.ForeColor = "Indigo"
$imageComboBox.BackColor = "White"
[void]$imageComboBox.items.add("800 x600 ")
[void]$imageComboBox.items.add("1024x768 ")
[void]$imageComboBox.items.add("1280x1024")
[void]$imageComboBox.items.add("1600x1200")          
$imageComboBox.SelectedIndex = 1
$mainForm.Controls.Add($imageComboBox)

# Image Size ComboBox Label
$imageComboBoxLabel = New-Object System.Windows.Forms.Label 
$imageComboBoxLabel.Location = "200,460"
$imageComboBoxLabel.Size = "100,23"
$imageComboBoxLabel.ForeColor = "MediumBlue"
$imageComboBoxLabel.Text = "Image Size"
$mainForm.Controls.Add($imageComboBoxLabel)

# Output Label
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Location = "40, 490"
$outputLabel.Size = "900, 20"
$outputLabel.ForeColor = "DarkBlue"
$outputLabel.Text = "Output Files Written to - " + $scriptPath
$mainForm.Controls.Add($outputLabel)

# Draw Button
$drawButton = New-Object System.Windows.Forms.Button 
$drawButton.Location = "40,420"
$drawButton.Size = "75,23"
$drawButton.ForeColor = "Green"
$drawButton.BackColor = "White"
$drawButton.Text = "Draw"
$drawButton.add_Click({DrawIt})
$mainForm.Controls.Add($drawButton)

# Exit Button
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "40,460"
$exitButton.Size = "75,23"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

Function DrawIt {
    $global:imageWidth = $imageComboBox.Text.Substring(0,4)
    $global:imageHeight = $imageComboBox.Text.Substring(5,4)
    Invoke-Expression $global:selectedObject
}

Function Arcs {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize All 6 Factors of the Arcs
        $pointX = (Get-Random -minimum (-([int]$global:imageWidth/2)) -maximum ([int]$global:imageWidth+([int]$global:imageWidth/2)))
        $pointY = (Get-Random -minimum (-([int]$global:imageHeight/2)) -maximum ([int]$global:imageHeight+([int]$global:imageHeight/2)))
        $pointWidth = (Get-Random -minimum 1 -maximum ([int]$global:imageWidth/2))
        $pointHeight = (Get-Random -minimum 1 -maximum ([int]$global:imageHeight/2))
        $angleStart = (Get-Random -minimum 1 -maximum 270)
        $angleSweep = (Get-Random -minimum 1 -maximum 270)
        # Draw the Arc
        $bitmapGraphics.DrawArc($pen, $pointX, $pointY, $pointWidth, $pointHeight, $angleStart, $angleSweep)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Arcs_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Beziers {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize All 4 Points of the Bezier
        $point1X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point1Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $point2X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point2Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $point3X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point3Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $point4X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point4Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        # Draw Bezier Curve
        $bitmapGraphics.DrawBezier($pen, $point1X, $point1Y, $point2X, $point2Y, $point3X, $point3Y, $point4X, $point4Y)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Beziers_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function BeziersConnected {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0
    # Set first start point
    $startX = (Get-Random -minimum 0 -maximum $global:imageWidth)
    $startY = (Get-Random -minimum 0 -maximum $global:imageHeight)
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize All 4 Points of the Bezier
        $point1X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point1Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $point2X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point2Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $point3X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point3Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $point4X = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $point4Y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        # Draw Bezier Curve
        $bitmapGraphics.DrawBezier($pen, $startX, $startY, $point2X, $point2Y, $point3X, $point3Y, $point4X, $point4Y)
        # Set next start point
        $startX = $point4X
        $startY = $point4Y
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "BeziersConnected_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Curves {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0; $curve = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Pen
    $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $pen = New-Object Drawing.Pen $penColor
    $pen.Width = $global:penWidth
    # Randomize an Array of Points
    While ($i -le $global:numberObjects) { $i++
        $CurveNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $curve += $curveNext
    }
    # Draw the curves from the Array of Points
    $bitmapGraphics.DrawCurve($pen, $Curve)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Curves_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Ellipses {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize All 4 Points for the Ellipse
        $topSide = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $bottomSide = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $leftSide = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $rightSide = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        # Draw the Ellipse
        $bitmapGraphics.DrawEllipse($pen, $topSide, $bottomSide, $leftSide, $rightSide)
    }

        $point = (Get-Random -minimum (-([int]$global:imageWidth/2)) -maximum ([int]$global:imageWidth+([int]$global:imageWidth/2)))
        $point = (Get-Random -minimum (-([int]$global:imageHeight/2)) -maximum ([int]$global:imageHeight+([int]$global:imageHeight/2)))

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Ellipses_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Lines {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize All 4 Points for the Line
        $lineX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $lineY = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $newX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $newY = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        # Draw the Line
        $bitmapGraphics.DrawLine($pen, $lineX, $lineY, $newX, $newY)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Lines_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function LinesConnected {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0; $nextX = [int]$global:imageWidth/2; $nextY = [int]$global:imageHeight/2
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize Both Points for the Line
        $pointX = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $pointY = (Get-Random -minimum 0 -maximum $global:imageHeight)
        # Draw the Line
        $bitmapGraphics.DrawLine($pen, $pointX, $pointY, $nextX, $nextY)
        # Set Starting Point as Previous End Point
        $nextX = $pointX
        $nextY = $pointY
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "LinesConnected_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function LinesCornerburst {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0; $cornerX = 0; $cornerY = $global:imageHeight
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize Both Points for the Line
        $pointX = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $pointY = (Get-Random -minimum 0 -maximum $global:imageHeight)
        # Draw the Line
        $bitmapGraphics.DrawLine($pen, $pointX, $pointY, $cornerX, $cornerY)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "LineCornerburst_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function LinesStarburst {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0; $centerX = [int]$global:imageWidth/2; $centerY = [int]$global:imageHeight/2
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize Both Points for the Line
        $pointX = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $pointY = (Get-Random -minimum 0 -maximum $global:imageHeight)
        # Draw the Line
        $bitmapGraphics.DrawLine($pen, $pointX, $pointY, $centerX, $centerY)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "LinesStarburst_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Pies {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize All 6 Factors of the Pie
        $pointX = (Get-Random -minimum (-([int]$global:imageWidth/2)) -maximum ([int]$global:imageWidth+([int]$global:imageWidth/2)))
        $pointY = (Get-Random -minimum (-([int]$global:imageHeight/2)) -maximum ([int]$global:imageHeight+([int]$global:imageHeight/2)))
        $pointWidth = (Get-Random -minimum 1 -maximum 400)
        $pointHeight = (Get-Random -minimum 1 -maximum 400)
        $angleStart = (Get-Random -minimum 1 -maximum 360)
        $angleSweep = (Get-Random -minimum 1 -maximum 120)
        # Draw the Pie Shape
        $bitmapGraphics.DrawPie($pen, $pointX, $pointY, $pointWidth, $pointHeight, $angleStart, $angleSweep)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Pies_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Polygons {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0; $polygon = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Pen
    $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $pen = New-Object Drawing.Pen $penColor
    $pen.Width = $global:penWidth
    # Randomize the Array of Points
    While ($i -le $global:numberObjects) { $i++
        $polygonNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $polygon += $polygonNext
    }
    # Draw the Polygon from the Array of Points
    $bitmapGraphics.DrawPolygon($pen, $polygon)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Polygons_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Rectangles {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
    If ($backgroundComboBox.Text -eq "Random") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
        $backColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $bitmapGraphics.Clear($backColor)
    } Else {
        $bitmapGraphics.Clear($backgroundComboBox.Text)
    }

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Pen
        $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $pen = New-Object Drawing.Pen $penColor
        $pen.Width = $global:penWidth
        # Randomize All 4 Points of the Rectangle
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum $global:imageWidth)
        $height = (Get-Random -minimum 0 -maximum $global:imageHeight)
        # Draw the Rectangle
        $bitmapGraphics.DrawRectangle($pen, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Rectangles_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

$mainForm.ShowDialog()| Out-Null