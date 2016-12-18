###########################################################
# ExifInfoByFolder.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 10-30-15
# Read Folder of Image Files EXIF MetaData and Write to CSV
###########################################################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Hide Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
 [DllImport("Kernel32.dll")]
 public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
 public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
 '
 function Hide-Console {
 $consolePtr = [Console.Window]::GetConsoleWindow()
 [Console.Window]::ShowWindow($consolePtr, 0)
 }
 If (-not $psISE) {hide-console}

# Set Global Values
$global:output = @()
$global:folderName = ""

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,8.25"
$mainForm.Text = " Image File Exif MetaData By Folder"
$mainForm.FormBorderStyle = "FixedDialog"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkBlue"
$mainForm.width = 600
$mainForm.height = 250

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Font = "Comic Sans MS,14"
$titleLabel.ForeColor = "Yellow"
$titleLabel.Location = "30,20"
$titleLabel.Size = "400,30"
$titleLabel.Text = "Image File Exif MetaData by Folder"
$mainForm.Controls.Add($titleLabel)

# Input Box
$textBoxIn = New-Object System.Windows.Forms.TextBox
$textBoxIn.Location = "35, 70"
$textBoxIn.Size = "500, 20"
$textBoxIn.Text = ""
$mainForm.Controls.Add($textBoxIn)

# Input Box Label
$ProcessLabel = New-Object System.Windows.Forms.Label
$ProcessLabel.Location = "35, 100"
$ProcessLabel.Size = "300, 23"
$ProcessLabel.ForeColor = "White" 
$ProcessLabel.Text = "Input Images Folder"
$ProcessLabel.Font = "Comic Sans MS,12"
$mainForm.Controls.Add($ProcessLabel)

# Browse Input Button
$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Location = "35, 150"
$buttonBrowse.Size = "75, 23"
$buttonBrowse.ForeColor = "Red"
$buttonBrowse.BackColor = "White"
$buttonBrowse.Text = "Browse"
$buttonBrowse.add_Click({selectFolder})
$mainForm.Controls.Add($buttonBrowse)

# Process Button
$buttonProcess = New-Object System.Windows.Forms.Button
$buttonProcess.Location = "240,150"
$buttonProcess.Size = "75, 23"
$buttonProcess.ForeColor = "Red"
$buttonProcess.BackColor = "White"
$buttonProcess.Text = "Process"
$buttonProcess.add_Click({processFiles})
$mainForm.Controls.Add($buttonProcess)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "450,150"
$exitButton.Size = "75,23"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

# Status Strip and Label
$statusStrip = New-Object System.Windows.Forms.StatusStrip
$statusStrip.ForeColor = "Blue"
$statusStrip.BackColor = "White"

$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
[void]$statusStrip.Items.Add($statusLabel)
$statusLabel.AutoSize = $true
$statusLabel.ForeColor = "Blue"
$statusLabel.BackColor = "White"
$statusLabel.Text = "Ready!"
$mainForm.Controls.Add($statusStrip)

function processFiles {
    $global:folderName = $textBoxIn.Text

    # Get All Files from Select Path
    $files = @()
    $files = Get-ChildItem $global:folderName
    # Process All Files
    Foreach ($file in $files) {
        $data = "" | Select filename, aperture, maxAperture, brightness, colorSpace, compressedBitsPerPixel, `
                            compression, contrast, customRendered, dateTaken, digitalZoomRatio, exposureTime,`
                            exifVersion, exposureBias, exposureMode, fileSource, fstop, filepath, `
                            flash, focalLength, focalLength35mmFormat, gainControl, height, heightRes, iso, `
                            lightSource, cameraMaker, cameraModel, cameraSoftware, meteringMode, orientation, `
                            saturation, sceneType, sensingMethod, sharpness, shutter, subjectDistance, `
                            subjectDistanceRange, whiteBalance, width, widthRes 

        # Load image from file
        $filefullname = $global:folderName + "\" + $file
        $statusLabel.Text = "Processing " + $filefullname
        $statusStrip.Refresh()
        $imageType = "Y"
        Try {                       
            $photo = [System.Drawing.Image]::FromFile($filefullname)
        } Catch {
            $imageType = "N"
        }
        
        # If Image File Exist Then Get Properties and Write File
        If ($imageType -eq "Y") {
            # Aperture
            Try { 
                $apertureProperty = $photo.GetPropertyItem(37378)
                if ($apertureProperty -ne $null){$aperture = MakeNumber($apertureProperty)}
                if ($aperture -ne $null){$data.aperture = $aperture}
            } Catch {}

            # Maximun Aperture
            Try { 
                $maxApertureProperty = $photo.GetPropertyItem(37381)
                if ($maxApertureProperty -ne $null){$maxAperture = MakeNumber($maxApertureProperty)}
                $maxAperture = $maxAperture  | Out-String
                if ($maxAperture -ne $null){$data.maxAperture = $maxAperture}
            } Catch {}
                
            # Brightness
            Try { 
                $brightnessProperty = $photo.GetPropertyItem(37379)
                if ($brightnessProperty -ne $null){$brightness = MakeNumber($brightnessProperty)}
                $brightness = $brightness  | Out-String
                if ($brightness -ne $null){$data.brightness = $brightness}
            } Catch {}
              
            # Color Space
            Try { 
                $colorProperty = $photo.GetPropertyItem(40961)
                if ($colorProperty -ne $null){$colorSpace = [System.BitConverter]::ToUInt16($colorProperty.Value, 0)}
                if ($colorSpace -eq "1")     {$colorSpace = "sRGB"}
                if ($colorSpace -eq "2")     {$colorSpace = "Adobe RGB"}
                if ($colorSpace -eq "65533") {$colorSpace = "Wide Gamut RGB"}
                if ($colorSpace -eq "65534") {$colorSpace = "ICC Profile"}
                if ($colorSpace -eq "65535") {$colorSpace = "Uncalibrated"}
                if ($colorSpace -ne $null){$data.colorSpace = $colorSpace}
            } Catch {}
 
             # Compressed Bits per Pixel
            Try { 
                $compressedBitsPerPixelProperty = $photo.GetPropertyItem(37122)
                if ($compressedBitsPerPixelProperty -ne $null){$compressedBitsPerPixel = MakeNumber($compressedBitsPerPixelProperty)}
                $compressedBitsPerPixel = $compressedBitsPerPixel  | Out-String
                if ($compressedBitsPerPixel -ne $null){$data.compressedBitsPerPixel = $compressedBitsPerPixel}
            } Catch {}
 
            # Compression Type
            Try { 
                $compressionProperty = $photo.GetPropertyItem(259)
                if ($compressionProperty -ne $null){$compression = [System.BitConverter]::ToUInt16($compressionProperty.Value, 0)}
                if ($compression -eq "1")     {$compression = "Uncompressed"}
                if ($compression -eq "2")     {$compression = "CCITT 1D"}
                if ($compression -eq "3")     {$compression = "T4/Group 3 Fax"} 
                if ($compression -eq "4")     {$compression = "T6/Group 4 Fax"} 
                if ($compression -eq "5")     {$compression = "LZW"} 
                if ($compression -eq "6")     {$compression = "JPEG (old-style)"} 
                if ($compression -eq "7")     {$compression = "JPEG"} 
                if ($compression -eq "8")     {$compression = "Adobe Deflate"}
                if ($compression -eq "9")     {$compression = "JBIG B&W"} 
                if ($compression -eq "10")    {$compression = "JBIG Color"} 
                if ($compression -eq "99")    {$compression = "JPEG"} 
                if ($compression -eq "262")   {$compression = "Kodak 262"} 
                if ($compression -eq "32766") {$compression = "Next"}
                if ($compression -eq "32767") {$compression = "Sony ARW Compressed"}
                if ($compression -eq "32769") {$compression = "Packed RAW"}
                if ($compression -eq "32770") {$compression = "Samsung SRW Compressed"}
                if ($compression -eq "32771") {$compression = "CCIRLEW"}
                if ($compression -eq "32772") {$compression = "Samsung SRW Compressed 2"}
                if ($compression -eq "32773") {$compression = "PackBits"}
                if ($compression -eq "32809") {$compression = "Thunderscan"}
                if ($compression -eq "32867") {$compression = "Kodak KDC Compressed"}
                if ($compression -eq "32895") {$compression = "IT8CTPAD"}
                if ($compression -eq "32896") {$compression = "IT8LW"}
                if ($compression -eq "32897") {$compression = "IT8MP"}
                if ($compression -eq "32898") {$compression = "IT8BL"}
                if ($compression -eq "32908") {$compression = "PixarFilm"}
                if ($compression -eq "32909") {$compression = "PixarLog"}
                if ($compression -eq "32946") {$compression = "Deflate"}
                if ($compression -eq "32947") {$compression = "DCS"}
                if ($compression -eq "34661") {$compression = "JBIG"}
                if ($compression -eq "34676") {$compression = "SGILog"}
                if ($compression -eq "34677") {$compression = "SGILog24"}
                if ($compression -eq "34712") {$compression = "JPEG 2000"}
                if ($compression -eq "34713") {$compression = "Nikon NEF Compressed"}
                if ($compression -eq "34715") {$compression = "JBIG2 TIFF FX"}
                if ($compression -eq "34718") {$compression = "Microsoft Document Imaging (MDI) Binary Level Codec"}
                if ($compression -eq "34719") {$compression = "Microsoft Document Imaging (MDI) Progressive Transform Codec"}
                if ($compression -eq "34720") {$compression = "Microsoft Document Imaging (MDI) Vector"}
                if ($compression -eq "34892") {$compression = "Lossy JPEG"}
                if ($compression -eq "65000") {$compression = "Kodak DCR Compressed"}
                if ($compression -eq "65535") {$compression = "Pentax PEF Compressed"}
                if ($compression -ne $null){$data.compression = $compression}
            } Catch {}
                           
            # Contrast
            Try { 
                $contrastProperty = $photo.GetPropertyItem(41992)
                if ($contrastProperty -ne $null){$contrast = [System.BitConverter]::ToUInt16($contrastProperty.Value, 0)}
                if ($contrast -eq "0") {$contrast = "Normal"}
                if ($contrast -eq "1") {$contrast = "Low"}
                if ($contrast -eq "2") {$contrast = "High"}
                if ($contrast -ne $null){$data.contrast = $contrast}
            } Catch {}

            # Custom Rendered
            Try { 
                $customRenderedProperty = $photo.GetPropertyItem(41985)
                if ($customRenderedProperty -ne $null){$customRendered = [System.BitConverter]::ToUInt16($customRenderedProperty.Value, 0)}
                if ($customRendered -eq "0") {$customRendered = "Normal"}
                if ($customRendered -eq "1") {$customRendered = "Custom"}
                if ($customRendered -ne $null){$data.customRendered = $customRendered}
            } Catch {}

            # Date Taken
            Try { 
                $dateTakenProperty = $photo.GetPropertyItem(36867)
                $dateTaken = (New-Object System.Text.UTF8Encoding).GetString($dateTakenProperty.Value)
                if ($dateTaken -ne $null){$data.dateTaken = $dateTaken}
            } Catch {}

            # Digital Zoom Ratio
            Try { 
                $digitalZoomRatioProperty = $photo.GetPropertyItem(41988)
                if ($digitalZoomRatioProperty -ne $null){$digitalZoomRatio = MakeNumber($digitalZoomRatioProperty)}
                if ($digitalZoomRatio -ne $null){$data.digitalZoomRatio = $digitalZoomRatio}
            } Catch {}
        
            # Exif Version
            Try { 
                $exifVersionProperty = $photo.GetPropertyItem(36864)
                if ($exifVersionProperty -ne $null){$exifVersion = (New-Object System.Text.UTF8Encoding).GetString($exifVersionProperty.Value)}
                if ($exifVersion -ne $null){$data.exifVersion = $exifVersion}
            } Catch {}
   
            # Exposure Time
            Try { 
                $exposureTimeProperty = $photo.GetPropertyItem(33434)
                if ($exposureTimeProperty -ne $null){$exposureTime = MakeNumber($exposureTimeProperty)}
                $exposureTime = $exposureTime  | Out-String
                if ($exposureTime -ne $null){$data.exposureTime = $exposureTime}
            } Catch {}
                
            # Exposure Compensation
            Try { 
                $exposureBiasProperty = $photo.GetPropertyItem(37380)
                if ($exposureBiasProperty -ne $null){$exposureBias = MakeNumber($exposureBiasProperty)}
                $exposureBias = $exposureBias  | Out-String
                if ($exposureBias -ne $null){$data.exposureBias = $exposureBias}
            } Catch {}
                
            # Exposure Mode
            Try { 
                $exposureModeProperty = $photo.GetPropertyItem(41986)
                if ($exposureModeProperty -ne $null){$exposureMode = [System.BitConverter]::ToUInt16($exposureModeProperty.Value, 0)}
                if ($exposureMode -eq "0") {$exposureMode = "Auto"}
                if ($exposureMode -eq "1") {$exposureMode = "Manual"}
                if ($exposureMode -eq "2") {$exposureMode = "Auto Bracket"}
                if ($exposureMode -ne $null){$data.exposureMode = $exposureMode}
            } Catch {}

            # File Name & Path
            $data.filepath = $filefullname
            $data.filename = $file

            # File Source
            Try { 
                $fileSourceProperty = $photo.GetPropertyItem(41728)
                if ($fileSourceProperty -ne $null){$fileSource = [System.BitConverter]::ToUInt16($fileSourceProperty.Value, 0)}
                if ($fileSource -eq "1") {$fileSource = "Film Scanner"}
                if ($fileSource -eq "2") {$fileSource = "Reflection Print Scanner"}
                if ($fileSource -eq "3") {$fileSource = "Digital Camera"}
                if ($fileSource -ne $null){$data.fileSource = $fileSource}
            } Catch {}

            # F-Stop
            Try { 
                $fstopProperty = $photo.GetPropertyItem(33437)
                if ($fstopProperty -ne $null){$fstop = MakeNumber($fstopProperty)}
                if ($fstop -ne $null){$data.fstop = $fstop}
            } Catch {}

            # Flash mode
            Try { 
                $flashProperty = $photo.GetPropertyItem(37385)
                if ($flashProperty -ne $null){$flash = [System.BitConverter]::ToUInt16($flashProperty.Value, 0)}
                if ($flash -eq "0")  {$flash = "No Flash"}
                if ($flash -eq "1")  {$flash = "Fired"}
                if ($flash -eq "5")  {$flash = "Fired, Return not detected"}
                if ($flash -eq "7")  {$flash = "Fired, Return detected"}
                if ($flash -eq "8")  {$flash = "On, Did not fire"}
                if ($flash -eq "9")  {$flash = "On, Fired"}
                if ($flash -eq "D")  {$flash = "On, Return not detected"}
                if ($flash -eq "F")  {$flash = "On, Return detected"}
                if ($flash -eq "10") {$flash = "Off, Did not fire"}
                if ($flash -eq "14") {$flash = "Off, Did not fire, Return not detected"}
                if ($flash -eq "15") {$flash = "On, Fired, Return not detected"}
                if ($flash -eq "16") {$flash = "On, Fired, Return detected"}
                if ($flash -eq "18") {$flash = "Auto, Did not fire"}
                if ($flash -eq "19") {$flash = "Auto, Fired"}
                if ($flash -eq "1D") {$flash = "Auto, Fired, Return not detected"}
                if ($flash -eq "1F") {$flash = "Auto, Fired, Return detected"}
                if ($flash -eq "20") {$flash = "No flash function"}
                if ($flash -eq "24") {$flash = "Auto, Did not fire"}
                if ($flash -eq "25") {$flash = "Auto, Fired"}
                if ($flash -eq "29") {$flash = "Auto, Fired, Return not detected"}
                if ($flash -eq "30") {$flash = "Off, No flash function"}
                if ($flash -eq "31") {$flash = "Auto, Fired, Return detected"}
                if ($flash -eq "41") {$flash = "Fired, Red-eye reduction"}
                if ($flash -eq "45") {$flash = "Fired, Red-eye reduction, Return not detected"}
                if ($flash -eq "47") {$flash = "Fired, Red-eye reduction, Return detected"}
                if ($flash -eq "49") {$flash = "On, Red-eye reduction"}
                if ($flash -eq "4D") {$flash = "On, Red-eye reduction, Return not detected"}
                if ($flash -eq "4F") {$flash = "On, Red-eye reduction, Return detected"}
                if ($flash -eq "50") {$flash = "Off, Red-eye reduction"}
                if ($flash -eq "58") {$flash = "Auto, Did not fire, Red-eye reduction"}
                if ($flash -eq "59") {$flash = "Auto, Fired, Red-eye reduction"}
                if ($flash -eq "5D") {$flash = "Auto, Fired, Red-eye reduction, Return not detected"}
                if ($flash -eq "5F") {$flash = "Auto, Fired, Red-eye reduction, Return detected"}
                if ($flash -eq "65") {$flash = "Fired, Red-eye reduction"}
                if ($flash -eq "69") {$flash = "Fired, Red-eye reduction, Return not detected"}
                if ($flash -eq "71") {$flash = "Fired, Red-eye reduction, Return detected"}
                if ($flash -eq "73") {$flash = "On, Fired, Red-eye reduction"}
                if ($flash -eq "77") {$flash = "On, Fired, Red-eye reduction, Return not detected"}
                if ($flash -eq "79") {$flash = "On, Fired, Red-eye reduction, Return detected"}
                if ($flash -eq "89") {$flash = "Auto, Fired, Red-eye reduction"}
                if ($flash -eq "93") {$flash = "Auto, Fired, Red-eye reduction, Return not detected"}
                if ($flash -eq "95") {$flash = "Auto, Fired, Red-eye reduction, Return detected"}
                if ($flash -ne $null){$data.flash = $flash}
            } Catch {}
           
            # Focal Length
            Try { 
                $focalLengthProperty =$photo.GetPropertyItem(37386)
                if ($focalLengthProperty -ne $null){$focalLength = MakeNumber($focalLengthProperty)}
                $focalLength = $focalLength  | Out-String
                if ($focalLength -ne $null){$data.focalLength = $focalLength}
            } Catch {}

            # Focal Length in 35mm Format
            Try { 
                $focalLength35mmFormatProperty = $photo.GetPropertyItem(41989)
                if ($focalLength35mmFormatProperty -ne $null){$focalLength35mmFormat = [System.BitConverter]::ToUInt16($focalLength35mmFormatProperty.Value, 0)}
                if ($focalLength35mmFormat -ne $null){$data.focalLength35mmFormat = $focalLength35mmFormat}
            } Catch {}
         
            # Gain Control
            Try { 
                $gainControlProperty = $photo.GetPropertyItem(41991)
                if ($gainControlProperty -ne $null){$gainControl = [System.BitConverter]::ToUInt16($gainControlProperty.Value, 0)}
                if ($gainControl -eq "0") {$gainControl = "None"}
                if ($gainControl -eq "1") {$gainControl = "Low Gain Up"}
                if ($gainControl -eq "2") {$gainControl = "High Gain Up"}
                if ($gainControl -eq "3") {$gainControl = "Low Gain Down"}
                if ($gainControl -eq "4") {$gainControl = "High Gain Down"}
                if ($gainControl -ne $null){$data.gainControl = $gainControl}
            } Catch {} 
                   
            # Height
            Try { 
                $heightProperty = $photo.GetPropertyItem(40963)
                if ($heightProperty -ne $null){$height = [System.BitConverter]::ToUInt16($heightProperty.Value, 0)}
                $height = $height  | Out-String
                if ($height -ne $null){$data.height = $height}
            } Catch {}
        
            # Height Resolution
            Try { 
                $heightResProperty = $photo.GetPropertyItem(283)
                if ($heightResProperty -ne $null){$heightRes = [System.BitConverter]::ToUInt16($heightResProperty.Value, 0)}
                $heightRes = $heightRes  | Out-String
                if ($heightRes -ne $null){$data.heightRes = $heightRes}
            } Catch {}
        
            # ISO
            Try { 
                $isoProperty = $photo.GetPropertyItem(34855)
                if ($isoProperty -ne $null){$iso = [System.BitConverter]::ToUInt16($isoProperty.Value, 0)}
                if ($iso -ne $null){$data.iso = $iso}
            } Catch {}

            # Light Source
            Try { 
                $lightSourceProperty = $photo.GetPropertyItem(37384)
                if ($lightSourceProperty -ne $null){$lightSource = [System.BitConverter]::ToUInt16($lightSourceProperty.Value, 0)}
                if ($lightSource -eq "0")   {$lightSource = "Auto"}
                if ($lightSource -eq "1")   {$lightSource = "Daylight"}
                if ($lightSource -eq "2")   {$lightSource = "Flourescent"}
                if ($lightSource -eq "3")   {$lightSource = "Tungsten"}
                if ($lightSource -eq "4")   {$lightSource = "Flash"}
                if ($lightSource -eq "9")   {$lightSource = "Fine Weather"}
                if ($lightSource -eq "10")  {$lightSource = "Cloudy Weather"}
                if ($lightSource -eq "11")  {$lightSource = "Shade"}
                if ($lightSource -eq "12")  {$lightSource = "Daylight Flourescent"}
                if ($lightSource -eq "13")  {$lightSource = "Day White Flourescent"}
                if ($lightSource -eq "14")  {$lightSource = "Cool White Flourescent"}
                if ($lightSource -eq "15")  {$lightSource = "White Flourescent"}
                if ($lightSource -eq "17")  {$lightSource = "Standard Light A"}
                if ($lightSource -eq "18")  {$lightSource = "Standard Light B"}
                if ($lightSource -eq "19")  {$lightSource = "Standard Light C"}
                if ($lightSource -eq "20")  {$lightSource = "D55"}
                if ($lightSource -eq "21")  {$lightSource = "D65"}
                if ($lightSource -eq "22")  {$lightSource = "D75"}
                if ($lightSource -eq "23")  {$lightSource = "D50"}
                if ($lightSource -eq "24")  {$lightSource = "ISO Studio Tungsten"}
                if ($lightSource -eq "255") {$lightSource = "Other Light Source"}
                if ($lightSource -ne $null){$data.lightSource = $lightSource}
            } Catch {} 
                     
            # Maker
            Try { 
                $cameraMakerProperty = $photo.GetPropertyItem(271)
                if ($cameraMakerProperty -ne $null){$cameraMaker = (New-Object System.Text.UTF8Encoding).GetString($cameraMakerProperty.Value)}
                if ($cameraMaker -ne $null){$data.cameraMaker = $cameraMaker}
            } Catch {}
     
            # Metering Mode
            Try { 
                $meteringModeProperty = $photo.GetPropertyItem(37383)
                if ($meteringModeProperty -ne $null){$meteringMode = [System.BitConverter]::ToUInt16($meteringModeProperty.Value, 0)}
                if ($metteringMode -eq "0")   {$metteringMode = "Unknown"}
                if ($metteringMode -eq "1")   {$metteringMode = "Average"}
                if ($metteringMode -eq "2")   {$metteringMode = "Center-Weighted Average"}
                if ($metteringMode -eq "3")   {$metteringMode = "Spot"}
                if ($metteringMode -eq "4")   {$metteringMode = "Multi-Spot"}
                if ($metteringMode -eq "5")   {$metteringMode = "Multi-Segment"}
                if ($metteringMode -eq "6")   {$metteringMode = "Partial"}
                if ($metteringMode -eq "255") {$metteringMode = "Other"}
                if ($metteringMode -ne $null){$data.metteringMode = $metteringMode}
            } Catch {}
        
            # Model
            Try { 
                $cameraModelProperty = $photo.GetPropertyItem(272)
                if ($cameraModelProperty -ne $null){$cameraModel = (New-Object System.Text.UTF8Encoding).GetString($cameraModelProperty.Value)}
                if ($cameraModel -ne $null){$data.cameraModel = $cameraModel}
            } Catch {}
        
            # Orientation
            Try { 
                $orientationProperty = $photo.GetPropertyItem(274)
                if ($orientationProperty -ne $null){$orientation = [System.BitConverter]::ToUInt16($orientationProperty.Value, 0)}
                if ($orientation -eq "1") {$orientation = "Horizontal"}
                if ($orientation -eq "2") {$orientation = "Mirror Horizontal"}
                if ($orientation -eq "3") {$orientation = "Rotate 180°"}
                if ($orientation -eq "4") {$orientation = "Mirror Vertical"}
                if ($orientation -eq "5") {$orientation = "Mirror Horizontal & Rotate 180°"}
                if ($orientation -eq "6") {$orientation = "Rotate 90°clockwise"}
                if ($orientation -eq "7") {$orientation = "Mirror Horizontal & Rotate 90°clockwise"}
                if ($orientation -eq "8") {$orientation = "Rotate 270°clockwise"}
                if ($orientation -ne $null){$data.orientation = $orientation}
            } Catch {}
        
            # Saturation
            Try { 
                $saturationProperty = $photo.GetPropertyItem(41993)
                if ($saturationProperty -ne $null){$saturation = [System.BitConverter]::ToUInt16($saturationProperty.Value, 0)}
                if ($saturation -eq "0") {$saturation = "Normal"}
                if ($saturation -eq "1") {$saturation = "Low"}
                if ($saturation -eq "2") {$saturation = "High"}
                if ($saturation -ne $null){$data.saturation = $saturation}
            } Catch {}
        
            # Scene Type
            Try { 
                $sceneTypeProperty = $photo.GetPropertyItem(41991)
                if ($sceneTypeProperty -ne $null){$sceneType = [System.BitConverter]::ToUInt16($sceneTypeProperty.Value, 0)}
                if ($sceneType -eq "0") {$sceneType = "Standard"}
                if ($sceneType -eq "1") {$sceneType = "Landscape"}
                if ($sceneType -eq "2") {$sceneType = "Portrait"}
                if ($sceneType -eq "3") {$sceneType = "Night"}
                if ($sceneType -ne $null){$data.sceneType = $sceneType}
            } Catch {}
 
            # Sensing Method
            Try { 
                $sensingMethodProperty = $photo.GetPropertyItem(41495)
                if ($sensingMethodProperty -ne $null){$sensingMethod = [System.BitConverter]::ToUInt16($sensingMethodProperty.Value, 0)}
                if ($sensingMethod -eq "1") {$sensingMethod = "No Defined"}
                if ($sensingMethod -eq "2") {$sensingMethod = "One-Chip Color Area"}
                if ($sensingMethod -eq "3") {$sensingMethod = "Two-Chip Colour Area"}
                if ($sensingMethod -eq "4") {$sensingMethod = "Three-Chip Color Area"}
                if ($sensingMethod -eq "5") {$sensingMethod = "Color Sequential Area"}
                if ($sensingMethod -eq "7") {$sensingMethod = "Trilinear"}
                if ($sensingMethod -eq "8") {$sensingMethod = "Color Sequential Linear"}
                if ($sensingMethod -ne $null){$data.sensingMethod = $sensingMethod}
            } Catch {}
         
            # Sharpness
            Try { 
                $sharpnessProperty = $photo.GetPropertyItem(41994)
                if ($sharpnessProperty -ne $null){$sharpness = [System.BitConverter]::ToUInt16($sharpnessProperty.Value, 0)}
                if ($sharpness -eq "0") {$sharpness = "Normal"}
                if ($sharpness -eq "1") {$sharpness = "Soft"}
                if ($sharpness -eq "2") {$sharpness = "Hard"}
                if ($sharpness -ne $null){$data.sharpness = $sharpness}
            } Catch {}

            # Shutter Speed
            Try { 
                $shutterProperty = $photo.GetPropertyItem(37377)
                if ($shutterProperty -ne $null){$shutter = MakeNumber($shutterProperty)}
                $shutter = $shutter  | Out-String
                if ($shutter -ne $null){$data.shutter = $shutter}
            } Catch {}

            # Software
            Try { 
                $cameraSoftwareProperty = $photo.GetPropertyItem(305)
                if ($cameraSoftwareProperty -ne $null){$cameraSoftware = (New-Object System.Text.UTF8Encoding).GetString($cameraSoftwareProperty.Value)}
                if ($cameraSoftware -ne $null){$data.cameraSoftware = $cameraSoftware}
            } Catch {}
                
            # Subject Distance
            Try { 
                $subjectDistanceProperty = $photo.GetPropertyItem(37382)
                if ($subjectDistanceProperty -ne $null){$subjectDistance = MakeNumber($subjectDistanceProperty)}
                $subjectDistance = $subjectDistance  | Out-String
                if ($subjectDistance -ne $null){$data.subjectDistance = $subjectDistance}
            } Catch {}

            # Subject Distance Range
            Try { 
                $subjectDistanceRangeProperty = $photo.GetPropertyItem(41495)
                if ($subjectDistanceRangeProperty -ne $null){$subjectDistanceRange = [System.BitConverter]::ToUInt16($subjectDistanceRangeProperty.Value, 0)}
                if ($subjectDistanceRange -eq "0") {$subjectDistanceRange = "Unknown"}
                if ($subjectDistanceRange -eq "1") {$subjectDistanceRange = "Macro"}
                if ($subjectDistanceRange -eq "2") {$subjectDistanceRange = "Close"}
                if ($subjectDistanceRange -eq "3") {$subjectDistanceRange = "Distant"}
                if ($subjectDistanceRange -ne $null){$data.subjectDistanceRange = $subjectDistanceRange}
            } Catch {}
                 
            # White Balance
            Try { 
                $whiteBalanceProperty = $photo.GetPropertyItem(41987)
                if ($whiteBalanceProperty -ne $null){$whiteBalance = [System.BitConverter]::ToUInt16($whiteBalanceProperty.Value, 0)}
                if ($whiteBalance -eq "0") {$whiteBalance = "Auto"}
                if ($whiteBalance -eq "1") {$whiteBalance = "Manual"}
                if ($whiteBalance -ne $null){$data.whiteBalance = $whiteBalance}
            } Catch {}

            # Width
            Try { 
                $widthProperty = $photo.GetPropertyItem(40962)
                if ($widthProperty -ne $null){$width = [System.BitConverter]::ToUInt16($widthProperty.Value, 0)}
                $width = $width  | Out-String
                if ($widthProperty -ne $null){$data.width = $width}
            } Catch {}
        
            # width Resoluton
            Try { 
                $widthResProperty =$photo.GetPropertyItem(282)
                if ($widthResProperty -ne $null){$widthRes = [System.BitConverter]::ToUInt16($widthResProperty.Value, 0)}
                $widthRes = $widthRes  | Out-String
                if ($widthRes -ne $null){$data.widthRes = $widthRes}
            } Catch {}

            #add row
            $global:output += $data
        } # End $imageType Check

    } # End Foreach $file in selected folder

    #write output
    $statusLabel.Text = "Complete!"
    $outputFile = $global:folderName + "\"  + "ExifInfo" + ".csv"
    $global:output | Export-CSV $outputFile -NoTypeInformation
} # End processFiles Function

function selectFolder {
    $statusLabel.Text = "Ready!"
	$selectForm = New-Object System.Windows.Forms.FolderBrowserDialog
	$getKey = $selectForm.ShowDialog()
	If ($getKey -eq "OK") {
        	$textBoxIn.Text = $selectForm.SelectedPath
	}
} # End SelectFolder

function MakeNumber {
    $first =$args[0].value[0] + 256 * $args[0].value[1] + 65536 * $args[0].value[2] + 16777216 * $args[0].value[3] ;
    $second=$args[0].value[4] + 256 * $args[0].value[5] + 65536 * $args[0].value[6] + 16777216 * $args[0].value[7] ; 
    if ($first -gt 2147483648) {$first  = $first  - 4294967296} ;
    if ($second -gt 2147483648) {$second= $second - 4294967296} ;
    if ($second -eq 0) {$second= 1} ; 
    if (($first –eq 1) -and ($second -ne 1)) {
        write-output ("1/" + $second)} 
    else {
        write-output ($first / $second)}
} # End Function MakeNumber

[void] $mainForm.ShowDialog()