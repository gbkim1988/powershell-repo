#####################################
# SystemSounds.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 6-10-13
# Demo System.Media.SystemSounds Class
######################################
Add-Type -AssemblyName System.Windows.Forms

# Main Form and Objects
$mainForm = New-Object Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,9"
$mainForm.Text = "System Sounds"
$mainForm.size = "300,260"

# Asterisk Sound
$radioButtonAsterisk = New-Object System.Windows.Forms.RadioButton
$radioButtonAsterisk.Location = "30,20"
$radioButtonAsterisk.Text = "Asterisk"
$radioButtonAsterisk.add_Click({
    [System.Media.SystemSounds]::Asterisk.Play()
    })
$mainForm.Controls.Add($radioButtonAsterisk)

# Beep Sound
$radioButtonBeep = New-Object System.Windows.Forms.RadioButton
$radioButtonBeep.Location = "30,60"
$radioButtonBeep.Text = "Beep"
$radioButtonBeep.add_Click({
    [System.Media.SystemSounds]::Beep.Play()
    })
$mainForm.Controls.Add($radioButtonBeep)

# Exclamation Sound
$radioButtonExclamation = New-Object System.Windows.Forms.RadioButton
$radioButtonExclamation.location = "30,100"
$radioButtonExclamation.Text = "Exclamation"
$radioButtonExclamation.add_Click({
    [System.Media.SystemSounds]::Exclamation.Play()
    })
$mainForm.Controls.Add($radioButtonExclamation)

# Hand Sound
$radioButtonHand = New-Object System.Windows.Forms.RadioButton
$radioButtonHand.Location = "30,140"
$radioButtonHand.Text = "Hand"
$radioButtonHand.add_Click({
    [System.Media.SystemSounds]::Hand.Play()
    })
$mainForm.Controls.Add($radioButtonHand)

# Question Sound
$radioButtonQuestion = New-Object System.Windows.Forms.RadioButton
$radioButtonQuestion.Location = "30,180"
$radioButtonQuestion.Text = "Question"
$radioButtonQuestion.add_Click({
    [System.Media.SystemSounds]::Question.Play()
    })
$mainForm.Controls.Add($radioButtonQuestion)

# Display Form
[void] $mainForm.ShowDialog()