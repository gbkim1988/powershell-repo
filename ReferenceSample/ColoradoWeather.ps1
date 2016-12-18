##################################################################
# ColoradoWeather.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 10-4-13
# PowerShell GUI Looks up Colorado Weather Info Using Web Services
##################################################################
Add-Type -AssemblyName System.Windows.Forms

Function WeatherLookup {
    $weather = New-WebServiceProxy -uri "http://www.webservicex.net/globalweather.asmx?WSDL"
    for ($i=0; $i -lt $locations.Count; $i++) {
        $weatherXML = [xml]$weather.GetWeather($locations.Item($i) , "United States")
        $selection  = $weatherXML.CurrentWeather | Select Location, Wind, Visibility, `
            SkyConditions, Temperature, DewPoint, RelativeHumidity, Pressure
        $wind = Out-String -InputObject $selection.Wind 
        $dataGridViewOutput.Rows.Add($locations.Item($i), `
            $wind, $selection.Visibility, $selection.SkyConditions, `
            $selection.Temperature, $selection.DewPoint, `
            $selection.RelativeHumidity, $selection.Pressure)
    } 
}

$locations = @(
    ("Air Force Academy")
    ("Akron, Akron-Washington County Airport")
    ("Alamosa, San Luis Valley Regional Airport")
    ("Aspen-Pitkin County Airport")
    ("Buckley Air National Guard Base / Denver")
    ("Colorado Springs, City Of Colorado Springs Municipal Airport")
    ("Cortez, Cortez-Montezuma County Airport")
    ("Craig, Craig-Moffat Airport")
    ("Denver, Centennial Airport")
    ("Denver, Denver International Airport")
    ("Durango, Durango-La Plata County Airport")
    ("Eagle County Regional")
    ("Fort Carson")
    ("Fort Collins Automatic Weather Observing / Reporting System")
    ("Glenwood Automatic Surface Observing System")
    ("Greeley / Weld Automatic Weather Observing / Reporting System")
    ("Grand Junction, Walker Field")
    ("Gunnison Automatic Weather Observing / Reporting System")
    ("Hayden / Yampa Automatic Weather Observing / Reporting System")
    ("Limon, Limon Municipal Airport")
    ("Montrose, Montrose Regional Airport")
    ("Pueblo, Pueblo Memorial Airport")
    ("Rifle, Garfield County Regional Airport")
    ("Steamboat Springs")
    ("Telluride Regional")
    ("Trinidad / Animas Co.")
)

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " Colorado Weather"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkBlue"
$mainForm.Width = 1200
$mainForm.Height = 520

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Font = "Comic Sans MS,14"
$titleLabel.Location = "45,10"
$titleLabel.Height = 30
$titleLabel.Width = 400
$titleLabel.Text = "Colorado Weather Info from 25 Airports"
$mainForm.Controls.Add($titleLabel)

# DataGrid Output
$dataGridViewOutput = New-Object System.Windows.Forms.DataGridView 
$dataGridViewOutput.Location = "45,50"
$dataGridViewOutput.Height = 400
$dataGridViewOutput.Width = 1100
$dataGridViewOutput.Font = "Comic Sans MS,8.25"
$dataGridViewOutput.ForeColor = "DarkBlue"
$dataGridViewOutput.BackColor = "White"
$dataGridViewOutput.GridColor = "Black"
$dataGridViewOutput.ColumnHeadersVisible = $true
$dataGridViewOutput.RowHeadersVisible = $false
$dataGridViewOutput.AllowUserToAddRows = $false
$dataGridViewOutput.ColumnCount = 8
$dataGridViewOutput.Columns[0].Name = "Colorado Airport"
$dataGridViewOutput.Columns[1].Name = "Wind Direction and Speed"
$dataGridViewOutput.Columns[2].Name = "Visibility"
$dataGridViewOutput.Columns[3].Name = "Sky Conditions"
$dataGridViewOutput.Columns[4].Name = "Temperature"
$dataGridViewOutput.Columns[5].Name = "Dew Point"
$dataGridViewOutput.Columns[6].Name = "Relative Humidity"
$dataGridViewOutput.Columns[7].Name = "Pressure"
$dataGridViewOutput.Columns[0].width = 290
$dataGridViewOutput.Columns[1].width = 230
$dataGridViewOutput.Columns[2].width = 80
$dataGridViewOutput.Columns[3].width = 100
$dataGridViewOutput.Columns[4].width = 100
$dataGridViewOutput.Columns[5].width = 100
$dataGridViewOutput.Columns[6].width = 110
$dataGridViewOutput.Columns[7].width = 70
$mainForm.Controls.Add($dataGridViewOutput) 

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$mainForm.Font = "Comic Sans MS,10"
$exitButton.Location = "1070,10"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

WeatherLookup

[void] $mainForm.ShowDialog()
 

# Output XML
#<?xml version="1.0" encoding="utf-16"?>
#<CurrentWeather>
#  <Location>DENVER CENTENNIAL AIRPORT, CO, United States (KAPA) 39-34N 104-51W 1775M</Location>
#  <Time>Oct 04, 2013 - 06:53 PM EDT / 2013.10.04 2253 UTC</Time>
#  <Wind> from the N (360 degrees) at 14 MPH (12 KT):0</Wind>
#  <Visibility> 10 mile(s):0</Visibility>
#  <SkyConditions> overcast</SkyConditions>
#  <Temperature> 37.9 F (3.3 C)</Temperature>
#  <DewPoint> 26.1 F (-3.3 C)</DewPoint>
#  <RelativeHumidity> 61%</RelativeHumidity>
#  <Pressure> 30.15 in. Hg (1020 hPa)</Pressure>
#  <Status>Success</Status>
#</CurrentWeather>