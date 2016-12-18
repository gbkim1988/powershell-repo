###########################################################
# FontDialog.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 7-12-13
# Demo of WinForms FontDialog Class
###########################################################
Add-Type -AssemblyName System.Windows.Forms

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,8.25"
$mainForm.Text = " FontDialog Demo"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkSlateBlue"
$mainForm.Width = 400
$mainForm.Height = 500

# Labels
$fontNameLabel = New-Object System.Windows.Forms.Label
$fontNameLabel.Font = "Comic Sans MS,10"
$fontNameLabel.Location = "20,20"
$fontNameLabel.Size = "120,20"
$fontNameLabel.Text = "Font Family"
$mainForm.Controls.Add($fontNameLabel)
$fontSizeLabel = New-Object System.Windows.Forms.Label
$fontSizeLabel.Font = "Comic Sans MS,10"
$fontSizeLabel.Location = "20,50"
$fontSizeLabel.Size = "120,20"
$fontSizeLabel.Text = "Size"
$mainForm.Controls.Add($fontSizeLabel)
$fontHeightLabel = New-Object System.Windows.Forms.Label
$fontHeightLabel.Font = "Comic Sans MS,10"
$fontHeightLabel.Location = "20,80"
$fontHeightLabel.Size = "120,20"
$fontHeightLabel.Text = "Height"
$mainForm.Controls.Add($fontHeightLabel)
$fontUnitLabel = New-Object System.Windows.Forms.Label
$fontUnitLabel.Font = "Comic Sans MS,10"
$fontUnitLabel.Location = "20,110"
$fontUnitLabel.Size = "120,20"
$fontUnitLabel.Text = "Unit"
$mainForm.Controls.Add($fontUnitLabel)
$fontBoldLabel = New-Object System.Windows.Forms.Label
$fontBoldLabel.Font = "Comic Sans MS,10"
$fontBoldLabel.Location = "20,140"
$fontBoldLabel.Size = "120,20"
$fontBoldLabel.Text = "Bold"
$mainForm.Controls.Add($fontBoldLabel)
$fontItalicLabel = New-Object System.Windows.Forms.Label
$fontItalicLabel.Font = "Comic Sans MS,10"
$fontItalicLabel.Location = "20,170"
$fontItalicLabel.Size = "120,20"
$fontItalicLabel.Text = "Italic"
$mainForm.Controls.Add($fontItalicLabel)
$fontStyleLabel = New-Object System.Windows.Forms.Label
$fontStyleLabel.Font = "Comic Sans MS,10"
$fontStyleLabel.Location = "20,200"
$fontStyleLabel.Size = "120,20"
$fontStyleLabel.Text = "Style"
$mainForm.Controls.Add($fontStyleLabel)
$fontStrikeoutLabel = New-Object System.Windows.Forms.Label
$fontStrikeoutLabel.Font = "Comic Sans MS,10"
$fontStrikeoutLabel.Location = "20,230"
$fontStrikeoutLabel.Size = "120,20"
$fontStrikeoutLabel.Text = "Strikeout"
$mainForm.Controls.Add($fontStrikeoutLabel)
$fontUnderlineLabel = New-Object System.Windows.Forms.Label
$fontUnderlineLabel.Font = "Comic Sans MS,10"
$fontUnderlineLabel.Location = "20,260"
$fontUnderlineLabel.Size = "120,20"
$fontUnderlineLabel.Text = "Underline"
$mainForm.Controls.Add($fontUnderlineLabel)
$fontIsSystemFontLabel = New-Object System.Windows.Forms.Label
$fontIsSystemFontLabel.Font = "Comic Sans MS,10"
$fontIsSystemFontLabel.Location = "20,290"
$fontIsSystemFontLabel.Size = "120,20"
$fontIsSystemFontLabel.Text = "Is System Font"
$mainForm.Controls.Add($fontIsSystemFontLabel)
$fontGdiCharSetLabel = New-Object System.Windows.Forms.Label
$fontGdiCharSetLabel.Font = "Comic Sans MS,10"
$fontGdiCharSetLabel.Location = "20,320"
$fontGdiCharSetLabel.Size = "120,20"
$fontGdiCharSetLabel.Text = "Character Set"
$mainForm.Controls.Add($fontGdiCharSetLabel)
$fontGdiVerticalFontLabel = New-Object System.Windows.Forms.Label
$fontGdiVerticalFontLabel.Font = "Comic Sans MS,10"
$fontGdiVerticalFontLabel.Location = "20,350"
$fontGdiVerticalFontLabel.Size = "120,20"
$fontGdiVerticalFontLabel.Text = "Vertical Font"
$mainForm.Controls.Add($fontGdiVerticalFontLabel)

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Font = "Comic Sans MS,15"
$titleLabel.ForeColor = "Yellow"
$titleLabel.BackColor = "DarkSlateBlue"
$titleLabel.Location = "190,410"
$titleLabel.Size = "200,40"
$titleLabel.Text = "Font Info"
$mainForm.Controls.Add($titleLabel)

# TextBoxes
$fontNameTextBox = New-Object System.Windows.Forms.TextBox
$fontNameTextBox.Location = "140,20"
$fontNameTextBox.Size = "200,20"
$fontNameTextBox.Text = ""
$mainForm.Controls.Add($fontNameTextBox)
$fontSizeTextBox = New-Object System.Windows.Forms.TextBox
$fontSizeTextBox.Location = "140,50"
$fontSizeTextBox.Size = "200,20"
$fontSizeTextBox.Text = ""
$mainForm.Controls.Add($fontSizeTextBox)
$fontHeightTextBox = New-Object System.Windows.Forms.TextBox
$fontHeightTextBox.Location = "140,80"
$fontHeightTextBox.Size = "200,20"
$fontHeightTextBox.Text = ""
$mainForm.Controls.Add($fontHeightTextBox)
$fontUnitTextBox = New-Object System.Windows.Forms.TextBox
$fontUnitTextBox.Location = "140,110"
$fontUnitTextBox.Size = "200,20"
$fontUnitTextBox.Text = ""
$mainForm.Controls.Add($fontUnitTextBox)
$fontBoldTextBox = New-Object System.Windows.Forms.TextBox
$fontBoldTextBox.Location = "140,140"
$fontBoldTextBox.Size = "200,20"
$fontBoldTextBox.Text = ""
$mainForm.Controls.Add($fontBoldTextBox)
$fontItalicTextBox = New-Object System.Windows.Forms.TextBox
$fontItalicTextBox.Location = "140,170"
$fontItalicTextBox.Size = "200,20"
$fontItalicTextBox.Text = ""
$mainForm.Controls.Add($fontItalicTextBox)
$fontStyleTextBox = New-Object System.Windows.Forms.TextBox
$fontStyleTextBox.Location = "140,200"
$fontStyleTextBox.Size = "200,20"
$fontStyleTextBox.Text = ""
$mainForm.Controls.Add($fontStyleTextBox)
$fontStrikeoutTextBox = New-Object System.Windows.Forms.TextBox
$fontStrikeoutTextBox.Location = "140,230"
$fontStrikeoutTextBox.Size = "200,20"
$fontStrikeoutTextBox.Text = ""
$mainForm.Controls.Add($fontStrikeoutTextBox)
$fontUnderlineTextBox = New-Object System.Windows.Forms.TextBox
$fontUnderlineTextBox.Location = "140,260"
$fontUnderlineTextBox.Size = "200,20"
$fontUnderlineTextBox.Text = ""
$mainForm.Controls.Add($fontUnderlineTextBox)
$fontIsSystemFontTextBox = New-Object System.Windows.Forms.TextBox
$fontIsSystemFontTextBox.Location = "140,290"
$fontIsSystemFontTextBox.Size = "200,20"
$fontIsSystemFontTextBox.Text = ""
$mainForm.Controls.Add($fontIsSystemFontTextBox)
$fontGdiCharSetTextBox = New-Object System.Windows.Forms.TextBox
$fontGdiCharSetTextBox.Location = "140,320"
$fontGdiCharSetTextBox.Size = "200,20"
$fontGdiCharSetTextBox.Text = ""
$mainForm.Controls.Add($fontGdiCharSetTextBox)
$fontGdiVerticalFontTextBox = New-Object System.Windows.Forms.TextBox
$fontGdiVerticalFontTextBox.Location = "140,350"
$fontGdiVerticalFontTextBox.Size = "200,20"
$fontGdiVerticalFontTextBox.Text = ""
$mainForm.Controls.Add($fontGdiVerticalFontTextBox)

# Select Button
$fontSelectButton = New-Object System.Windows.Forms.Button
$fontSelectButton.ForeColor = "DarkSlateBlue"
$fontSelectButton.BackColor = "White"
$fontSelectButton.Location = "20, 400"
$fontSelectButton.Size = "75, 23"
$fontSelectButton.Text = "Select Font"
$fontSelectButton.add_Click({
    $fontDialog = New-Object System.Windows.Forms.FontDialog
    [void] $fontDialog.ShowDialog()
    $font = $fontDialog.Font
    $fontNameTextBox.Text = $font.Name
    $fontSizeTextBox.Text = $font.Size
    $fontHeightTextBox.Text = $font.Height
    $fontUnitTextBox.Text = $font.Unit
    $fontBoldTextBox.Text = $font.Bold
    $fontItalicTextBox.Text = $font.Italic
    $fontStyleTextBox.Text = $font.Style
    $fontStrikeoutTextBox.Text = $font.Strikeout
    $fontUnderlineTextBox.Text = $font.Underline
    $fontIsSystemFontTextBox.Text = $font.IsSystemFont
    $fontGdiCharSetTextBox.Text = $font.GDICharSet
    $fontGdiVerticalFontTextBox.Text = $font.GDIVerticalFont
    })
$mainForm.Controls.Add($fontSelectButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "20,430"
$exitButton.Size = "75,23"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

[void] $mainForm.ShowDialog()