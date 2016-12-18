<#
GeometricPatterns2.ps1

Wayne Lindimore
wlindimore@gmail.com
AdminsCache.Wordpress.com

1-24-14 PowerShell Draw 12 Types of Random Geometric Patterns
    and Write Image to File

3-23-14 Updated, now with 33 Geometric Patterns/Fills

#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main Form
$mainForm = New-Object Windows.Forms.Form
$mainForm.Location = "200,200"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.BackColor = "Cornsilk"
$mainForm.Font = “Comic Sans MS,8.25"
$mainForm.Text = "Draw Random Geometric Patterns v2"
$mainForm.Size = "580,610"

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
$radioButtonArcs.Location = "30,40"
$radioButtonArcs.ForeColor = "Indigo"
$radioButtonArcs.Text = "Arcs"
$radioButtonArcs.add_Click({
    $global:selectedObject = "Arcs"
})
$mainForm.Controls.Add($radioButtonArcs)

# Beziers Object
$radioButtonBeziers = New-Object System.Windows.Forms.RadioButton
$radioButtonBeziers.Location = "30,60"
$radioButtonBeziers.ForeColor = "Indigo"
$radioButtonBeziers.Size = "160,23"
$radioButtonBeziers.Text = "Beziers"
$radioButtonBeziers.add_Click({
    $global:selectedObject = "Beziers"
})
$mainForm.Controls.Add($radioButtonBeziers)

# BeziersConnected Object
$radioButtonBeziersConnected = New-Object System.Windows.Forms.RadioButton
$radioButtonBeziersConnected.Location = "30,80"
$radioButtonBeziersConnected.ForeColor = "Indigo"
$radioButtonBeziersConnected.Size = "160,23"
$radioButtonBeziersConnected.Text = "Beziers - Connected"
$radioButtonBeziersConnected.add_Click({
    $global:selectedObject = "BeziersConnected"
})
$mainForm.Controls.Add($radioButtonBeziersConnected)

# Curves Object
$radioButtonCurves = New-Object System.Windows.Forms.RadioButton
$radioButtonCurves.Location = "30,100"
$radioButtonCurves.ForeColor = "Indigo"
$radioButtonCurves.Size = "160,23"
$radioButtonCurves.Text = "Curves - Single Color"
$radioButtonCurves.add_Click({
    $global:selectedObject = "Curves"
})
$mainForm.Controls.Add($radioButtonCurves)

# Curves Solid Filled Object
$radioButtonCurvesFilled = New-Object System.Windows.Forms.RadioButton
$radioButtonCurvesFilled.Location = "30,120"
$radioButtonCurvesFilled.ForeColor = "Indigo"
$radioButtonCurvesFilled.Size = "160,23"
$radioButtonCurvesFilled.Text = "Curves - Solid Filled"
$radioButtonCurvesFilled.add_Click({
    $global:selectedObject = "CurvesFilled"
})
$mainForm.Controls.Add($radioButtonCurvesFilled)

# Curves Gradient Object
$radioButtonCurvesGradient = New-Object System.Windows.Forms.RadioButton
$radioButtonCurvesGradient.Location = "30,140"
$radioButtonCurvesGradient.ForeColor = "Indigo"
$radioButtonCurvesGradient.Size = "160,23"
$radioButtonCurvesGradient.Text = "Curves - Gradient"
$radioButtonCurvesGradient.add_Click({
    $global:selectedObject = "CurvesGradient"
})
$mainForm.Controls.Add($radioButtonCurvesGradient)

# Curves Hatch Object
$radioButtonCurvesHatch = New-Object System.Windows.Forms.RadioButton
$radioButtonCurvesHatch.Location = "30,160"
$radioButtonCurvesHatch.ForeColor = "Indigo"
$radioButtonCurvesHatch.Size = "160,23"
$radioButtonCurvesHatch.Text = "Curves - Hatch Filled"
$radioButtonCurvesHatch.add_Click({
    $global:selectedObject = "CurvesHatch"
})
$mainForm.Controls.Add($radioButtonCurvesHatch)

# Ellipses Object
$radioButtonEllipses = New-Object System.Windows.Forms.RadioButton
$radioButtonEllipses.Location = "30,180"
$radioButtonEllipses.ForeColor = "Indigo"
$radioButtonEllipses.Size = "160,23"
$radioButtonEllipses.Text = "Ellipses"
$radioButtonEllipses.add_Click({
    $global:selectedObject = "Ellipses"
})
$mainForm.Controls.Add($radioButtonEllipses)

# Ellipses Solid Filled Object
$radioButtonEllipsesFilled = New-Object System.Windows.Forms.RadioButton
$radioButtonEllipsesFilled.Location = "30,200"
$radioButtonEllipsesFilled.ForeColor = "Indigo"
$radioButtonEllipsesFilled.Size = "160,23"
$radioButtonEllipsesFilled.Text = "Ellipses - Solid Filled"
$radioButtonEllipsesFilled.add_Click({
    $global:selectedObject = "EllipsesFilled"
})
$mainForm.Controls.Add($radioButtonEllipsesFilled)

# Ellipses Gradient Object
$radioButtonEllipsesGradient = New-Object System.Windows.Forms.RadioButton
$radioButtonEllipsesGradient.Location = "30,220"
$radioButtonEllipsesGradient.ForeColor = "Indigo"
$radioButtonEllipsesGradient.Size = "170,23"
$radioButtonEllipsesGradient.Text = "Ellipses - Gradient(Skewed)"
$radioButtonEllipsesGradient.add_Click({
    $global:selectedObject = "EllipsesGradient"
})
$mainForm.Controls.Add($radioButtonEllipsesGradient)

# Ellipses Hatch Object
$radioButtonEllipsesHatch = New-Object System.Windows.Forms.RadioButton
$radioButtonEllipsesHatch.Location = "30,240"
$radioButtonEllipsesHatch.ForeColor = "Indigo"
$radioButtonEllipsesHatch.Size = "160,23"
$radioButtonEllipsesHatch.Text = "Ellipses - Hatch Filled"
$radioButtonEllipsesHatch.add_Click({
    $global:selectedObject = "EllipsesHatch"
})
$mainForm.Controls.Add($radioButtonEllipsesHatch)

# Lines Object
$radioButtonLines = New-Object System.Windows.Forms.RadioButton
$radioButtonLines.Location = "205,40"
$radioButtonLines.ForeColor = "Indigo"
$radioButtonLines.Size = "160,23"
$radioButtonLines.Text = "Lines"
$radioButtonLines.add_Click({
    $global:selectedObject = "Lines"
})
$mainForm.Controls.Add($radioButtonLines)

# LinesConnected Object
$radioButtonLinesConnected = New-Object System.Windows.Forms.RadioButton
$radioButtonLinesConnected.Location = "205,60"
$radioButtonLinesConnected.ForeColor = "Indigo"
$radioButtonLinesConnected.Size = "160,23"
$radioButtonLinesConnected.Text = "Lines - Connected"
$radioButtonLinesConnected.add_Click({
    $global:selectedObject = "LinesConnected"
})
$mainForm.Controls.Add($radioButtonLinesConnected)

# LinesCornerburst Object
$radioButtonLinesCornerburst = New-Object System.Windows.Forms.RadioButton
$radioButtonLinesCornerburst.Location = "205,80"
$radioButtonLinesCornerburst.ForeColor = "Indigo"
$radioButtonLinesCornerburst.Size = "160,23"
$radioButtonLinesCornerburst.Text = "Lines - Cornerburst"
$radioButtonLinesCornerburst.add_Click({
    $global:selectedObject = "LinesCornerburst"
})
$mainForm.Controls.Add($radioButtonLinesCornerburst)

# LinesStarburst Object
$radioButtonLinesStarburst = New-Object System.Windows.Forms.RadioButton
$radioButtonLinesStarburst.Location = "205,100"
$radioButtonLinesStarburst.ForeColor = "Indigo"
$radioButtonLinesStarburst.Size = "160,23"
$radioButtonLinesStarburst.Text = "Lines - Starburst"
$radioButtonLinesStarburst.add_Click({
    $global:selectedObject = "LinesStarburst"
})
$mainForm.Controls.Add($radioButtonLinesStarburst)

# Pies Object
$radioButtonPies = New-Object System.Windows.Forms.RadioButton
$radioButtonPies.Location = "205,120"
$radioButtonPies.ForeColor = "Indigo"
$radioButtonPies.Size = "160,23"
$radioButtonPies.Text = "Pies"
$radioButtonPies.add_Click({
    $global:selectedObject = "Pies"
})
$mainForm.Controls.Add($radioButtonPies)

# Pies Solid Filled Object
$radioButtonPiesFilled = New-Object System.Windows.Forms.RadioButton
$radioButtonPiesFilled.Location = "205,140"
$radioButtonPiesFilled.ForeColor = "Indigo"
$radioButtonPiesFilled.Size = "160,23"
$radioButtonPiesFilled.Text = "Pies - Solid Filled"
$radioButtonPiesFilled.add_Click({
    $global:selectedObject = "PiesFilled"
})
$mainForm.Controls.Add($radioButtonPiesFilled)

# Pies Hatch Object
$radioButtonPiesHatch = New-Object System.Windows.Forms.RadioButton
$radioButtonPiesHatch.Location = "205,160"
$radioButtonPiesHatch.ForeColor = "Indigo"
$radioButtonPiesHatch.Size = "160,23"
$radioButtonPiesHatch.Text = "Pies - Hatch Filled"
$radioButtonPiesHatch.add_Click({
    $global:selectedObject = "PiesHatch"
})
$mainForm.Controls.Add($radioButtonPiesHatch)

# Points Object
$radioButtonPoints = New-Object System.Windows.Forms.RadioButton
$radioButtonPoints.Location = "205,180"
$radioButtonPoints.ForeColor = "Indigo"
$radioButtonPoints.Size = "160,23"
$radioButtonPoints.Text = "Points"
$radioButtonPoints.add_Click({
    $global:selectedObject = "Points"
})
$mainForm.Controls.Add($radioButtonPoints)

# Polygons Object
$radioButtonPolygons = New-Object System.Windows.Forms.RadioButton
$radioButtonPolygons.Location = "205,200"
$radioButtonPolygons.ForeColor = "Indigo"
$radioButtonPolygons.Size = "160,23"
$radioButtonPolygons.Text = "Polygons - Single Color"
$radioButtonPolygons.add_Click({
    $global:selectedObject = "Polygons"
})
$mainForm.Controls.Add($radioButtonPolygons)

# Polygons Solid Filled Object
$radioButtonPolygonsFilled = New-Object System.Windows.Forms.RadioButton
$radioButtonPolygonsFilled.Location = "205,220"
$radioButtonPolygonsFilled.ForeColor = "Indigo"
$radioButtonPolygonsFilled.Size = "160,23"
$radioButtonPolygonsFilled.Text = "Polygons - Solid Filled"
$radioButtonPolygonsFilled.add_Click({
    $global:selectedObject = "PolygonsFilled"
})
$mainForm.Controls.Add($radioButtonPolygonsFilled)

# Polygons Gradient Object
$radioButtonPolygonsGradient = New-Object System.Windows.Forms.RadioButton
$radioButtonPolygonsGradient.Location = "205,240"
$radioButtonPolygonsGradient.ForeColor = "Indigo"
$radioButtonPolygonsGradient.Size = "160,23"
$radioButtonPolygonsGradient.Text = "Polygons - Gradient"
$radioButtonPolygonsGradient.add_Click({
    $global:selectedObject = "PolygonsGradient"
})
$mainForm.Controls.Add($radioButtonPolygonsGradient)

# Polygons Hatch Object
$radioButtonPolygonsHatch = New-Object System.Windows.Forms.RadioButton
$radioButtonPolygonsHatch.Location = "380,40"
$radioButtonPolygonsHatch.ForeColor = "Indigo"
$radioButtonPolygonsHatch.Size = "160,23"
$radioButtonPolygonsHatch.Text = "Polygons - Hatch Filled"
$radioButtonPolygonsHatch.add_Click({
    $global:selectedObject = "PolygonsHatch"
})
$mainForm.Controls.Add($radioButtonPolygonsHatch)

# Rectangles Object
$radioButtonRectangles = New-Object System.Windows.Forms.RadioButton
$radioButtonRectangles.Location = "380,60"
$radioButtonRectangles.ForeColor = "Indigo"
$radioButtonRectangles.Size = "180,23"
$radioButtonRectangles.Text = "Rectangles"
$radioButtonRectangles.add_Click({
    $global:selectedObject = "Rectangles"
})
$mainForm.Controls.Add($radioButtonRectangles)

# Rectangles Solid Filled Object
$radioButtonRectanglesFilled = New-Object System.Windows.Forms.RadioButton
$radioButtonRectanglesFilled.Location = "380,80"
$radioButtonRectanglesFilled.ForeColor = "Indigo"
$radioButtonRectanglesFilled.Size = "180,23"
$radioButtonRectanglesFilled.Text = "Rectangles - Solid Filled"
$radioButtonRectanglesFilled.add_Click({
    $global:selectedObject = "RectanglesFilled"
})
$mainForm.Controls.Add($radioButtonRectanglesFilled)

# Rectangles Gradient Object
$radioButtonRectanglesGradient = New-Object System.Windows.Forms.RadioButton
$radioButtonRectanglesGradient.Location = "380,100"
$radioButtonRectanglesGradient.ForeColor = "Indigo"
$radioButtonRectanglesGradient.Size = "180,23"
$radioButtonRectanglesGradient.Text = "Rectangles - Gradient"
$radioButtonRectanglesGradient.add_Click({
    $global:selectedObject = "RectanglesGradient"
})
$mainForm.Controls.Add($radioButtonRectanglesGradient)

# Rectangles Hatch Object
$radioButtonRectanglesHatch = New-Object System.Windows.Forms.RadioButton
$radioButtonRectanglesHatch.Location = "380,120"
$radioButtonRectanglesHatch.ForeColor = "Indigo"
$radioButtonRectanglesHatch.Size = "160,23"
$radioButtonRectanglesHatch.Text = "Rectangles - Hatch Filled"
$radioButtonRectanglesHatch.add_Click({
    $global:selectedObject = "RectanglesHatch"
})
$mainForm.Controls.Add($radioButtonRectanglesHatch)

# Squares Object
$radioButtonSquares = New-Object System.Windows.Forms.RadioButton
$radioButtonSquares.Location = "380,140"
$radioButtonSquares.ForeColor = "Indigo"
$radioButtonSquares.Size = "180,23"
$radioButtonSquares.Text = "Squares"
$radioButtonSquares.add_Click({
    $global:selectedObject = "Squares"
})
$mainForm.Controls.Add($radioButtonSquares)

# Squares Solid Filled Object
$radioButtonSquaresFilled = New-Object System.Windows.Forms.RadioButton
$radioButtonSquaresFilled.Location = "380,160"
$radioButtonSquaresFilled.ForeColor = "Indigo"
$radioButtonSquaresFilled.Size = "180,23"
$radioButtonSquaresFilled.Text = "Squares - Solid Filled"
$radioButtonSquaresFilled.add_Click({
    $global:selectedObject = "SquaresFilled"
})
$mainForm.Controls.Add($radioButtonSquaresFilled)

# Squares Gradient Object
$radioButtonSquaresGradient = New-Object System.Windows.Forms.RadioButton
$radioButtonSquaresGradient.Location = "380,180"
$radioButtonSquaresGradient.ForeColor = "Indigo"
$radioButtonSquaresGradient.Size = "180,23"
$radioButtonSquaresGradient.Text = "Squares - Gradient"
$radioButtonSquaresGradient.Checked = $true
$radioButtonSquaresGradient.add_Click({
    $global:selectedObject = "SquaresGradient"
})
$mainForm.Controls.Add($radioButtonSquaresGradient)

# Squares Hatch Object
$radioButtonSquaresHatch = New-Object System.Windows.Forms.RadioButton
$radioButtonSquaresHatch.Location = "380,200"
$radioButtonSquaresHatch.ForeColor = "Indigo"
$radioButtonSquaresHatch.Size = "180,23"
$radioButtonSquaresHatch.Text = "Squares - Hatch Filled"
$radioButtonSquaresHatch.add_Click({
    $global:selectedObject = "SquaresHatch"
})
$mainForm.Controls.Add($radioButtonSquaresHatch)

# Stars Object
$radioButtonStars = New-Object System.Windows.Forms.RadioButton
$radioButtonStars.Location = "380,220"
$radioButtonStars.ForeColor = "Indigo"
$radioButtonStars.Size = "180,23"
$radioButtonStars.Text = "Stars"
$radioButtonStars.add_Click({
    $global:selectedObject = "Stars"
})
$mainForm.Controls.Add($radioButtonStars)

# Triangles Object
$radioButtonTriangles = New-Object System.Windows.Forms.RadioButton
$radioButtonTriangles.Location = "380,240"
$radioButtonTriangles.ForeColor = "Indigo"
$radioButtonTriangles.Size = "180,23"
$radioButtonTriangles.Text = "Triangles"
$radioButtonTriangles.add_Click({
    $global:selectedObject = "Triangles"
})
$mainForm.Controls.Add($radioButtonTriangles)

# Select Label
$configureLabel = New-Object System.Windows.Forms.Label
$configureLabel.Font = “Comic Sans MS,10" 
$configureLabel.Location = "230,5"
$configureLabel.Size = "100,20"
$configureLabel.ForeColor = "OrangeRed"
$configureLabel.Text = "Select Object"
$mainForm.Controls.Add($configureLabel)

# Line Label
$lineLabel = New-Object System.Windows.Forms.Label 
$lineLabel.Location = "0,270"
$lineLabel.Size = "580,20"
$lineLabel.ForeColor = "MediumBlue"
$lineLabel.Text = "_________________________________________________________________________________"
$mainForm.Controls.Add($lineLabel)

# Select Label
$configureLabel = New-Object System.Windows.Forms.Label
$configureLabel.Font = “Comic Sans MS,10" 
$configureLabel.Location = "205,290"
$configureLabel.Size = "160,20"
$configureLabel.ForeColor = "OrangeRed"
$configureLabel.Text = "Configure Pattern"
$mainForm.Controls.Add($configureLabel)

# Number of Objects TrackBar
$numberTrackBar = New-Object Windows.Forms.TrackBar
$numberTrackBar.Location = "180,340"
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
$numberTrackBarLabel.Location = "10,340"
$numberTrackBarLabel.Size = "160,23"
$numberTrackBarLabel.ForeColor = "MediumBlue"
$numberTrackBarLabel.Text = "Number Objects ($numberTrackBarValue)"
$mainForm.Controls.Add($numberTrackBarLabel)

# Pen Width TrackBar
$widthTrackBar = New-Object Windows.Forms.TrackBar
$widthTrackBar.Location = "180,380"
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
$widthTrackBarLabel.Location = "10,380"
$widthTrackBarLabel.Size = "160,23"
$widthTrackBarLabel.ForeColor = "MediumBlue"
$widthTrackBarLabel.Text = "Drawing Pen Width ($widthTrackBarValue)"
$mainForm.Controls.Add($widthTrackBarLabel)

# Colors ComboBox
$colorsComboBox = New-Object System.Windows.Forms.ComboBox
$colorsComboBox.Location = "200,440"
$colorsComboBox.Size = "120,20"
$colorsComboBox.ForeColor = "Indigo"
$colorsComboBox.BackColor = "White"
[void]$colorsComboBox.items.add("MultiColored")
[void]$colorsComboBox.items.add("Single Color")        
$colorsComboBox.SelectedIndex = 0
$mainForm.Controls.Add($colorsComboBox)

# Colors ComboBox Label
$colorsComboBoxLabel = New-Object System.Windows.Forms.Label 
$colorsComboBoxLabel.Location = "200,440"
$colorsComboBoxLabel.Size = "200,23"
$colorsComboBoxLabel.ForeColor = "MediumBlue"
$colorsComboBoxLabel.Text = "Object Color (Random)"
$mainForm.Controls.Add($colorsComboBoxLabel)

# Background ComboBox
$backgroundComboBox = New-Object System.Windows.Forms.ComboBox
$backgroundComboBox.Location = "200,480"
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
$backgroundComboBoxLabel.Location = "200,480"
$backgroundComboBoxLabel.Size = "100,23"
$backgroundComboBoxLabel.ForeColor = "MediumBlue"
$backgroundComboBoxLabel.Text = "Background Color"
$mainForm.Controls.Add($backgroundComboBoxLabel)

# Iamge Size ComboBox
$imageComboBox = New-Object System.Windows.Forms.ComboBox
$imageComboBox.Location = "200,520"
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
$imageComboBoxLabel.Location = "200,520"
$imageComboBoxLabel.Size = "100,23"
$imageComboBoxLabel.ForeColor = "MediumBlue"
$imageComboBoxLabel.Text = "Image Size"
$mainForm.Controls.Add($imageComboBoxLabel)

# Output Label
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Location = "10, 550"
$outputLabel.Size = "900, 20"
$outputLabel.ForeColor = "DarkBlue"
$outputLabel.Text = "Output Files Written to - " + $scriptPath
$mainForm.Controls.Add($outputLabel)

# Draw Button
$drawButton = New-Object System.Windows.Forms.Button 
$drawButton.Location = "40,480"
$drawButton.Size = "75,23"
$drawButton.ForeColor = "Green"
$drawButton.BackColor = "White"
$drawButton.Text = "Draw"
$drawButton.add_Click({DrawIt})
$mainForm.Controls.Add($drawButton)

# Exit Button
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "40,520"
$exitButton.Size = "75,23"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

Function DrawIt {
    $global:imageWidth  = [int]$imageComboBox.Text.Split("x")[0]
    $global:imageHeight = [int]$imageComboBox.Text.Split("x")[1]
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

Function CurvesFilled {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0; $curve = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Brush
    $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $brush = New-Object System.Drawing.SolidBrush $brushColor
    # Randomize an Array of Points
    While ($i -le $global:numberObjects) { $i++
        $CurveNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $curve += $curveNext
    }
    # Draw the curves from the Array of Points
    $bitmapGraphics.FillClosedCurve($brush, $Curve)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "FilledCurves_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}


Function CurvesGradient {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap)
    # Image Background Color
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

    # Main Loop
    $i = 0; $curve = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Brush
    $pointStart = New-Object System.Drawing.Point
    $pointStart.X = 0
    $pointStart.Y = 0
    $pointStop = New-Object System.Drawing.Point
    $pointStop.X = $global:imageWidth
    $pointStop.Y = $global:imageHeight
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush( `
        $pointStart, $pointStop,  `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))

    # Randomize an Array of Points
    While ($i -le $global:numberObjects) { $i++
        $CurveNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $curve += $curveNext
    }
    # Draw the curves from the Array of Points
    $bitmapGraphics.FillClosedCurve($brush, $Curve)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "GradientCurves_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}


Function CurvesHatch {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0; $curve = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Brush
    $brush = New-Object System.Drawing.Drawing2D.HatchBrush( `
        [System.Drawing.Drawing2D.HatchStyle] $hatchStyle[(Get-Random -minimum 0 -maximum 52)], `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))
    # Randomize an Array of Points
    While ($i -le $global:numberObjects) { $i++
        $CurveNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $curve += $curveNext
    }
    # Draw the curves from the Array of Points
    $bitmapGraphics.FillClosedCurve($brush, $Curve)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "HatchCurves_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
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

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Ellipses_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function EllipsesFilled {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Brush
        $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $brush = New-Object System.Drawing.SolidBrush $brushColor
        # Randomize All 4 Points for the Ellipse
        $upperLeftX = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $upperLeftY = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $height = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        # Draw the Ellipse
        $bitmapGraphics.FillEllipse($brush, $upperLeftX, $upperLeftY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "EllipsesFilled_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function EllipsesGradient {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Randomize All 4 Points for the Ellipse
        $upperLeftX = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $upperLeftY = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $height = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        # Setup Brush
        $pointStart = New-Object System.Drawing.Point
        $pointStart.X = $upperLeftX
        $pointStart.Y = $upperLeftY
        $pointStop = New-Object System.Drawing.Point
        $pointStop.X = $random1
        $pointStop.Y = $random2
        $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($pointStart, $pointStop,  `
            [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
            [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))
        # Draw the Ellipse
        $bitmapGraphics.FillEllipse($brush, $upperLeftX, $upperLeftY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "EllipsesGradient_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function EllipsesHatch {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Select Hatch Style
    $maxHatchStyle = 53
    $hatchStyle = @()
    For ($i = [Convert]::ToInt32([Drawing.Drawing2D.HatchStyle]::Min); $i -lt $maxHatchStyle; $i++) {
        $hatchStyle += ([Drawing.Drawing2D.HatchStyle] $i)
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
        # Setup Brush
        $brush = New-Object System.Drawing.Drawing2D.HatchBrush( `
        [System.Drawing.Drawing2D.HatchStyle] $hatchStyle[(Get-Random -minimum 0 -maximum 52)], `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))
        # Randomize All 4 Points for the Ellipse
        $upperLeftX = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $upperLeftY = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $height = (Get-Random -minimum (-$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        # Draw the Ellipse
        $bitmapGraphics.FillEllipse($brush, $upperLeftX, $upperLeftY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "EllipsesHatch_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
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

Function PiesFilled {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Brush
        $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $brush = New-Object System.Drawing.SolidBrush $brushColor
        # Randomize Pie Values
        $pointX = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $pointY = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $pointWidth = (Get-Random -minimum (1) -maximum (400))
        $pointHeight = (Get-Random -minimum (1) -maximum (400))
        $angleStart = (Get-Random -minimum (1) -maximum (360))
        $angleSweep = (Get-Random -minimum (1) -maximum (120))
        # Draw the Pie
        $bitmapGraphics.FillPie($brush, $pointX, $pointY, $pointWidth, $pointHeight, $angleStart, $angleSweep)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "PiesFilled_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function PiesHatch {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    $maxHatchStyle = 53
    $hatchStyle = @()
    For ($i = [Convert]::ToInt32([Drawing.Drawing2D.HatchStyle]::Min); $i -lt $maxHatchStyle; $i++) {
        $hatchStyle += ([Drawing.Drawing2D.HatchStyle] $i)
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
        # Setup Brush
        $brush = New-Object System.Drawing.Drawing2D.HatchBrush( `
        [System.Drawing.Drawing2D.HatchStyle] $hatchStyle[(Get-Random -minimum 0 -maximum 52)], `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))
        # Randomize Pie Values
        $pointX = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $pointY = (Get-Random -minimum (-$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $pointWidth = (Get-Random -minimum (1) -maximum (400))
        $pointHeight = (Get-Random -minimum (1) -maximum (400))
        $angleStart = (Get-Random -minimum (1) -maximum (360))
        $angleSweep = (Get-Random -minimum (1) -maximum (120))
        # Draw the Pie
        $bitmapGraphics.FillPie($brush, $pointX, $pointY, $pointWidth, $pointHeight, $angleStart, $angleSweep)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "PiesHatch_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Points {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le ($global:numberObjects*100)) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Randomize Pixels
        $xPixel = (Get-Random -minimum (1) -maximum ([int]$global:imageWidth))
        $yPixel = (Get-Random -minimum (1) -maximum ([int]$global:imageHeight))
        # Draw the Pixel
        [void]$bitmap.SetPixel($xPixel, $yPixel, [System.Drawing.Color]::FromArgb($red, $green, $blue))
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Points_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
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

Function PolygonsFilled {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0; $polygon = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Brush
    $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $brush = New-Object System.Drawing.SolidBrush $brushColor
    # Randomize the Array of Points
    While ($i -le $global:numberObjects) { $i++
        $polygonNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $polygon += $polygonNext
    }
    # Draw the Polygon from the Array of Points
    $bitmapGraphics.FillPolygon($brush, $polygon)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "PolygonsFilled_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function PolygonsGradient {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0; $polygon = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Brush
    $pointStart = New-Object System.Drawing.Point
    $pointStart.X = 0
    $pointStart.Y = 0
    $pointStop = New-Object System.Drawing.Point
    $pointStop.X = 1024
    $pointStop.Y = 768
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($pointStart, $pointStop,  `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))
    # Randomize the Array of Points
    While ($i -le $global:numberObjects) { $i++
        $polygonNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $polygon += $polygonNext
    }
    # Draw the Polygon from the Array of Points
    $bitmapGraphics.FillPolygon($brush, $polygon)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "PolygonsGradient_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function PolygonsHatch {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Select Hatch Style
    $maxHatchStyle = 53
    $hatchStyle = @()
    For ($i = [Convert]::ToInt32([Drawing.Drawing2D.HatchStyle]::Min); $i -lt $maxHatchStyle; $i++) {
        $hatchStyle += ([Drawing.Drawing2D.HatchStyle] $i)
    }

    # Main Loop
    $i = 0; $polygon = @()
    # Get Random Color if Selected
    If ($colorsComboBox.Text -eq "MultiColored") {
        $red   = (Get-Random -minimum 0 -maximum 255)
        $green = (Get-Random -minimum 0 -maximum 255)
        $blue  = (Get-Random -minimum 0 -maximum 255)
    }
    # Setup Brush
    $brush = New-Object System.Drawing.Drawing2D.HatchBrush( `
        [System.Drawing.Drawing2D.HatchStyle] $hatchStyle[(Get-Random -minimum 0 -maximum 52)], `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))

    # Randomize the Array of Points
    While ($i -le $global:numberObjects) { $i++
        $polygonNext = New-Object System.Drawing.Point `
            ((Get-Random -minimum 0 -maximum $global:imageWidth), (Get-Random -minimum 0 -maximum $global:imageHeight))
        $polygon += $polygonNext
    }
    # Draw the Polygon from the Array of Points
    $bitmapGraphics.FillPolygon($brush, $polygon)

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "PolygonsHatch_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
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
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = (Get-Random -minimum 0 -maximum ([int]$global:imageHeight*.25))
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

Function RectanglesFilled {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Brush
        $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $brush = New-Object System.Drawing.SolidBrush $brushColor
        # Randomize All 4 Points of the Rectangle
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = (Get-Random -minimum 0 -maximum ([int]$global:imageHeight*.25))
        # Draw the Rectangle
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "RectanglesFilled_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function RectanglesGradient {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
       # Randomize All 4 Points of the Rectangle
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = (Get-Random -minimum 0 -maximum ([int]$global:imageHeight*.25))
        # Setup Brush
        $pointStart = New-Object System.Drawing.Point
        $pointStart.X = $pointX
        $pointStart.Y = $pointY
        $pointStop = New-Object System.Drawing.Point
        $pointStop.X = $pointX + $width
        $pointStop.Y = $pointY + $height
        $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($pointStart, $pointStop,  `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))
 
        # Draw the Rectangle
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "RectanglesGradient_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function RectanglesHatch {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Select Hatch Style
    $maxHatchStyle = 53
    $hatchStyle = @()
    For ($i = [Convert]::ToInt32([Drawing.Drawing2D.HatchStyle]::Min); $i -lt $maxHatchStyle; $i++) {
        $hatchStyle += ([Drawing.Drawing2D.HatchStyle] $i)
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
        # Setup Brush
        $brush = New-Object System.Drawing.Drawing2D.HatchBrush( `
        [System.Drawing.Drawing2D.HatchStyle] $hatchStyle[(Get-Random -minimum 0 -maximum 52)], `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))

       # Randomize All 4 Points of the Rectangle
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = (Get-Random -minimum 0 -maximum ([int]$global:imageHeight*.25))
        # Draw the Rectangle
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "RectanglesHatch_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Squares {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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
        # Randomize Points of the Squares
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = $width
        # Draw the Rectangle
        $bitmapGraphics.DrawRectangle($pen, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Squares_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function SquaresFilled {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
        # Setup Brush
        $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $brush = New-Object System.Drawing.SolidBrush $brushColor
        # Randomize All 4 Points of the Squares
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = $width
        # Draw the Rectangle
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "SquaresFilled_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function SquaresGradient {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Main Loop
    $i = 0
    While ($i -le $global:numberObjects) { $i++
        # Get Random Color if Selected
        If ($colorsComboBox.Text -eq "MultiColored") {
            $red   = (Get-Random -minimum 0 -maximum 255)
            $green = (Get-Random -minimum 0 -maximum 255)
            $blue  = (Get-Random -minimum 0 -maximum 255)
        }
       # Randomize All 4 Points of the Squarese
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = $width
        # Setup Brush
        $pointStart = New-Object System.Drawing.Point
        $pointStart.X = $pointX
        $pointStart.Y = $pointY
        $pointStop = New-Object System.Drawing.Point
        $pointStop.X = $pointX + $width
        $pointStop.Y = $pointY + $height
        $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($pointStart, $pointStop,  `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))
 
        # Draw the Rectangle
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "SquaresGradient_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function SquaresHatch {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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

    # Select Hatch Style
    $maxHatchStyle = 53
    $hatchStyle = @()
    For ($i = [Convert]::ToInt32([Drawing.Drawing2D.HatchStyle]::Min); $i -lt $maxHatchStyle; $i++) {
        $hatchStyle += ([Drawing.Drawing2D.HatchStyle] $i)
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
        # Setup Brush
        $brush = New-Object System.Drawing.Drawing2D.HatchBrush( `
        [System.Drawing.Drawing2D.HatchStyle] $hatchStyle[(Get-Random -minimum 0 -maximum 52)], `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)), `
        [System.Drawing.Color]::FromArgb((Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255),(Get-Random -minimum 0 -maximum 255)))

       # Randomize All 4 Points of the Squares
        $pointX = (Get-Random -minimum (-[int]$global:imageWidth) -maximum ([int]$global:imageWidth*2))
        $pointY = (Get-Random -minimum (-[int]$global:imageHeight) -maximum ([int]$global:imageHeight*2))
        $width =  (Get-Random -minimum 0 -maximum ([int]$global:imageWidth*.25))
        $height = $width
        # Draw the Rectangle
        $bitmapGraphics.FillRectangle($brush, $pointX, $pointY, $width, $height)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "SquaresHatch_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}


Function Stars {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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
        # Randomize Position and Define the Stars Points
        $x = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $y = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $width = (Get-Random -minimum 0 -maximum 100)
        $height = $width
        $ax = [int](($width/2) + $x)
        $ay = [int]$y
        $bx = [int]($width+$x)
        $by = [int](.374*[double]($height)+[double]($y))
        $cx = [int](.825*[double]($width)+[double]($x))
        $cy = [int]($height+$y)
        $dx = [int](.175*[double]($height)+[double]($x))
        $dy = [int]($height+$y)
        $ex = [int]$x
        $ey = [int]$by
        # Draw the Star
        $bitmapGraphics.DrawLine($pen, $ax, $ay, $cx, $cy)
        $bitmapGraphics.DrawLine($pen, $bx, $by, $dx, $dy)
        $bitmapGraphics.DrawLine($pen, $cx, $cy, $ex, $ey)
        $bitmapGraphics.DrawLine($pen, $dx, $dy, $ax, $ay)
        $bitmapGraphics.DrawLine($pen, $ex, $ey, $bx, $by)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Stars_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

Function Triangles {
    # Default Random Color
    $red   = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue  = (Get-Random -minimum 0 -maximum 255)
    # Create Image
    $bitmap = New-Object System.Drawing.Bitmap([int]$global:imageWidth, [int]$global:imageHeight)
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
        # Randomize Position and Define the Triangle Points
        $startX = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $startY = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $secondX = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $secondY = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $thirdX = (Get-Random -minimum 0 -maximum $global:imageWidth)
        $thirdY = (Get-Random -minimum 0 -maximum $global:imageHeight)
        $saveX = $startX
        $saveY = $startY
        # Draw the Triangle
        $bitmapGraphics.DrawLine($pen, $startX, $startY, $secondX, $secondY)
        $bitmapGraphics.DrawLine($pen, $secondX, $secondY, $thirdX, $thirdY)
        $bitmapGraphics.DrawLine($pen, $thirdX, $thirdY, $saveX, $saveY)
    }

    # Save Image to File and Display
    $outFile = $scriptPath + "\"  + "Triangles_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile

    # Dispose of the image
    $bitmap.Dispose()
}

$mainForm.ShowDialog()| Out-Null