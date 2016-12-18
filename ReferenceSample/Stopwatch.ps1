###########################################################
# Stopwatch.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 6-27-13
# System.Diagnostics.Stopwatch Class Demo
###########################################################
Add-Type -AssemblyName System.Windows.Forms

# Decode and setup mainForm Icon
[string]$WatchIcon64=@"
AAABAAEAEBAAAAAAIABoBAAAFgAAACgAAAAQAAAAIAAAAAEAIAAAAAAAQAQAAAAAAAAAAAAAAAAAAAAA
AAD6+vr/6Ojo/9HR0f++vr7/sLCw/6SkpP+srKz/qqqq/6urq/+mpqb/pqam/7i4uP/Hx8f/3d3d//Pz
8//8/Pxd/f39//j4+P/x8fH/4ODg/7q7u//AwMD/rq6u/6Ggof+mpqb/vb29/7y8vP/Q0ND/7Ozs//T0
9P/7+/v//v7+Xf//////////6enp/7i4uP+nqKj/mJma/8HCw/+6u73/x8jJ/6Skpv+dnZ7/tbW1/9DQ
0f/+/v7//////////13/////9/f3/7a2tv+fnp//qamq/5qam/+2t7f/tbW1/7u7vP+jo6T/qKip/5qa
mv+0tbX/19fX//7+/v////9d/////9TU1P+ioqL/oqKi/6Kio//Hx8j/y8vL/8zMzP/Ly8z/ysrK/7Ky
sv+YmJj/nZ6e/7W1tf/4+Pj/////Xf39/f+srKz/sbGx/8PDxP/BwcL/29vb/+Hh4f/k5OT/4uLj/97e
3v/S09P/yMnJ/7W1tf+enp7/7e3t/////1339/f/rKys/7a2t/+2trf/zs7O/+/v7//39/f/fHx8/87O
zv/z8/P/4+Pj/8bGxv+1tLX/oJ+g/+Dg4P////9d9/f3/7m5uv++v7//5OTk//T09P/09fX/l5eY/5CQ
kP/x8PD//Pv7//z8+//r6+v/1NXU/6mpqv/m5ub/////Xfv7+//T09P/tre3/+np6f/Z2dn/vr6+/62t
rv/q6uv/6Ojo//f39v/p6en/4eDg/9DQ0P+7u7v/8fHy/////13/////7+/v/7e4uP/IyMj/zs7P/9bW
1//x8fH/1tbX/+Pj5P/09PX/7+/v/+Hh4f+srKz/3d3d//z8/P////9d//////v7+//p6Oj/m5ub/9DQ
0P/i4uP/8fHy/+/v7//08/T/7e3u/+rq6v+rqqr/w8PD//n5+f/+/v7/////Xf/////7+/v/1dXV/9XV
1f+Ghob/n56e/9bW1v/d3d7/4ODg/7q6uv+FhYX/tLS0/9bW1//q6ur//v7+/////13/////srGy/2tr
a//g4OD/6enp/7m5uf+BgYH/dHR0/3d3d/+bnJv/1dXW//Ly8v+ZmZn/ZmZm//X19f////9d/////+rq
6v/BwcH/8fHx//v7+//29vb/9fX1/9fX1//r7Ov/9PT0//f39//+/v7/0tLS/8/Pz//8/Pz/////Xf//
///+/v7//f39/////////////v7+//T08/9dXV3/urq7//7+/v////////////7+/v/+/v7/////////
/13////////////////////////////////w8fD/jo6O/8fHx///////////////////////////////
//////9dAAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA
//8AAP//AAD//w==
"@
$iconStream=[System.IO.MemoryStream][System.Convert]::FromBase64String($watchIcon64)
$iconBmp=[System.Drawing.Bitmap][System.Drawing.Image]::FromStream($iconStream)
$iconHandle=$iconBmp.GetHicon()
$watchIcon=[System.Drawing.Icon]::FromHandle($iconHandle) 

# Main Form 
$stopWatch = New-Object System.Diagnostics.Stopwatch
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,8.25"
$mainForm.Icon = $watchIcon
$mainForm.Text = " Stopwatch Class Demo"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkSlateBlue"
$mainForm.Width = 340
$mainForm.Height = 220

# Elapsed Time Label
$elapsedTimeLabel = New-Object System.Windows.Forms.Label
$elapsedTimeLabel.Font = "Comic Sans MS,10"
$elapsedTimeLabel.Location = "20,20"
$elapsedTimeLabel.Size = "120,20"
$elapsedTimeLabel.Text = "Elapsed Time "
$mainForm.Controls.Add($elapsedTimeLabel)

# Elapsed Ticks Label
$elapsedTicksLabel = New-Object System.Windows.Forms.Label
$elapsedTicksLabel.Font = "Comic Sans MS,10"
$elapsedTicksLabel.Location = "20,60"
$elapsedTicksLabel.Size = "120,20"
$elapsedTicksLabel.Text = "Elapsed Ticks "
$mainForm.Controls.Add($elapsedTicksLabel)

# Elapsed Milliseconds Label
$elapsedMilliLabel = New-Object System.Windows.Forms.Label
$elapsedMilliLabel.Font = "Comic Sans MS,10"
$elapsedMilliLabel.Location = "20,100"
$elapsedMilliLabel.Size = "120,20"
$elapsedMilliLabel.Text = "Elapsed Millisec "
$mainForm.Controls.Add($elapsedMilliLabel)

# Elapsed Time TextBox
$elapsedTimeTextBox = New-Object System.Windows.Forms.TextBox
$elapsedTimeTextBox.Location = "140,20"
$elapsedTimeTextBox.Size = "155,20"
$elapsedTimeTextBox.Text = "00:00:00"
$mainForm.Controls.Add($elapsedTimeTextBox)

# Elapsed Ticks TextBox
$elapsedTicksTextBox = New-Object System.Windows.Forms.TextBox
$elapsedTicksTextBox.Location = "140,60"
$elapsedTicksTextBox.Size = "155,20"
$elapsedTicksTextBox.Text = "0"
$mainForm.Controls.Add($elapsedTicksTextBox)

# Elapsed Miliseconds TextBox
$elapsedMilliTextBox = New-Object System.Windows.Forms.TextBox
$elapsedMilliTextBox.Location = "140,100"
$elapsedMilliTextBox.Size = "155,20"
$elapsedMilliTextBox.Text = "0"
$mainForm.Controls.Add($elapsedMilliTextBox)

# Start Button
$buttonStart = New-Object System.Windows.Forms.Button
$buttonStart.ForeColor = "DarkSlateBlue"
$buttonStart.BackColor = "White"
$buttonStart.Location = "20, 140"
$buttonStart.Size = "75, 23"
$buttonStart.Text = "Start"
$buttonStart.add_Click({
    $stopWatch.Restart()
    $elapsedTimeTextBox.Text = "00:00:00"
    $elapsedTicksTextBox.Text = "0"
    $elapsedMilliTextBox.Text = "0"
    })
$mainForm.Controls.Add($buttonStart)

# View Button
$buttonView = New-Object System.Windows.Forms.Button
$buttonView.ForeColor = "DarkSlateBlue"
$buttonView.BackColor = "White"
$buttonView.Location = "120, 140"
$buttonView.Size = "75, 23"
$buttonView.Text = "View"
$buttonView.add_Click({
    $elapsedTimeTextBox.Text = $stopWatch.Elapsed
    $elapsedMilliseconds = $stopWatch.ElapsedMilliseconds
    $elapsedMilliTextBox.Text = "{0:N0}" -f $elapsedMilliseconds
    $elapsedTicks = $stopWatch.ElapsedTicks
    $elapsedTicksTextBox.Text = "{0:N0}" -f $elapsedTicks
    })
$mainForm.Controls.Add($buttonView)

# Stop Button
$buttonStop = New-Object System.Windows.Forms.Button
$buttonStop.ForeColor = "DarkSlateBlue"
$buttonStop.BackColor = "White"
$buttonStop.Location = "220, 140"
$buttonStop.Size = "75, 23"
$buttonStop.Text = "Stop"
$buttonStop.add_Click({
    $stopWatch.Stop()
    $elapsedTimeTextBox.Text = $stopWatch.Elapsed
    $elapsedMilliseconds = $stopWatch.ElapsedMilliseconds
    $elapsedMilliTextBox.Text = "{0:N0}" -f $elapsedMilliseconds
    $elapsedTicks = $stopWatch.ElapsedTicks
    $elapsedTicksTextBox.Text = "{0:N0}" -f $elapsedTicks
    })
$mainForm.Controls.Add($buttonStop)

# Display Form
[void] $mainForm.ShowDialog()
