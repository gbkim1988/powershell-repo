#########################################################
# CartoonFace.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 3-14-14
# PowerShell Draw Cartoon Face and Write Bitmap to File
#########################################################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main Form
$mainForm = New-Object Windows.Forms.Form
$mainForm.Location = "200,200"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.BackColor = "White"
$mainForm.Font = “Comic Sans MS,8.25"
$mainForm.Text = "Draw Cartoon Face"
$mainForm.size = "520,280"

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:pupilValue = 5
$global:eyebrowValue = 5
$global:noseValue = 5
$global:mouthValue = 8
$global:backgroundText = "Black"

# Pupil TrackBar
$pupilTrackBar = New-Object Windows.Forms.TrackBar
$pupilTrackBar.Location = "140,20"
$pupilTrackBar.Orientation = "Horizontal"
$pupilTrackBar.Width = 350
$pupilTrackBar.Height = 40
$pupilTrackBar.LargeChange = 5
$pupilTrackBar.SmallChange = 1
$pupilTrackBar.TickFrequency = 1
$pupilTrackBar.TickStyle = "TopLeft"
$pupilTrackBar.SetRange(1, 8)
$pupilTrackBar.Value = 3
$pupilTrackBarValue = 3
$pupilTrackBar.add_ValueChanged({
    $pupilTrackBarValue = $pupilTrackBar.Value
    $pupilTrackBarLabel.Text = "Pupil Size ($pupilTrackBarValue)"
    $global:pupilValue = $pupilTrackBarValue
})
$mainForm.Controls.add($pupilTrackBar)

# Pupil Labels
$pupilTrackBarLabel = New-Object System.Windows.Forms.Label 
$pupilTrackBarLabel.Location = "20,20"
$pupilTrackBarLabel.Size = "100,23"
$pupilTrackBarLabel.ForeColor = "MediumBlue"
$pupilTrackBarLabel.Text = "Pupil Size ($pupilTrackBarValue)"
$mainForm.Controls.Add($pupilTrackBarLabel)
$pupilTrackBarPlus = New-Object System.Windows.Forms.Label 
$pupilTrackBarPlus.Location = "490,20"
$pupilTrackBarPlus.Size = "15,23"
$pupilTrackBarPlus.ForeColor = "Red"
$pupilTrackBarPlus.Text = " +"
$mainForm.Controls.Add($pupilTrackBarPlus)
$pupilTrackBarMinus = New-Object System.Windows.Forms.Label 
$pupilTrackBarMinus.Location = "130,20"
$pupilTrackBarMinus.Size = "15,23"
$pupilTrackBarMinus.ForeColor = "Red"
$pupilTrackBarMinus.Text = "- "
$mainForm.Controls.Add($pupilTrackBarMinus)

# Eyebrow TrackBar
$eyebrowTrackBar = New-Object Windows.Forms.TrackBar
$eyebrowTrackBar.Location = "140,60"
$eyebrowTrackBar.Orientation = "Horizontal"
$eyebrowTrackBar.Width = 350
$eyebrowTrackBar.Height = 40
$eyebrowTrackBar.LargeChange = 5
$eyebrowTrackBar.SmallChange = 1
$eyebrowTrackBar.TickFrequency = 1
$eyebrowTrackBar.TickStyle = "TopLeft"
$eyebrowTrackBar.SetRange(1, 12)
$eyebrowTrackBar.Value = 3
$eyebrowTrackBarValue = 3
$eyebrowTrackBar.add_ValueChanged({
    $eyebrowTrackBarValue = $eyebrowTrackBar.Value
    $eyebrowTrackBarLabel.Text = "Eyebrow Raise ($eyebrowTrackBarValue)"
    $global:eyebrowValue = $eyebrowTrackBarValue
})
$mainForm.Controls.add($eyebrowTrackBar)

# Eyebrow Label
$eyebrowTrackBarLabel = New-Object System.Windows.Forms.Label 
$eyebrowTrackBarLabel.Location = "20,60"
$eyebrowTrackBarLabel.Size = "100,23"
$eyebrowTrackBarLabel.ForeColor = "MediumBlue"
$eyebrowTrackBarLabel.Text = "Eyebrow Raise ($eyebrowTrackBarValue)"
$mainForm.Controls.Add($eyebrowTrackBarLabel)
$eyebrowTrackBarPlus = New-Object System.Windows.Forms.Label 
$eyebrowTrackBarPlus.Location = "490,60"
$eyebrowTrackBarPlus.Size = "15,23"
$eyebrowTrackBarPlus.ForeColor = "Red"
$eyebrowTrackBarPlus.Text = " +"
$mainForm.Controls.Add($eyebrowTrackBarPlus)
$eyebrowTrackBarMinus = New-Object System.Windows.Forms.Label 
$eyebrowTrackBarMinus.Location = "130,60"
$eyebrowTrackBarMinus.Size = "15,23"
$eyebrowTrackBarMinus.ForeColor = "Red"
$eyebrowTrackBarMinus.Text = "- "
$mainForm.Controls.Add($eyebrowTrackBarMinus)

# Nose TrackBar
$noseTrackBar = New-Object Windows.Forms.TrackBar
$noseTrackBar.Location = "140,100"
$noseTrackBar.Orientation = "Horizontal"
$noseTrackBar.Width = 350
$noseTrackBar.Height = 40
$noseTrackBar.LargeChange = 5
$noseTrackBar.SmallChange = 1
$noseTrackBar.TickFrequency = 1
$noseTrackBar.TickStyle = "TopLeft"
$noseTrackBar.SetRange(1, 9)
$noseTrackBar.Value = 4
$noseTrackBarValue = 4
$noseTrackBar.add_ValueChanged({
    $noseTrackBarValue = $noseTrackBar.Value
    $noseTrackBarLabel.Text = "Nose Size ($noseTrackBarValue)"
    $global:noseValue = $noseTrackBarValue
})
$mainForm.Controls.add($noseTrackBar)

# Nose Label
$noseTrackBarLabel = New-Object System.Windows.Forms.Label 
$noseTrackBarLabel.Location = "20,100"
$noseTrackBarLabel.Size = "100,23"
$noseTrackBarLabel.ForeColor = "MediumBlue"
$noseTrackBarLabel.Text = "Nose Size ($noseTrackBarValue)"
$mainForm.Controls.Add($noseTrackBarLabel)
$noseTrackBarPlus = New-Object System.Windows.Forms.Label 
$noseTrackBarPlus.Location = "490,100"
$noseTrackBarPlus.Size = "15,23"
$noseTrackBarPlus.ForeColor = "Red"
$noseTrackBarPlus.Text = " +"
$mainForm.Controls.Add($noseTrackBarPlus)
$noseTrackBarMinus = New-Object System.Windows.Forms.Label 
$noseTrackBarMinus.Location = "130,100"
$noseTrackBarMinus.Size = "15,23"
$noseTrackBarMinus.ForeColor = "Red"
$noseTrackBarMinus.Text = "- "
$mainForm.Controls.Add($noseTrackBarMinus)

# Mouth TrackBar
$mouthTrackBar = New-Object Windows.Forms.TrackBar
$mouthTrackBar.Location = "140,140"
$mouthTrackBar.Orientation = "Horizontal"
$mouthTrackBar.Width = 350
$mouthTrackBar.Height = 40
$mouthTrackBar.LargeChange = 5
$mouthTrackBar.SmallChange = 1
$mouthTrackBar.TickFrequency = 1
$mouthTrackBar.TickStyle = "TopLeft"
$mouthTrackBar.SetRange(1, 12)
$mouthTrackBar.Value = 5
$mouthTrackBarValue = 5
$mouthTrackBar.add_ValueChanged({
    $mouthTrackBarValue = $mouthTrackBar.Value
    $mouthTrackBarLabel.Text = "Smile Size ($mouthTrackBarValue)"
    $global:mouthValue = $mouthTrackBarValue
})
$mainForm.Controls.add($mouthTrackBar)

# Mouth Label
$mouthTrackBarLabel = New-Object System.Windows.Forms.Label 
$mouthTrackBarLabel.Location = "20,140"
$mouthTrackBarLabel.Size = "100,23"
$mouthTrackBarLabel.ForeColor = "MediumBlue"
$mouthTrackBarLabel.Text = "Smile Size ($mouthTrackBarValue)"
$mainForm.Controls.Add($mouthTrackBarLabel)
$mouthTrackBarPlus = New-Object System.Windows.Forms.Label 
$mouthTrackBarPlus.Location = "490,140"
$mouthTrackBarPlus.Size = "15,23"
$mouthTrackBarPlus.ForeColor = "Red"
$mouthTrackBarPlus.Text = " +"
$mainForm.Controls.Add($mouthTrackBarPlus)
$mouthTrackBarMinus = New-Object System.Windows.Forms.Label 
$mouthTrackBarMinus.Location = "130,140"
$mouthTrackBarMinus.Size = "15,23"
$mouthTrackBarMinus.ForeColor = "Red"
$mouthTrackBarMinus.Text = "- "
$mainForm.Controls.Add($mouthTrackBarMinus)

# Background ComboBox
$backgroundComboBox = New-Object System.Windows.Forms.ComboBox
$backgroundComboBox.Location = "145,200"
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
$backgroundComboBoxLabel.Location = "20,200"
$backgroundComboBoxLabel.Size = "100,23"
$backgroundComboBoxLabel.ForeColor = "MediumBlue"
$backgroundComboBoxLabel.Text = "Background Color"
$mainForm.Controls.Add($backgroundComboBoxLabel)

# Draw Button
$drawButton = New-Object System.Windows.Forms.Button 
$drawButton.Location = "320,200"
$drawButton.Size = "75,23"
$drawButton.ForeColor = "SeaGreen"
$drawButton.BackColor = "White"
$drawButton.Text = "Draw"
$drawButton.add_Click({DrawIt})
$mainForm.Controls.Add($drawButton)

# Exit Button
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "405,200"
$exitButton.Size = "75,23"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

# Draw the Object
Function DrawIt {
$bitmap = New-Object System.Drawing.Bitmap(1024, 768)
$bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap) 
$pen = New-Object Drawing.Pen "white"
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

Function DrawHead {
    $red = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue = (Get-Random -minimum 0 -maximum 255)
    $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $brush = New-Object System.Drawing.SolidBrush $brushColor
    $x = 1024/10
    $y = 768/10
    $width = 1024 - (1024/4)
    $height = 768 - (768/7)
    $bitmapGraphics.FillEllipse($brush, $x, $y, $width, $height)
}

Function DrawEyes {
    $red = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue = (Get-Random -minimum 0 -maximum 255)
    $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $brush = New-Object System.Drawing.SolidBrush $brushColor
    $x1 = 1024/3.2
    $x2 = 1024/1.8
    $y = 768/3
    $width = 1024/10
    $height = 768/10
    $bitmapGraphics.FillEllipse($brush, $x1, $y, $width, $height)
    $bitmapGraphics.FillEllipse($brush, $x2, $y, $width, $height)
}

Function DrawPupil {
    If ([int]$global:pupilValue -eq 1) {$value = 90}
    If ([int]$global:pupilValue -eq 2) {$value = 80}
    If ([int]$global:pupilValue -eq 3) {$value = 70}
    If ([int]$global:pupilValue -eq 4) {$value = 60}
    If ([int]$global:pupilValue -eq 5) {$value = 50}
    If ([int]$global:pupilValue -eq 6) {$value = 40}
    If ([int]$global:pupilValue -eq 7) {$value = 30}
    If ([int]$global:pupilValue -eq 8) {$value = 20}
    $red = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue = (Get-Random -minimum 0 -maximum 255)
    $brushColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $brush = New-Object System.Drawing.SolidBrush $brushColor
    $x1 = 1024/2.9
    $x2 = 1024/1.7
    $y = 768/2.7
    $width = 1024/$value
    $height = 768/$value
    $bitmapGraphics.FillEllipse($brush, $x1, $y, $width, $height)
    $bitmapGraphics.FillEllipse($brush, $x2, $y, $width, $height)
}

Function DrawEyebrow {
    If ([int]$global:eyebrowValue -eq 1)  {$value = 3.2}
    If ([int]$global:eyebrowValue -eq 2)  {$value = 3.3}
    If ([int]$global:eyebrowValue -eq 3)  {$value = 3.4}
    If ([int]$global:eyebrowValue -eq 4)  {$value = 3.5}
    If ([int]$global:eyebrowValue -eq 5)  {$value = 3.6}
    If ([int]$global:eyebrowValue -eq 6)  {$value = 3.7}
    If ([int]$global:eyebrowValue -eq 7)  {$value = 3.8}
    If ([int]$global:eyebrowValue -eq 8)  {$value = 3.9}
    If ([int]$global:eyebrowValue -eq 9)  {$value = 4.0}
    If ([int]$global:eyebrowValue -eq 10) {$value = 4.2}
    If ([int]$global:eyebrowValue -eq 11) {$value = 4.4}
    If ([int]$global:eyebrowValue -eq 12) {$value = 4.6}
    $red = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue = (Get-Random -minimum 0 -maximum 255)
    $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $pen = New-Object Drawing.Pen $penColor
    $pen.Width = 8
    $x1 = 1024/2.4
    $y1 = 768/$value
    $newX1 = 1024/3.8
    $newY1 = 768/3.1
    $bitmapGraphics.DrawLine($pen, $x1, $y1, $newX1, $newY1)
    $x2 = 1024/1.4
    $y2 = 768/3.1
    $newX2 = 1024/1.8
    $newY2 = 768/$value
    $bitmapGraphics.DrawLine($pen, $x2, $y2, $newX2, $newY2)
}

Function DrawNose {
    If ([int]$global:noseValue -eq 1)  {$value = 1.9}
    If ([int]$global:noseValue -eq 2)  {$value = 1.85}
    If ([int]$global:noseValue -eq 3)  {$value = 1.8}
    If ([int]$global:noseValue -eq 4)  {$value = 1.75}
    If ([int]$global:noseValue -eq 5)  {$value = 1.7}
    If ([int]$global:noseValue -eq 6)  {$value = 1.65}
    If ([int]$global:noseValue -eq 7)  {$value = 1.6}
    If ([int]$global:noseValue -eq 8)  {$value = 1.55}
    If ([int]$global:noseValue -eq 9)  {$value = 1.5}
    $red = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue = (Get-Random -minimum 0 -maximum 255)
    $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $pen = New-Object Drawing.Pen $penColor
    $pen.Width = 6
    $nose = @()
    $x1 = 1024/2.1
    $y1 = 768/2.3
    $x2 = 1024/$value
    $y2 = 768/1.6
    $x3 = 1024/2.2
    $y3 = 768/1.5
    $noseNext = New-Object System.Drawing.Point($x1, $y1)
    $nose += $noseNext
    $noseNext = New-Object System.Drawing.Point($x2, $y2)
    $nose += $noseNext
    $noseNext = New-Object System.Drawing.Point($x3, $y3)
    $nose += $noseNext
    $bitmapGraphics.DrawCurve($pen, $nose)
}

Function DrawMouth {
    If ([int]$global:mouthValue -eq 1)   {$value = 1.42}
    If ([int]$global:mouthValue -eq 2)   {$value = 1.40}
    If ([int]$global:mouthValue -eq 3)   {$value = 1.38}
    If ([int]$global:mouthValue -eq 4)   {$value = 1.36}
    If ([int]$global:mouthValue -eq 5)   {$value = 1.34}
    If ([int]$global:mouthValue -eq 6)   {$value = 1.32}
    If ([int]$global:mouthValue -eq 7)   {$value = 1.30}
    If ([int]$global:mouthValue -eq 8)   {$value = 1.28}
    If ([int]$global:mouthValue -eq 9)   {$value = 1.26}
    If ([int]$global:mouthValue -eq 10)  {$value = 1.24}
    If ([int]$global:mouthValue -eq 11)  {$value = 1.22}
    If ([int]$global:mouthValue -eq 12)  {$value = 1.20}
    $red = (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue = (Get-Random -minimum 0 -maximum 255)
    $penColor = [System.Drawing.Color]::FromArgb($red, $green, $blue)
    $pen = New-Object Drawing.Pen $penColor
    $pen.Width = 8
    $curve = @()
    $x1 = 1024/3.4
    $y1 = 768/1.45
    $x2 = 1024/2
    $y2 = 768/$value
    $x3 = 1024/1.45
    $y3 = 768/1.5
    $CurveNext = New-Object System.Drawing.Point($x1, $y1)
    $curve += $curveNext
    $CurveNext = New-Object System.Drawing.Point($x2, $y2)
    $curve += $curveNext
    $CurveNext = New-Object System.Drawing.Point($x3, $y3)
    $curve += $curveNext
    $bitmapGraphics.DrawCurve($pen, $Curve)
}
DrawHead
DrawEyes
DrawPupil
DrawEyebrow
DrawNose
DrawMouth

$outFile = $scriptPath + "\"  + "CartoonFace_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
$bitmap.Save($outFile)
Invoke-Item $outFile

}

$mainForm.ShowDialog()| Out-Null