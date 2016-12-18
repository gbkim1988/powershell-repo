########################################################
# GeoIP.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 9-23-13
# PowerShell GUI Lookup Country by IP Using Web Services
#
# Example 0f Successful Return from WebService -
# ReturnCode        : 1
# IP                : 25.199.80.1
# ReturnCodeDetails : Success
# CountryName       : United Kingdom
# CountryCode       : GBR
#
# Sending Bad IP Returns -
# ReturnCode        : 0
# IP                : 25199.80.1
# ReturnCodeDetails : Invalid IP address
# CountryName       : 
# CountryCode       : 
########################################################
Add-Type -AssemblyName System.Windows.Forms

Function GeoIPLookup {
    $outputTextBox.Text = " "
    $mainForm.Refresh()
	$error.clear()
    $GeoIP = New-WebServiceProxy -uri "http://www.webservicex.net/geoipservice.asmx?WSDL"
    $GeoIPArray = $GeoIP.GetGeoIP($inputTextBox.Text)
    If ($GeoIPArray.ReturnCode -eq "1") {
        $outputTextBox.Text = $GeoIPArray.CountryName
    } 
    Else {
        $outputTextBox.Text = $GeoIPArray.ReturnCodeDetails
    }
    If($error.count -gt 0) {
        $outputTextBox.Text = "Bad Lookup"
    }
}

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.AcceptButton = $lookupButton
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " GeoIP - Country Lookup by IP"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkGray"
$mainForm.Width = 600
$mainForm.Height = 90

# Input TextBox
$inputTextBox = New-Object System.Windows.Forms.TextBox
$inputTextBox.Location = "45,10"
$inputTextBox.Size = "150,20"
$inputTextBox.ForeColor = "MediumBlue"
$inputTextBox.BackColor = "White"
$inputTextBox.Text = "Enter IP"
$mainForm.Controls.Add($inputTextBox)

# OutputTextBox
$outputTextBox = New-Object System.Windows.Forms.TextBox
$outputTextBox.Location = "200,10"
$outputTextBox.Size = "185,20"
$outputTextBox.ForeColor = "MediumBlue"
$outputTextBox.BackColor = "White"
$mainForm.Controls.Add($outputTextBox)

# Lookup Button
$lookupButton = New-Object System.Windows.Forms.Button 
$lookupButton.Location = "395,10"
$lookupButton.Size = "75,28"
$lookupButton.ForeColor = "DarkBlue"
$lookupButton.BackColor = "White"
$lookupButton.Text = "Lookup"
$lookupButton.add_Click({GeoIPLookup})
$mainForm.Controls.Add($lookupButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "470,10"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

[void] $mainForm.ShowDialog()
