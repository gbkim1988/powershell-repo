#######################################################
# WhoIS.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 9-19-13
# PowerShell GUI WhoIS Lookup Using Web Services
#######################################################
Add-Type -AssemblyName System.Windows.Forms

Function WhoISLookup {
    $error.clear()
    $WhoIS = New-WebServiceProxy -uri "http://www.webservicex.net/whois.asmx?WSDL"
    $WhoISResults = $WhoIS.GetWhoIS($inputTextBox.Text)
    If($error.count -gt 0) {
        $outputTextBox.Text = "Bad Lookup of '" + $inputTextBox.Text + "'"
    }
    Else {
        $outputTextBox.Text = $WhoISResults
    }
}

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " WhoIS Lookup"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "Chocolate"
$mainForm.Width = 600
$mainForm.Height = 600

# Input TextBox
$inputTextBox = New-Object System.Windows.Forms.TextBox
$inputTextBox.Location = "45,8"
$inputTextBox.Size = "300,20"
$inputTextBox.ForeColor = "MediumBlue"
$inputTextBox.BackColor = "White"
$inputTextBox.Text = "Enter Domain Name"
$mainForm.Controls.Add($inputTextBox)

# OutputTextBox
$outputTextBox = New-Object System.Windows.Forms.RichTextBox
$outputTextBox.Location = "45,45"
$outputTextBox.Size = "500,490"
$outputTextBox.ForeColor = "MediumBlue"
$outputTextBox.BackColor = "White"
$outputTextBox.Multiline = $true
$outputTextBox.Scrollbars = "Vertical"
$outputTextBox.Wordwrap = $true
$mainForm.Controls.Add($outputTextBox)

# Lookup Button
$lookupButton = New-Object System.Windows.Forms.Button 
$lookupButton.Location = "395,8"
$lookupButton.Size = "75,28"
$lookupButton.ForeColor = "DarkBlue"
$lookupButton.BackColor = "White"
$lookupButton.Text = "Lookup"
$lookupButton.add_Click({WhoISLookup})
$mainForm.Controls.Add($lookupButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "470,8"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

[void] $mainForm.ShowDialog()