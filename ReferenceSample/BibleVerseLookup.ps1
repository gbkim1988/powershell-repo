#########################################################
# BibleVerseLookup.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 9-21-13
# PowerShell GUI Looks up Bible Verses Using Web Services
#########################################################
Add-Type -AssemblyName System.Windows.Forms

Function VerseLookup {
    $book = $bookComboBox.Text
    $chapter = $chapterTextBox.Text
    $verse = $verseTextBox.Text
    $BibleVerse = New-WebServiceProxy -uri "http://www.webservicex.net/BibleWebservice.asmx?WSDL"
    $theVerse = [xml]$BibleVerse.GetBibleWordsByChapterAndVerse($book,$chapter,$verse)
    $Selection  = $theVerse.NewDataSet.Table | Select BibleWords
    $verseOutputBox.Text = $Selection.BibleWords
}

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " Bible Verse Lookup (King James Version)"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkBlue"
$mainForm.Width = 600
$mainForm.Height = 400

# Book Input Label
$bookInputLabel = New-Object System.Windows.Forms.Label
$bookInputLabel.Location = "45,10"
$bookInputLabel.Height = 22
$bookInputLabel.Width = 100
$bookInputLabel.Text = "Select Book"
$mainForm.Controls.Add($bookInputLabel)

# Book Input ComboBox
$bookComboBox = New-Object System.Windows.Forms.ComboBox
$bookComboBox.Location = "145,10"
$bookComboBox.Size = "300,20"
$bookComboBox.ForeColor = "MediumBlue"
$bookComboBox.BackColor = "White"
# Add items to Combo box
$BibleBooks = New-WebServiceProxy -uri "http://www.webservicex.net/BibleWebservice.asmx?WSDL"
$books = [xml]$BibleBooks.GetBookTitles()
$bookList = $books.NewDataSet.Table | Select BookTitle
for ($i=0; $i -lt $bookList.Count; $i++) {
	[void]$bookComboBox.items.add($bookList.Item($i).BookTitle)
}        
#$bookComboBox.SelectedIndex = 0;
$mainForm.Controls.Add($bookComboBox)

# Chapter Input Label
$chapterInputLabel = New-Object System.Windows.Forms.Label
$chapterInputLabel.Location = "145,40"
$chapterInputLabel.Height = 22
$chapterInputLabel.Width = 70
$chapterInputLabel.Text = "Chapter"
$mainForm.Controls.Add($chapterInputLabel)

# Chapter Input TextBox
$chapterTextBox = New-Object System.Windows.Forms.TextBox
$chapterTextBox.Location = "220,40"
$chapterTextBox.Size = "50,20"
$chapterTextBox.ForeColor = "MediumBlue"
$chapterTextBox.BackColor = "White"
#$chapterTextBox.Text = "Enter Chapter"
$mainForm.Controls.Add($chapterTextBox)

# Verse Input Label
$verseInputLabel = New-Object System.Windows.Forms.Label
$verseInputLabel.Location = "335,40"
$verseInputLabel.Height = 22
$verseInputLabel.Width = 50
$verseInputLabel.Text = "Verse"
$mainForm.Controls.Add($verseInputLabel)

# Verse Input TextBox
$verseTextBox = New-Object System.Windows.Forms.TextBox
$verseTextBox.Location = "395,40"
$verseTextBox.Size = "50,20"
$verseTextBox.ForeColor = "MediumBlue"
$verseTextBox.BackColor = "White"
#$verseTextBox.Text = "Enter Verse"
$mainForm.Controls.Add($verseTextBox)

# Verse Output TextBox
$verseOutputBox = New-Object System.Windows.Forms.RichTextBox
$verseOutputBox.Location = "45,110"
$verseOutputBox.Size = "500,210"
$verseOutputBox.ForeColor = "MediumBlue"
$verseOutputBox.BackColor = "White"
$verseOutputBox.Multiline = $true
$verseOutputBox.Scrollbars = "Vertical"
$verseOutputBox.Wordwrap = $true
$mainForm.Controls.Add($verseOutputBox)

# Lookup Button
$lookupButton = New-Object System.Windows.Forms.Button 
$lookupButton.Location = "470,10"
$lookupButton.Size = "75,28"
$lookupButton.ForeColor = "DarkBlue"
$lookupButton.BackColor = "White"
$lookupButton.Text = "Lookup"
$lookupButton.add_Click({VerseLookup})
$mainForm.Controls.Add($lookupButton)

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

# Output XML
#<?xml version="1.0" encoding="utf-16"?>
#<NewDataSet>
#  <Table>
#    <Book>1</Book>
#    <BookTitle>Genesis</BookTitle>
#    <Chapter>1</Chapter>
#    <Verse>1</Verse>
#    <BibleWords>In the beginning God created the heaven and the earth.</BibleWords>
#  </Table>
#</NewDataSet>