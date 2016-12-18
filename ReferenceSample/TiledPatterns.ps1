#########################################################
# TiledPatterns.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 11-16-13
# PowerShell Draw Tiled Patterns and Write Bitmap to File
#########################################################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main Form
$mainForm = New-Object Windows.Forms.Form
$mainForm.BackColor = "White"
$mainForm.Font = “Comic Sans MS,8.25"
$mainForm.Text = "Tiled Pattern"
$mainForm.size = "500,350"

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:alphaValue = 2
$global:beta1Value = 4
$global:beta2Value = 4
$global:gammaValue = 134
$global:modulusValue = 2

# Alpha TrackBar
$alphaTrackBar = New-Object Windows.Forms.TrackBar
$alphaTrackBar.Location = "100,20"
$alphaTrackBar.Orientation = "Horizontal"
$alphaTrackBar.Width = 350
$alphaTrackBar.Height = 40
$alphaTrackBar.LargeChange = 5
$alphaTrackBar.SmallChange = 1
$alphaTrackBar.TickFrequency = 1
$alphaTrackBar.TickStyle = "TopLeft"
$alphaTrackBar.SetRange(1, 10)
$alphaTrackBar.Value = 4
$alphaTrackBarValue = 4
#Alpha TrackBar Event Handler
$alphaTrackBar.add_ValueChanged({
    $alphaTrackBarValue = $alphaTrackBar.Value
    $alphaLabel.Text = "Alpha ($alphaTrackBarValue)"
    $global:alphaValue = $alphaTrackBarValue
})
$mainForm.Controls.add($alphaTrackBar)

# Alpha Label
$alphaLabel = New-Object System.Windows.Forms.Label 
$alphaLabel.Location = "10,20"
$alphaLabel.Size = "120,23"
$alphaLabel.Text = "Alpha ($alphaTrackBarValue)"
$mainForm.Controls.Add($alphaLabel)

# Beta1 TrackBar
$beta1TrackBar = New-Object Windows.Forms.TrackBar
$beta1TrackBar.Location = "100,70"
$beta1TrackBar.Orientation = "Horizontal"
$beta1TrackBar.Width = 350
$beta1TrackBar.Height = 40
$beta1TrackBar.LargeChange = 10
$beta1TrackBar.SmallChange = 2
$beta1TrackBar.TickFrequency = 1
$beta1TrackBar.TickStyle = "TopLeft"
$beta1TrackBar.SetRange(1, 20)
$beta1TrackBar.Value = 12
$beta1TrackBarValue = 12
#Beta1 TrackBar Event Handler
$beta1TrackBar.add_ValueChanged({
    $beta1TrackBarValue = $beta1TrackBar.Value
    $beta1Label.Text = "Beta1 ($beta1TrackBarValue)"
    $global:beta1Value = $beta1TrackBarValue
})
$mainForm.Controls.add($beta1TrackBar)
# Beta1 Label
$beta1Label = New-Object System.Windows.Forms.Label 
$beta1Label.Location = "10,70"
$beta1Label.Size = "120,23"
$beta1Label.Text = "Beta1 ($beta1TrackBarValue)"
$mainForm.Controls.Add($beta1Label)

# Beta2 TrackBar
$beta2TrackBar = New-Object Windows.Forms.TrackBar
$beta2TrackBar.Location = "100,120"
$beta2TrackBar.Orientation = "Horizontal"
$beta2TrackBar.Width = 350
$beta2TrackBar.Height = 40
$beta2TrackBar.LargeChange = 10
$beta2TrackBar.SmallChange = 2
$beta2TrackBar.TickFrequency = 1
$beta2TrackBar.TickStyle = "TopLeft"
$beta2TrackBar.SetRange(1, 20)
$beta2TrackBar.Value = 8
$beta2TrackBarValue = 8
#Beta2 TrackBar Event Handler
$beta2TrackBar.add_ValueChanged({
    $beta2TrackBarValue = $beta2TrackBar.Value
    $beta2Label.Text = "Beta2 ($beta2TrackBarValue)"
    $global:beta2Value = $beta2TrackBarValue
})
$mainForm.Controls.add($beta2TrackBar)

# Beta2 Label
$beta2Label = New-Object System.Windows.Forms.Label 
$beta2Label.Location = "10,120"
$beta2Label.Size = "120,23"
$beta2Label.Text = "Beta2 ($beta2TrackBarValue)"
$mainForm.Controls.Add($beta2Label)

# Gamma TrackBar
$gammaTrackBar = New-Object Windows.Forms.TrackBar
$gammaTrackBar.Location = "100,170"
$gammaTrackBar.Orientation = "Horizontal"
$gammaTrackBar.Width = 350
$gammaTrackBar.Height = 40
$gammaTrackBar.LargeChange = 50
$gammaTrackBar.SmallChange = 10
$gammaTrackBar.TickFrequency = 10
$gammaTrackBar.TickStyle = "TopLeft"
$gammaTrackBar.SetRange(100, 300)
$gammaTrackBar.Value = 220
$gammaTrackBarValue = 220
#Gamma TrackBar Event Handler
$gammaTrackBar.add_ValueChanged({
    $gammaTrackBarValue = $gammaTrackBar.Value
    $gammaLabel.Text = "Gamma ($gammaTrackBarValue)"
    $global:gammaValue = $gammaTrackBarValue
})
$mainForm.Controls.add($gammaTrackBar)

# Gamma Label
$gammaLabel = New-Object System.Windows.Forms.Label 
$gammaLabel.Location = "10,170"
$gammaLabel.Size = "120,23"
$gammaLabel.Text = "Gamma ($gammaTrackBarValue)"
$mainForm.Controls.Add($gammaLabel)

# modulus TrackBar
$modulusTrackBar = New-Object Windows.Forms.TrackBar
$modulusTrackBar.Location = "100,220"
$modulusTrackBar.Orientation = "Horizontal"
$modulusTrackBar.Width = 350
$modulusTrackBar.Height = 40
$modulusTrackBar.LargeChange = 1
$modulusTrackBar.SmallChange = 1
$modulusTrackBar.TickFrequency = 1
$modulusTrackBar.TickStyle = "TopLeft"
$modulusTrackBar.SetRange(2, 3)
$modulusTrackBar.Value = 2
$modulusTrackBarValue = 2
#modulus TrackBar Event Handler
$modulusTrackBar.add_ValueChanged({
    $modulusTrackBarValue = $modulusTrackBar.Value
    $modulusLabel.Text = "Modulus ($modulusTrackBarValue)"
    $global:modulusValue = $modulusTrackBarValue
})
$mainForm.Controls.add($modulusTrackBar)

# modulus Label
$modulusLabel = New-Object System.Windows.Forms.Label 
$modulusLabel.Location = "10,220"
$modulusLabel.Size = "120,23"
$modulusLabel.Text = "Modulus ($modulusTrackBarValue)"
$mainForm.Controls.Add($modulusLabel)

# Draw Button
$DrawButton = New-Object System.Windows.Forms.Button 
$DrawButton.Location = "160,270"
$DrawButton.Size = "75,23"
$DrawButton.Text = "Draw"
$DrawButton.add_Click({DrawIt})
$mainForm.Controls.Add($DrawButton)

# Exit Button
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "280,270"
$exitButton.Size = "75,23"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

# Draw the Pattern
Function DrawIt {
    Write-Host "Running . . ."

    # Output Bitmap Image
    $bitmap = New-Object System.Drawing.Bitmap(1024, 768)
    $bitmapGraphics = [System.Drawing.Graphics]::FromImage($bitmap) 
    $bitmapGraphics.Clear("black")

    $alpha = $global:alphaValue
    $beta1 = $global:beta1Value
    $beta2 = $global:beta2Value
    $gamma = $global:gammaValue
    $modulus  = $global:modulusValue

    $xPixel = 0; $yPixel = 0
    $percent = 10
    $totalPixels = 1023
    $red =   (Get-Random -minimum 0 -maximum 255)
    $green = (Get-Random -minimum 0 -maximum 255)
    $blue =  (Get-Random -minimum 0 -maximum 255)

    while ($xPixel -le $totalPixels) {
        $xPixel++ ; $yPixel = 1
        if (($xPixel % 100) -eq 0) {
            Write-Host "Processing" $percent"%"
            $percent = $percent + 10
        }
        while ($yPixel -le $totalPixels) { 
            $yPixel++
            if ($xPixel -ge 0) {
                if ($yPixel -ge 0) {
                    if ($xPixel -le 1023) {       
                        if ($yPixel -le 767) { 
                            $x=$beta1+($gamma*$xPixel)
                            $y=$beta2+($gamma*$yPixel)
                            $z=($alpha*([math]::sin($x))+[math]::sin($y))
                            $c=[math]::truncate($z)
                            if ($c % $modulus -eq 0) {
	                            $bitmap.SetPixel($xPixel, $yPixel, [System.Drawing.Color]::FromArgb($red, $green, $blue))
                            }
                        }
                    }
                }
            }
        }
    }

    $outFile = $scriptPath + "\"  + "TiledPatterns_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($outFile)
    Invoke-Item $outFile
    $bitmap.Dispose()
    $bitmapGraphics.Dispose()
    Write-Host "Complete"
}

$mainForm.ShowDialog()| Out-Null