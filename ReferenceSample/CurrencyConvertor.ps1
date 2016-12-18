#####################################################
# CurrencyConverter.ps1.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 9-29-13
# PowerShell GUI Converts Currency Using Web Services
#####################################################
Add-Type -AssemblyName System.Windows.Forms

Function CurrencyConverter {
    $from = $fromComboBox.Text.Substring(($fromComboBox.Text.Length - 3),3)
    $to = $toComboBox.Text.Substring(($toComboBox.Text.Length - 3),3)
    $currencyConvertor = New-WebServiceProxy -uri "http://www.webservicex.net/CurrencyConvertor.asmx?WSDL"
    $selection = $currencyConvertor.ConversionRate($from,$to)
    $formattedOutput = "One " + $fromComboBox.Text.Substring(0,($fromComboBox.Text.Length - 5)) + "is worth " + `
			$selection + " " + $toComboBox.Text.Substring(0,($toComboBox.Text.Length - 5))
    $convertOutputBox.Text = $formattedOutput

}

$currencies = @(
    ("Afghanistan Afghani - AFA")
    ("Albanian Lek - ALL")
    ("Algerian Dinar - DZD")
    ("Argentine Peso - ARS")
    ("Aruba Florin - AWG")
    ("Australian Dollar - AUD")
    ("Bahamian Dollar - BSD")
    ("Bahraini Dinar - BHD")
    ("Bangladesh Taka - BDT")
    ("Barbados Dollar - BBD")
    ("Belize Dollar - BZD")
    ("Bermuda Dollar - BMD")
    ("Bhutan Ngultrum - BTN")
    ("Bolivian Boliviano - BOB")
    ("Botswana Pula -BWP")
    ("Brazilian Real - BRL")
    ("British Pound - GBP")
    ("Brunei Dollar - BND")
    ("Burundi Franc - BIF")
    ("CFA Franc (BCEAO) - XOF")
    ("CFA Franc (BEAC) - XAF)")
    ("Cambodia Riel - KHR")
    ("Canadian Dollar - CAD")
    ("Cape Verde Escudo - CVE")
    ("Cayman Islands Dollar - KYD")
    ("Chilean Peso - CLP")
    ("Chinese Yuan - CNY")
    ("Colombian Peso - COP")
    ("Comoros Franc - KMF")
    ("Costa Rica Colon - CRC")
    ("Croatian Kuna - HRK")
    ("Cuban Peso - CUP")
    ("Cyprus Pound - CYP")
    ("Czech Koruna - CZK")
    ("Danish Krone - DKK")
    ("Dijibouti Franc - DJF")
    ("Dominican Peso - DOP")
    ("East Caribbean Dollar - XCD")
    ("Egyptian Pound - EGP")
    ("El Salvador Colon - SVC")
    ("Estonian Kroon - EEK")
    ("Ethiopian Birr - ETB")
    ("Euro - EUR")
    ("Falkland Islands Pound - FKP")
    ("Gambian Dalasi - GMD")
    ("Ghanian Cedi - GHC")
    ("Gibraltar Pound - GIP")
    ("Gold Ounces - XAU")
    ("Guatemala Quetzal - GTQ")
    ("Guinea Franc - GNF")
    ("Guyana Dollar - GYD")
    ("Haiti Gourde - HTG")
    ("Honduras Lempira - HNL")
    ("Hong Kong Dollar - HKD")
    ("Hungarian Forint - HUF")
    ("Iceland Krona - ISK")
    ("Indian Rupee - INR")
    ("Indonesian Rupiah - IDR")
    ("Iraqi Dinar - IQD")
    ("Israeli Shekel - ILS")
    ("Jamaican Dollar - JMD")
    ("Japanese Yen - JPY")
    ("Jordanian Dinar - JOD")
    ("Kazakhstan Tenge - KZT")
    ("Kenyan Shilling - KES")
    ("Korean Won - KRW")
    ("Kuwaiti Dinar - KWD")
    ("Lao Kip - LAK")
    ("Latvian Lat - LVL")
    ("Lebanese Pound - LBP")
    ("Lesotho Loti - LSL")
    ("Liberian Dollar - LRD")
    ("Libyan Dinar - LYD")
    ("Lithuanian Lita - LTL")
    ("Macau Pataca - MOP")
    ("Macedonian Denar - MKD")
    ("Malagasy Franc - MGF")
    ("Malawi Kwacha - MWK")
    ("Malaysian Ringgit - MYR")
    ("Maldives Rufiyaa - MVR")
    ("Maltese Lira - MTL")
    ("Mauritania Ougulya - MRO")
    ("Mauritius Rupee - MUR")
    ("Mexican Peso - MXN ")
    ("Moldovan Leu - MDL")
    ("Mongolian Tugrik - MNT")
    ("Moroccan Dirham - MAD")
    ("Mozambique Metical - MZM")
    ("Myanmar Kyat - MMK")
    ("Namibian Dollar - NAD")
    ("Nepalese Rupee - NPR")
    ("Neth Antilles Guilder - ANG")
    ("New Zealand Dollar - NZD")
    ("Nicaragua Cordoba - NIO")
    ("Nigerian Naira - NGN")
    ("North Korean Won - KPW")
    ("Norwegian Krone - NOK")
    ("Omani Rial - OMR")
    ("Pacific Franc - XPF")
    ("Pakistani Rupee - PKR")
    ("Palladium Ounces - XPD")
    ("Panama Balboa - PAB")
    ("Papua New Guinea Kina - PGK")
    ("Paraguayan Guarani - PYG")
    ("Peruvian Nuevo Sol - PEN")
    ("Philippine Peso - PHP")
    ("Platinum Ounces - XPT")
    ("Polish Zloty - PLN")
    ("Qatar Rial - QAR")
    ("Romanian Leu - ROL")
    ("Russian Rouble - RUB")
    ("Samoa Tala - WST")
    ("Sao Tome Dobra - STD")
    ("Saudi Arabian Riyal - SAR")
    ("Seychelles Rupee - SCR")
    ("Sierra Leone Leone - SLL")
    ("Silver Ounces - XAG")
    ("Singapore Dollar - SGD")
    ("Slovak Koruna - SKK")
    ("Slovenian Tolar - SIT")
    ("Solomon Islands Dollar - SBD")
    ("Somali Shilling - SOS")
    ("South African Rand - ZAR")
    ("Sri Lanka Rupee - LKR")
    ("St Helena Pound - SHP")
    ("Sudanese Dinar - SDD")
    ("Surinam Guilder - SRG")
    ("Swaziland Lilageni - SZL")
    ("Swedish Krona - SEK")
    ("Swiss Franc - CHF")
    ("Syrian Pound - SYP")
    ("Taiwan Dollar - TWD")
    ("Tanzanian Shilling - TZS")
    ("Thai Baht - THB")
    ("Tonga Pa'anga - TOP")
    ("Trinidad & Tobago Dollar - TTD")
    ("Tunisian Dinar - TND")
    ("Turkish Lira - TRY")
    ("U.S. Dollar - USD")
    ("UAE Dirham - AED")
    ("Ugandan Shilling - UGX")
    ("Ukraine Hryvnia - UAH")
    ("Uruguayan New Peso - UYU")
    ("Vanuatu Vatu - VUV")
    ("Venezuelan Bolivar - VEB")
    ("Vietnam Dong - VND")
    ("Yemen Riyal - YER")
    ("Yugoslav Dinar - YUM")
    ("Zambian Kwacha - ZMK")
    ("Zimbabwe Dollar - ZWD")
)

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " Currency Converter"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkBlue"
$mainForm.Width = 600
$mainForm.Height = 170

# From Input Label
$fromInputLabel = New-Object System.Windows.Forms.Label
$fromInputLabel.Location = "45,10"
$fromInputLabel.Height = 22
$fromInputLabel.Width = 100
$fromInputLabel.Text = "From Currency"
$mainForm.Controls.Add($fromInputLabel)

# From Input ComboBox
$fromComboBox = New-Object System.Windows.Forms.ComboBox
$fromComboBox.Location = "145,10"
$fromComboBox.Size = "300,20"
$fromComboBox.ForeColor = "MediumBlue"
$fromComboBox.BackColor = "White"
# Add items to Combo box
for ($i=0; $i -lt $currencies.Count; $i++) {
	[void]$fromComboBox.items.add($currencies[$i])
}        
$fromComboBox.SelectedIndex = 138;
$mainForm.Controls.Add($fromComboBox)

# To Input Label
$toInputLabel = New-Object System.Windows.Forms.Label
$toInputLabel.Location = "45,40"
$toInputLabel.Height = 22
$toInputLabel.Width = 100
$toInputLabel.Text = "To Currency"
$mainForm.Controls.Add($toInputLabel)

# To Input ComboBox
$toComboBox = New-Object System.Windows.Forms.ComboBox
$toComboBox.Location = "145,40"
$toComboBox.Size = "300,20"
$toComboBox.ForeColor = "MediumBlue"
$toComboBox.BackColor = "White"
# Add 149 items to Combo box
for ($i=0; $i -lt $currencies.Count; $i++) {
	[void]$toComboBox.items.add($currencies[$i])
}        
$toComboBox.SelectedIndex = 0;
$mainForm.Controls.Add($toComboBox)

# Currency Output Label
$convertOuputLabel = New-Object System.Windows.Forms.Label
$convertOuputLabel.Location = "45,80"
$convertOuputLabel.Height = 22
$convertOuputLabel.Width = 100
$convertOuputLabel.Text = "Converted"
$mainForm.Controls.Add($convertOuputLabel)

# Currency TextBox
$convertOutputBox = New-Object System.Windows.Forms.TextBox
$convertOutputBox.Location = "145,80"
$convertOutputBox.Size = "400,23"
$convertOutputBox.ForeColor = "MediumBlue"
$convertOutputBox.BackColor = "White"
$mainForm.Controls.Add($convertOutputBox)

# Converter Button
$converterButton = New-Object System.Windows.Forms.Button 
$converterButton.Location = "470,10"
$converterButton.Size = "75,28"
$converterButton.ForeColor = "DarkBlue"
$converterButton.BackColor = "White"
$converterButton.Text = "Convert"
$converterButton.add_Click({CurrencyConverter})
$mainForm.Controls.Add($converterButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "470,40"
$exitButton.Size = "75,28"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

[void] $mainForm.ShowDialog()