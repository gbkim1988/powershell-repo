#########################################################
# DrawStringRandom.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 3-22-14
# PowerShell Use DrawString to Draw Random Characters
# and Write Bitmap to File
#########################################################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main Form
$mainForm = New-Object Windows.Forms.Form
$mainForm.BackColor = "White"
$mainForm.Font = “Comic Sans MS,8.25"
$mainForm.Text = "Draw Random Characters"
$mainForm.size = "580,210"

# Global Values
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$global:numberValue = 1000

# Number of Characters TrackBar
$numberTrackBar = New-Object Windows.Forms.TrackBar
$numberTrackBar.Location = "180,20"
$numberTrackBar.Orientation = "Horizontal"
$numberTrackBar.Width = 350
$numberTrackBar.Height = 40
$numberTrackBar.LargeChange = 500
$numberTrackBar.SmallChange = 10
$numberTrackBar.TickFrequency = 500
$numberTrackBar.TickStyle = "TopLeft"
$numberTrackBar.SetRange(1, 5000)
$numberTrackBar.Value = 1000
$numberTrackBarValue = 1000
$numberTrackBar.add_ValueChanged({
    $numberTrackBarValue = $numberTrackBar.Value
    $numberTrackBarLabel.Text = "Number Characters ($numberTrackBarValue)"
    $global:numberValue = $numberTrackBarValue
})
$mainForm.Controls.add($numberTrackBar)

# Object Number Label
$numberTrackBarLabel = New-Object System.Windows.Forms.Label 
$numberTrackBarLabel.Location = "10,20"
$numberTrackBarLabel.Size = "160,23"
$numberTrackBarLabel.ForeColor = "MediumBlue"
$numberTrackBarLabel.Text = "Number Characters ($numberTrackBarValue)"
$mainForm.Controls.Add($numberTrackBarLabel)

# Type ComboBox
$typeComboBox = New-Object System.Windows.Forms.ComboBox
$typeComboBox.Location = "320,80"
$typeComboBox.Size = "120,20"
$typeComboBox.ForeColor = "Indigo"
$typeComboBox.BackColor = "White"
[void]$typeComboBox.items.add("All Fonts")
[void]$typeComboBox.items.add("Dings Only")        
$typeComboBox.SelectedIndex = 0
$mainForm.Controls.Add($typeComboBox)

# Type ComboBox Label
$typeComboBoxLabel = New-Object System.Windows.Forms.Label 
$typeComboBoxLabel.Location = "200,80"
$typeComboBoxLabel.Size = "100,23"
$typeComboBoxLabel.ForeColor = "MediumBlue"
$typeComboBoxLabel.Text = "Character Type"
$mainForm.Controls.Add($typeComboBoxLabel)

# Background ComboBox
$backgroundComboBox = New-Object System.Windows.Forms.ComboBox
$backgroundComboBox.Location = "320,120"
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
$backgroundComboBoxLabel.Location = "200,120"
$backgroundComboBoxLabel.Size = "100,23"
$backgroundComboBoxLabel.ForeColor = "MediumBlue"
$backgroundComboBoxLabel.Text = "Background Color"
$mainForm.Controls.Add($backgroundComboBoxLabel)

# Draw Button
$drawButton = New-Object System.Windows.Forms.Button 
$drawButton.Location = "40,80"
$drawButton.Size = "75,23"
$drawButton.ForeColor = "SeaGreen"
$drawButton.BackColor = "White"
$drawButton.Text = "Draw"
$drawButton.add_Click({DrawIt})
$mainForm.Controls.Add($drawButton)

# Exit Button
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "40,120"
$exitButton.Size = "75,23"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

# Draw the Object
Function DrawIt {
    $Global:outFile = ""
    # Setup Image
    $bitmap = new-object System.Drawing.Bitmap 1024,768
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
    # Add All Installed Font Names into an Array
    $fontFamilies = @()
    $fontsCollection = New-Object System.Drawing.Text.InstalledFontCollection
    If ($typeComboBox.Text -eq "All Fonts") {
        $fontFamilies = $fontsCollection.Families
    } Else {
        If ($typeComboBox.Text -eq "Dings Only") {
            For($i=0; $i -le $fontsCollection.Families.length-1) {
                If ($fontsCollection.Families[$i].Name -like "Wingdings") {
                    $fontFamilies += $fontsCollection.Families[$i].Name
                }
                If ($fontsCollection.Families[$i].Name -like "Webdings") {
                    $fontFamilies += $fontsCollection.Families[$i].Name
                }
                $i++
            }
        }
    }

    $i = 0
    While ($i -le $global:numberValue) { $i++
        # Randomize Font Name and Size
        $fontSelector = (Get-Random -minimum 0 -maximum $fontFamilies.Length)
        $fontName = $fontFamilies[$fontSelector]
        $size = (Get-Random -minimum 4 -maximum 60)
        Try {
        $font = new-object System.Drawing.Font $fontName,$size
        }
        Catch {
        Write-Host "Unable to load Font -" $fontName
        }
        # Randomize Foreground Color
        $red  = (Get-Random -minimum 1 -maximum 255)
        $green = (Get-Random -minimum 1 -maximum 255)
        $blue  = (Get-Random -minimum 1 -maximum 255)
        $brushColorFg = [System.Drawing.Color]::FromArgb($red, $green, $blue)
        $brushFg = New-Object System.Drawing.SolidBrush $brushColorFg
        # Randomize Position
        $pointX = (Get-Random -minimum -10 -maximum 1034)
        $pointY = (Get-Random -minimum -10 -maximum 778)
        $letter = (Get-Random -minimum 33 -maximum 136)
        # Draw the Letter
        $bitmapGraphics.DrawString(([char]($letter)),$font,$brushFg,$pointX,$pointY)
    }

    # Display Image
    $Global:outFile = $scriptPath + "\"  + "RandomCharacters_" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".bmp"
    $bitmap.Save($Global:outFile)
    Invoke-Item $Global:outFile
    # Cleanup
    $bitmapGraphics.Dispose()  
}

$mainForm.ShowDialog()| Out-Null