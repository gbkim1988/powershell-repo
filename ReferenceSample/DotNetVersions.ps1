######################################################
# DotNetVersion.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 4-30-13
# GUI Displays the .Net Frameworks Installed
######################################################
Add-Type -AssemblyName System.Windows.Forms

# WinForm Setup
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = “Comic Sans MS,8.25"
$mainForm.Text = "  .Net Framework Versions"
$mainForm.Width = 400
$mainForm.Height = 272

$listView = New-Object System.Windows.Forms.ListView
$listView.View = 'Details'
$listView.Width = 386
$listView.Height = 272
$listView.GridLines = 1
$listView.Scrollable = 1
 
$listView.Columns.Add('Framework', 230)
$listView.Columns.Add('Version', 170)

$report = @()

# Collect v1.x Frameworks
$report = ls $Env:windir\Microsoft.NET\Framework | 
Where { $_.PSIsContainer } | 
Where { $_.Name -like "v1.*" } | 
Select @{N="Framework";E={$_.Name.Substring(0,4)}},@{N="Version";E={$_.Name.Substring(1)}}

# Collect v2.x and above Frameworks
$report += Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
Get-ItemProperty -name Version -erroraction SilentlyContinue |
Where { $_.PSChildName -ne "1033"} |
Where { $_.PSChildName -ne "Setup"} |
Where { $_.PSChildName -notlike "Windows*"} |
Select @{N="Framework";E={$_.PSChildName}},@{N="Version";E={$_.Version}}

$report = $report | Sort Version

# Load List
ForEach ($line in $report) {
    $item = New-Object System.Windows.Forms.ListViewItem($line.Framework)
    $item.SubItems.Add($line.Version)
    $listView.Items.Add($item)
}

$mainForm.Controls.Add($listView)
[void] $mainForm.ShowDialog()

# foreach {if($_PSChildName -like "*v2.0.50727*"){$_PSChildName -replace "v2.0.50727", "v2.0"}else{$_PSChildName}}