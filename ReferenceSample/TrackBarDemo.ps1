#####################################################################
# TrackBarDemo.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 2-22-13
# Demo for WinForms TrackBar Control using System.Console Beep Sounds
#####################################################################

Add-Type -AssemblyName System.Windows.Forms

$global:DurationValue = 300
$global:FrequencyValue = 2000

Function GenerateForm {
    # Main Form and Objects
    $BeepForm = New-Object Windows.Forms.Form
    $FrequencyTrackBar = New-Object Windows.Forms.TrackBar
    $DurationTrackBar = New-Object Windows.Forms.TrackBar
    $FrequencyLabel = New-Object System.Windows.Forms.Label 
    $DurationLabel = New-Object System.Windows.Forms.Label
    $LineLabel = New-Object System.Windows.Forms.Label
    $PlayButton = New-Object System.Windows.Forms.Button 
    $ExitButton = New-Object System.Windows.Forms.Button
    $BeepForm.BackColor = [System.Drawing.Color]::White
    $BeepForm.Font = “Comic Sans MS,8.25"
    $BeepForm.Text = "WinForms TrackBar Demo"
    $BeepForm.size = "500,300"

    # Frequency TrackBar
    $FrequencyTrackBar.Location = "70,20"
    $FrequencyTrackBar.Orientation = "Horizontal"
    $FrequencyTrackBar.Width = 350
    $FrequencyTrackBar.Height = 40
    $FrequencyTrackBar.TickFrequency = 1000
    $FrequencyTrackBar.TickStyle = "TopLeft"
    $FrequencyTrackBar.SetRange(37, 32767)
    $FreqTrackBarValue = 2000
    $FrequencyTrackBar.Value = 2000
    #Frequency TrackBar Event Handler
    $FrequencyTrackBar.add_ValueChanged({
        $FreqTrackBarValue = $FrequencyTrackBar.Value
        $FrequencyLabel.Text = "Frequency ($FreqTrackBarValue)"
        $global:FrequencyValue = $FreqTrackBarValue
    })
    $BeepForm.Controls.add($FrequencyTrackBar)

    # Duration TrackBar
    $DurationTrackBar.Location = "70,150"
    $FrequencyTrackBar.Orientation = "Horizontal"
    $DurationTrackBar.Width = 350
    $DurationTrackBar.Height = 40
    $DurationTrackBar.TickFrequency = 200
    $DurationTrackBar.TickStyle = "BottomRight"
    $DurationTrackBar.SetRange(1, 2000)
    $DurationTrackBarValue = 300
    $DurationTrackBar.Value = 300
    #Duration TrackBar Event Handler
    $DurationTrackBar.add_ValueChanged({ 
    	$DurationTrackBarValue = $DurationTrackBar.Value
        $DurationLabel.Text = "Duration ($DurationTrackBarValue)"
        $global:DurationValue = $DurationTrackBarValue
    })
    $BeepForm.Controls.add($DurationTrackBar)

    # Play Button 
    $PlayButton.Location = "120,220"
    $PlayButton.Size = "75,23"
    $PlayButton.Text = "Play"
    $PlayButton.add_Click({PlayIt})
    $BeepForm.Controls.Add($PlayButton)

    # Exit Button 
    $ExitButton.Location = "300,220"
    $ExitButton.Size = "75,23"
    $ExitButton.Text = "Exit"
    $ExitButton.add_Click({$BeepForm.close()})
    $BeepForm.Controls.Add($ExitButton)

    # Frequency Label
    $FrequencyLabel.Location = "200,75"
    $FrequencyLabel.Size = "120,30"
    $FrequencyLabel.Text = "Frequency ($FreqTrackBarValue)"
    $BeepForm.Controls.Add($FrequencyLabel)

    # Duration Label
    $DurationLabel.Location = "210,120"
    $DurationLabel.Size = "120,23"
    $DurationLabel.Text = "Duration ($DurationTrackBarValue)"
    $BeepForm.Controls.Add($DurationLabel)

    # Line Label
    $LineLabel.Location = "170,95"
    $LineLabel.Size = "150,20"
    $LineLabel.Text = "______________________________________"
    $BeepForm.Controls.Add($LineLabel)
    
    # Play the Tone
    Function PlayIt {
        [System.Console]::Beep($global:FrequencyValue,$global:DurationValue)
    }

    $BeepForm.ShowDialog()| Out-Null
}

GenerateForm