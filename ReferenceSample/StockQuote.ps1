####################################################
# StockQuote.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 10-9-13
# PowerShell GUI Gets Stock Quote Using Web Services
####################################################
Add-Type -AssemblyName System.Windows.Forms

Function QuoteLookup {
    $lastTextBox.Text = " "
    $dateTextBox.Text = " "
    $timeTextBox.Text = " "
    $changeTextBox.Text = " "
    $openTextBox.Text = " "
    $highTextBox.Text = " "
    $lowTextBox.Text = " "
    $volumeTextBox.Text = " "
    $mktCapTextBox.Text = " "
    $previousCloseTextBox.Text = " "
    $PercentageChangeTextBox.Text = " "
    $annRangeTextBox.Text = " "
    $earnsTextBox.Text = " "
    $PETextBox.Text = " "
    $nameTextBox.Text = " "
    $mainForm.Refresh()

    $stockQuote = New-WebServiceProxy -uri "http://www.webservicex.net/stockquote.asmx?WSDL"
    $quote = $stockQuote.GetQuote($quoteTextBox.Text)
    $quoteXML = [xml]$quote
    $selection  = $quoteXML.StockQuotes.Stock | Select Last, Date, Time, Change, Open, High, Low, Volume, MktCap, PreviousClose, PercentageChange, AnnRange, Earns, Name
    $PE = $quoteXML.StockQuotes.Stock | Select  -ExpandProperty P-E
    $lastTextBox.Text = $selection.Last
    $dateTextBox.Text = $selection.Date
    $timeTextBox.Text = $selection.Time
    $changeTextBox.Text = $selection.Change
    $openTextBox.Text = $selection.Open
    $highTextBox.Text = $selection.High
    $lowTextBox.Text = $selection.Low
    $volumeTextBox.Text = "{0:N0}" -f [int]$selection.Volume
    $mktCapTextBox.Text = $selection.MktCap
    $previousCloseTextBox.Text = $selection.PreviousClose
    $PercentageChangeTextBox.Text = $selection.PercentageChange
    $annRangeTextBox.Text = $selection.AnnRange
    $earnsTextBox.Text = $selection.Earns
    $PETextBox.Text = $PE
    $nameTextBox.Text = $selection.Name
}

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Location = "200, 200"
$mainForm.Font = "Comic Sans MS,9"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.Text = " Stock Quote"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "SteelBlue"
$mainForm.Width = 460
$mainForm.Height = 550

# Quote Input Label
$quoteInputLabel = New-Object System.Windows.Forms.Label
$quoteInputLabel.Location = "45,10"
$quoteInputLabel.Height = 22
$quoteInputLabel.Width = 110
$quoteInputLabel.Text = "Stock Symbol"
$mainForm.Controls.Add($quoteInputLabel)

# Quote Input TextBox
$quoteTextBox = New-Object System.Windows.Forms.TextBox
$quoteTextBox.Location = "180,10"
$quoteTextBox.Size = "50,20"
$quoteTextBox.ForeColor = "MediumBlue"
$quoteTextBox.BackColor = "White"
$mainForm.Controls.Add($quoteTextBox)

# Name Output Label
$nameLabel = New-Object System.Windows.Forms.Label
$nameLabel.Location = "45,40"
$nameLabel.Height = 22
$nameLabel.Width = 110
$nameLabel.Text = "Name"
$mainForm.Controls.Add($nameLabel)

# Name Output TextBox
$nameTextBox = New-Object System.Windows.Forms.TextBox
$nameTextBox.Location = "180,40"
$nameTextBox.Size = "130,20"
$nameTextBox.ForeColor = "MediumBlue"
$nameTextBox.BackColor = "White"
$mainForm.Controls.Add($nameTextBox)

# Last Output Label
$lastLabel = New-Object System.Windows.Forms.Label
$lastLabel.Location = "45,70"
$lastLabel.Height = 22
$lastLabel.Width = 110
$lastLabel.Text = "Last"
$mainForm.Controls.Add($lastLabel)

# Last Output TextBox
$lastTextBox = New-Object System.Windows.Forms.TextBox
$lastTextBox.Location = "180,70"
$lastTextBox.Size = "100,20"
$lastTextBox.ForeColor = "MediumBlue"
$lastTextBox.BackColor = "White"
$mainForm.Controls.Add($lastTextBox)

# Date Output Label
$dateLabel = New-Object System.Windows.Forms.Label
$dateLabel.Location = "45,100"
$dateLabel.Height = 22
$dateLabel.Width = 110
$dateLabel.Text = "Date"
$mainForm.Controls.Add($dateLabel)

# Date Output TextBox
$dateTextBox = New-Object System.Windows.Forms.TextBox
$dateTextBox.Location = "180,100"
$dateTextBox.Size = "100,20"
$dateTextBox.ForeColor = "MediumBlue"
$dateTextBox.BackColor = "White"
$mainForm.Controls.Add($dateTextBox)

# Time Output Label
$timeLabel = New-Object System.Windows.Forms.Label
$timeLabel.Location = "45,130"
$timeLabel.Height = 22
$timeLabel.Width = 110
$timeLabel.Text = "Time"
$mainForm.Controls.Add($timeLabel)

# Time Output TextBox
$timeTextBox = New-Object System.Windows.Forms.TextBox
$timeTextBox.Location = "180,130"
$timeTextBox.Size = "100,20"
$timeTextBox.ForeColor = "MediumBlue"
$timeTextBox.BackColor = "White"
$mainForm.Controls.Add($timeTextBox)

# Change Output Label
$changeLabel = New-Object System.Windows.Forms.Label
$changeLabel.Location = "45,160"
$changeLabel.Height = 22
$changeLabel.Width = 110
$changeLabel.Text = "Change"
$mainForm.Controls.Add($changeLabel)

# Change Output TextBox
$changeTextBox = New-Object System.Windows.Forms.TextBox
$changeTextBox.Location = "180,160"
$changeTextBox.Size = "100,20"
$changeTextBox.ForeColor = "MediumBlue"
$changeTextBox.BackColor = "White"
$mainForm.Controls.Add($changeTextBox)

# Open Output Label
$openLabel = New-Object System.Windows.Forms.Label
$openLabel.Location = "45,190"
$openLabel.Height = 22
$openLabel.Width = 110
$openLabel.Text = "Open"
$mainForm.Controls.Add($openLabel)

# Open Output TextBox
$openTextBox = New-Object System.Windows.Forms.TextBox
$openTextBox.Location = "180,190"
$openTextBox.Size = "100,20"
$openTextBox.ForeColor = "MediumBlue"
$openTextBox.BackColor = "White"
$mainForm.Controls.Add($openTextBox)

# High Output Label
$highLabel = New-Object System.Windows.Forms.Label
$highLabel.Location = "45,220"
$highLabel.Height = 22
$highLabel.Width = 110
$highLabel.Text = "High"
$mainForm.Controls.Add($highLabel)

# High Output TextBox
$highTextBox = New-Object System.Windows.Forms.TextBox
$highTextBox.Location = "180,220"
$highTextBox.Size = "100,20"
$highTextBox.ForeColor = "MediumBlue"
$highTextBox.BackColor = "White"
$mainForm.Controls.Add($highTextBox)

# Low Output Label
$lowLabel = New-Object System.Windows.Forms.Label
$lowLabel.Location = "45,250"
$lowLabel.Height = 22
$lowLabel.Width = 110
$lowLabel.Text = "Low"
$mainForm.Controls.Add($lowLabel)

# Low Output TextBox
$lowTextBox = New-Object System.Windows.Forms.TextBox
$lowTextBox.Location = "180,250"
$lowTextBox.Size = "100,20"
$lowTextBox.ForeColor = "MediumBlue"
$lowTextBox.BackColor = "White"
$mainForm.Controls.Add($lowTextBox)

# Volume Output Label
$volumeLabel = New-Object System.Windows.Forms.Label
$volumeLabel.Location = "45,280"
$volumeLabel.Height = 22
$volumeLabel.Width = 110
$volumeLabel.Text = "Volume"
$mainForm.Controls.Add($volumeLabel)

# Volume Output TextBox
$volumeTextBox = New-Object System.Windows.Forms.TextBox
$volumeTextBox.Location = "180,280"
$volumeTextBox.Size = "100,20"
$volumeTextBox.ForeColor = "MediumBlue"
$volumeTextBox.BackColor = "White"
$mainForm.Controls.Add($volumeTextBox)

# MktCap Output Label
$mktCapLabel = New-Object System.Windows.Forms.Label
$mktCapLabel.Location = "45,310"
$mktCapLabel.Height = 22
$mktCapLabel.Width = 110
$mktCapLabel.Text = "Market Cap"
$mainForm.Controls.Add($mktCapLabel)

# MktCap Output TextBox
$mktCapTextBox = New-Object System.Windows.Forms.TextBox
$mktCapTextBox.Location = "180,310"
$mktCapTextBox.Size = "100,20"
$mktCapTextBox.ForeColor = "MediumBlue"
$mktCapTextBox.BackColor = "White"
$mainForm.Controls.Add($mktCapTextBox)

# PreviousClose Output Label
$previousCloseLabel = New-Object System.Windows.Forms.Label
$previousCloseLabel.Location = "45,340"
$previousCloseLabel.Height = 22
$previousCloseLabel.Width = 110
$previousCloseLabel.Text = "Previous Close"
$mainForm.Controls.Add($previousCloseLabel)

# PreviousClose Output TextBox
$previousCloseTextBox = New-Object System.Windows.Forms.TextBox
$previousCloseTextBox.Location = "180,340"
$previousCloseTextBox.Size = "100,20"
$previousCloseTextBox.ForeColor = "MediumBlue"
$previousCloseTextBox.BackColor = "White"
$mainForm.Controls.Add($previousCloseTextBox)

# PercentageChange Output Label
$percentageChangeLabel = New-Object System.Windows.Forms.Label
$percentageChangeLabel.Location = "45,370"
$percentageChangeLabel.Height = 22
$percentageChangeLabel.Width = 135
$percentageChangeLabel.Text = "Percentage Change"
$mainForm.Controls.Add($percentageChangeLabel)

# PercentageChange Output TextBox
$percentageChangeTextBox = New-Object System.Windows.Forms.TextBox
$percentageChangeTextBox.Location = "180,370"
$percentageChangeTextBox.Size = "100,20"
$percentageChangeTextBox.ForeColor = "MediumBlue"
$percentageChangeTextBox.BackColor = "White"
$mainForm.Controls.Add($percentageChangeTextBox)

# Earns Output Label
$earnsLabel = New-Object System.Windows.Forms.Label
$earnsLabel.Location = "45,400"
$earnsLabel.Height = 22
$earnsLabel.Width = 110
$earnsLabel.Text = "Earnings"
$mainForm.Controls.Add($earnsLabel)

# Earns Output TextBox
$earnsTextBox = New-Object System.Windows.Forms.TextBox
$earnsTextBox.Location = "180,400"
$earnsTextBox.Size = "100,20"
$earnsTextBox.ForeColor = "MediumBlue"
$earnsTextBox.BackColor = "White"
$mainForm.Controls.Add($earnsTextBox)

# P-E Output Label
$PELabel = New-Object System.Windows.Forms.Label
$PELabel.Location = "45,430"
$PELabel.Height = 22
$PELabel.Width = 110
$PELabel.Text = "P-E"
$mainForm.Controls.Add($PELabel)

# P-E Output TextBox
$PETextBox = New-Object System.Windows.Forms.TextBox
$PETextBox.Location = "180,430"
$PETextBox.Size = "100,20"
$PETextBox.ForeColor = "MediumBlue"
$PETextBox.BackColor = "White"
$mainForm.Controls.Add($PETextBox)

# AnnRange Output Label
$annRangeLabel = New-Object System.Windows.Forms.Label
$annRangeLabel.Location = "45,460"
$annRangeLabel.Height = 22
$annRangeLabel.Width = 110
$annRangeLabel.Text = "Annual Range"
$mainForm.Controls.Add($annRangeLabel)

# AnnRange Output TextBox
$annRangeTextBox = New-Object System.Windows.Forms.TextBox
$annRangeTextBox.Location = "180,460"
$annRangeTextBox.Size = "130,20"
$annRangeTextBox.ForeColor = "MediumBlue"
$annRangeTextBox.BackColor = "White"
$mainForm.Controls.Add($annRangeTextBox)

# Lookup Button
$lookupButton = New-Object System.Windows.Forms.Button 
$lookupButton.Location = "350,10"
$lookupButton.Size = "75,28"
$lookupButton.ForeColor = "DarkBlue"
$lookupButton.BackColor = "White"
$lookupButton.Text = "Lookup"
$lookupButton.add_Click({QuoteLookup})
$mainForm.Controls.Add($lookupButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "350,40"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

[void] $mainForm.ShowDialog()

#<StockQuotes>
#    <Stock>
#        <Symbol>C</Symbol>
#        <Last>48.89</Last>
#        <Date>9/27/2013</Date>
#        <Time>4:00pm</Time>
#        <Change>-0.04</Change>
#        <Open>48.76</Open>
#        <High>49.20</High>
#        <Low>48.69</Low>
#        <Volume>20248714</Volume>
#        <MktCap>148.7B</MktCap>
#        <PreviousClose>48.93</PreviousClose>
#        <PercentageChange>-0.08%</PercentageChange>
#        <AnnRange>32.70 - 53.56</AnnRange>
#        <Earns>3.113</Earns>
#        <P-E>15.72</P-E>
#        <Name>Citigroup</Name>
#    </Stock>
#</StockQuotes>