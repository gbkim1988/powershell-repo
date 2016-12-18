##########################################################
# BibleChapterLookup.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 9-30-13
# PowerShell GUI Looks up Bible Chapter Using Web Services
##########################################################
Add-Type -AssemblyName System.Windows.Forms

Function ChapterLookup {
    $book = $bookComboBox.Text
    $chapter = $chapterTextBox.Text
    $bibleChapter = New-WebServiceProxy -uri "http://www.webservicex.net/BibleWebservice.asmx?WSDL"
    $theChapter = [xml]$bibleChapter.GetBibleWordsByBookTitleAndChapter($book,$chapter)
    $selections  = $theChapter.NewDataSet.Table | Select Verse, BibleWords
    $chapterOutputBox.Text = ""
    Foreach ($selection in $selections) {
        $chapterOutputBox.Text = $chapterOutputBox.Text + $selection.Verse + ") " + $selection.BibleWords + "`n"
    }
}

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,10"
$mainForm.Text = " Bible Chapter Lookup (King James Version)"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkBlue"
$mainForm.Width = 800
$mainForm.Height = 600

# Book Input Label
$bookInputLabel = New-Object System.Windows.Forms.Label
$bookInputLabel.Location = "45,10"
$bookInputLabel.Height = 22
$bookInputLabel.Width = 100
$bookInputLabel.Text = "Book"
$mainForm.Controls.Add($bookInputLabel)

# Book Input ComboBox
$bookComboBox = New-Object System.Windows.Forms.ComboBox
$bookComboBox.Location = "145,10"
$bookComboBox.Size = "300,20"
$bookComboBox.ForeColor = "MediumBlue"
$bookComboBox.BackColor = "White"
# Add items to Combo box
$bibleBooks = New-WebServiceProxy -uri "http://www.webservicex.net/BibleWebservice.asmx?WSDL"
$books = [xml]$bibleBooks.GetBookTitles()
$bookList = $books.NewDataSet.Table | Select BookTitle
for ($i=0; $i -lt $bookList.Count; $i++) {
	[void]$bookComboBox.items.add($bookList.Item($i).BookTitle)
}
#$bookComboBox.SelectedIndex = 0;      
$mainForm.Controls.Add($bookComboBox)

# Chapter Input Label
$chapterInputLabel = New-Object System.Windows.Forms.Label
$chapterInputLabel.Location = "45,40"
$chapterInputLabel.Height = 22
$chapterInputLabel.Width = 70
$chapterInputLabel.Text = "Chapter"
$mainForm.Controls.Add($chapterInputLabel)

# Chapter Input TextBox
$chapterTextBox = New-Object System.Windows.Forms.TextBox
$chapterTextBox.Location = "145,40"
$chapterTextBox.Size = "50,20"
$chapterTextBox.ForeColor = "MediumBlue"
$chapterTextBox.BackColor = "White"
$mainForm.Controls.Add($chapterTextBox)

# Chapter Output TextBox
$chapterOutputBox = New-Object System.Windows.Forms.RichTextBox
$chapterOutputBox.Location = "45,110"
$chapterOutputBox.Size = "700,410"
$chapterOutputBox.ForeColor = "MediumBlue"
$chapterOutputBox.BackColor = "White"
$chapterOutputBox.Multiline = $true
$chapterOutputBox.Scrollbars = "Vertical"
$chapterOutputBox.Wordwrap = $true
$mainForm.Controls.Add($chapterOutputBox)

# Lookup Button
$lookupButton = New-Object System.Windows.Forms.Button 
$lookupButton.Location = "470,10"
$lookupButton.Size = "75,28"
$lookupButton.ForeColor = "DarkBlue"
$lookupButton.BackColor = "White"
$lookupButton.Text = "Lookup"
$lookupButton.add_Click({ChapterLookup})
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
#<NewDataSet> 
#    <Table> 
#        <Book>1</Book> 
#        <BookTitle>Genesis</BookTitle> 
#        <Chapter>1</Chapter> 
#        <Verse>1</Verse> 
#        <BibleWords>In the beginning God created the heaven and the earth.</BibleWords> 
#    </Table> 
#    <Table> 
#        <Book>1</Book> 
#        <BookTitle>Genesis</BookTitle> 
#        <Chapter>1</Chapter> 
#        <Verse>2</Verse> 
#        <BibleWords>And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters.</BibleWords> 
#    </Table> 
#</NewDataSet> 