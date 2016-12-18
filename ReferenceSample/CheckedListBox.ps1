###############################################
# CheckedListBox.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 12-28-13
# PowerShell WinForms CheckedListBox Class Demo
###############################################
Add-Type -AssemblyName System.Windows.Forms

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = “Comic Sans MS,8.25"
$mainForm.Text = " CheckedListBox Control Demo"
$mainForm.Width = 400
$mainForm.Height = 340

# Checked ListBox
$listBox = New-Object System.Windows.Forms.CheckedListBox
$listBox.Location = "50,30"
$listBox.CheckOnClick = 1
$listBox.Sorted = 0
$listBox.MultiColumn = 0
$listBox.Width = 300
$listBox.Height = 100
$listBox.Items.Add("Item 1")
$listBox.Items.Add("Item 2")
$listBox.Items.Add("Item 3")
$listBox.Items.Add("Item 4")
$listBox.Items.Add("Item 5")
$mainForm.Controls.Add($listBox)

# Output ListBox
$outBox = New-Object System.Windows.Forms.ListBox
$outBox.Location = "50,180"
$outBox.Sorted = 0
$outBox.MultiColumn = 0
$outBox.Width = 300
$outBox.Height = 100
$mainForm.Controls.Add($outBox)

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = "85,08"
$titleLabel.Height = 22
$titleLabel.Width = 300
$titleLabel.Text = "Select a CheckBox to add to the ListBox"
$mainForm.Controls.Add($titleLabel)

# Select Button 
$selectButton = New-Object System.Windows.Forms.Button 
$selectButton.Location = "50,140"
$selectButton.Height = 23
$selectButton.Width = 75
$selectButton.Text = "Select"
$selectButton.add_Click({DoIt})
$mainForm.Controls.Add($selectButton)

# Exit Button
$exitButton = New-Object System.Windows.Forms.Button 
$exitButton.Location = "276,140"
$exitButton.Height = 23
$exitButton.Width = 75
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

Function DoIt {
    # Clear all items in the Output ListBox
    ForEach ($item in $listBox.Items) {
        $outBox.Items.Clear()
    }
    # Add the currently checked items to the ListBox
    ForEach ($item in $listBox.CheckedItems) {
        $outBox.Items.Add($item)
    }
}

[void] $mainForm.ShowDialog()