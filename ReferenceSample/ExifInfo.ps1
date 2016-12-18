###########################################################
# ExifInfo.ps1
#
# Wayne Lindimore
# wlindimore@gmail.com
# AdminsCache.Wordpress.com
#
# 9-15-13
# Read Image File EXIF MetaData
###########################################################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Font = "Comic Sans MS,8.25"
$mainForm.Text = " Image File Exif MetaData"
$mainForm.ForeColor = "White"
$mainForm.BackColor = "DarkBlue"
$mainForm.width = 400
$mainForm.height = 680

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Font = "Comic Sans MS,12"
$titleLabel.ForeColor = "Yellow"
$titleLabel.Location = "95,10"
$titleLabel.Size = "300,30"
$titleLabel.Text = "Image File EXIF MetaData"
$mainForm.Controls.Add($titleLabel)

# Form Labels
$cameraMakerLabel = New-Object System.Windows.Forms.Label
$cameraMakerLabel.Font = "Comic Sans MS,8"
$cameraMakerLabel.Location = "20,50"
$cameraMakerLabel.Size = "120,15"
$cameraMakerLabel.Text = "Camera Maker"
$mainForm.Controls.Add($cameraMakerLabel)
$cameraModelLabel = New-Object System.Windows.Forms.Label
$cameraModelLabel.Font = "Comic Sans MS,8"
$cameraModelLabel.Location = "20,75"
$cameraModelLabel.Size = "120,15"
$cameraModelLabel.Text = "Camera Model"
$mainForm.Controls.Add($cameraModelLabel)
$colorSpaceLabel = New-Object System.Windows.Forms.Label
$colorSpaceLabel.Font = "Comic Sans MS,8"
$colorSpaceLabel.Location = "20,100"
$colorSpaceLabel.Size = "120,15"
$colorSpaceLabel.Text = "Color Space"
$mainForm.Controls.Add($colorSpaceLabel)
$contrastLabel = New-Object System.Windows.Forms.Label
$contrastLabel.Font = "Comic Sans MS,8"
$contrastLabel.Location = "20,125"
$contrastLabel.Size = "120,15"
$contrastLabel.Text = "Contrast"
$mainForm.Controls.Add($contrastLabel)
$dateTakenLabel = New-Object System.Windows.Forms.Label
$dateTakenLabel.Font = "Comic Sans MS,8"
$dateTakenLabel.Location = "20,150"
$dateTakenLabel.Size = "120,15"
$dateTakenLabel.Text = "Date Taken"
$mainForm.Controls.Add($dateTakenLabel)
$exposureModeLabel = New-Object System.Windows.Forms.Label
$exposureModeLabel.Font = "Comic Sans MS,8"
$exposureModeLabel.Location = "20,175"
$exposureModeLabel.Size = "120,15"
$exposureModeLabel.Text = "Exposure Mode"
$mainForm.Controls.Add($exposureModeLabel)
$exposureTimeLabel = New-Object System.Windows.Forms.Label
$exposureTimeLabel.Font = "Comic Sans MS,8"
$exposureTimeLabel.Location = "20,200"
$exposureTimeLabel.Size = "120,15"
$exposureTimeLabel.Text = "Exposure Time"
$mainForm.Controls.Add($exposureTimeLabel)
$fstopLabel = New-Object System.Windows.Forms.Label
$fstopLabel.Font = "Comic Sans MS,8"
$fstopLabel.Location = "20,225"
$fstopLabel.Size = "120,15"
$fstopLabel.Text = "f/Stop"
$mainForm.Controls.Add($fstopLabel)
$fileNameLabel = New-Object System.Windows.Forms.Label
$fileNameLabel.Font = "Comic Sans MS,8"
$fileNameLabel.Location = "20,250"
$fileNameLabel.Size = "120,15"
$fileNameLabel.Text = "Filename"
$mainForm.Controls.Add($fileNameLabel)
$flashLabel = New-Object System.Windows.Forms.Label
$flashLabel.Font = "Comic Sans MS,8"
$flashLabel.Location = "20,275"
$flashLabel.Size = "120,15"
$flashLabel.Text = "Flash Mode"
$mainForm.Controls.Add($flashLabel)
$focalLabel = New-Object System.Windows.Forms.Label
$focalLabel.Font = "Comic Sans MS,8"
$focalLabel.Location = "20,300"
$focalLabel.Size = "120,15"
$focalLabel.Text = "Focal Length"
$mainForm.Controls.Add($focalLabel)
$heightLabel = New-Object System.Windows.Forms.Label
$heightLabel.Font = "Comic Sans MS,8"
$heightLabel.Location = "20,325"
$heightLabel.Size = "120,15"
$heightLabel.Text = "Height"
$mainForm.Controls.Add($heightLabel)
$heightResLabel = New-Object System.Windows.Forms.Label
$heightResLabel.Font = "Comic Sans MS,8"
$heightResLabel.Location = "20,350"
$heightResLabel.Size = "120,15"
$heightResLabel.Text = "Height Resolution"
$mainForm.Controls.Add($heightResLabel)
$isoLabel = New-Object System.Windows.Forms.Label
$isoLabel.Font = "Comic Sans MS,8"
$isoLabel.Location = "20,375"
$isoLabel.Size = "120,15"
$isoLabel.Text = "ISO"
$mainForm.Controls.Add($isoLabel)
$meterLabel = New-Object System.Windows.Forms.Label
$meterLabel.Font = "Comic Sans MS,8"
$meterLabel.Location = "20,400"
$meterLabel.Size = "120,15"
$meterLabel.Text = "Metering Mode"
$mainForm.Controls.Add($meterLabel)
$orientationLabel = New-Object System.Windows.Forms.Label
$orientationLabel.Font = "Comic Sans MS,8"
$orientationLabel.Location = "20,425"
$orientationLabel.Size = "120,15"
$orientationLabel.Text = "Orientation"
$mainForm.Controls.Add($orientationLabel)
$saturationLabel = New-Object System.Windows.Forms.Label
$saturationLabel.Font = "Comic Sans MS,8"
$saturationLabel.Location = "20,450"
$saturationLabel.Size = "120,15"
$saturationLabel.Text = "Saturation"
$mainForm.Controls.Add($saturationLabel)
$sceneTypeLabel = New-Object System.Windows.Forms.Label
$sceneTypeLabel.Font = "Comic Sans MS,8"
$sceneTypeLabel.Location = "20,475"
$sceneTypeLabel.Size = "120,15"
$sceneTypeLabel.Text = "Scene Type"
$mainForm.Controls.Add($sceneTypeLabel)
$sharpnessLabel = New-Object System.Windows.Forms.Label
$sharpnessLabel.Font = "Comic Sans MS,8"
$sharpnessLabel.Location = "20,500"
$sharpnessLabel.Size = "120,15"
$sharpnessLabel.Text = "Sharpness"
$mainForm.Controls.Add($sharpnessLabel)
$whiteBalanceLabel = New-Object System.Windows.Forms.Label
$whiteBalanceLabel.Font = "Comic Sans MS,8"
$whiteBalanceLabel.Location = "20,525"
$whiteBalanceLabel.Size = "120,15"
$whiteBalanceLabel.Text = "White Balance"
$mainForm.Controls.Add($whiteBalanceLabel)
$widthLabel = New-Object System.Windows.Forms.Label
$widthLabel.Font = "Comic Sans MS,8"
$widthLabel.Location = "20,550"
$widthLabel.Size = "120,15"
$widthLabel.Text = "Width"
$mainForm.Controls.Add($widthLabel)
$widthResLabel = New-Object System.Windows.Forms.Label
$widthResLabel.Font = "Comic Sans MS,8"
$widthResLabel.Location = "20,575"
$widthResLabel.Size = "120,15"
$widthResLabel.Text = "Width Resolution"
$mainForm.Controls.Add($widthResLabel)
        
# Form TextBoxes
$cameraMakerTextBox = New-Object System.Windows.Forms.TextBox
$cameraMakerTextBox.Font = "Comic Sans MS,8"
$cameraMakerTextBox.Location = "140,50"
$cameraMakerTextBox.Size = "200,15"
$mainForm.Controls.Add($cameraMakerTextBox)
$cameraModelTextBox = New-Object System.Windows.Forms.TextBox
$cameraModelTextBox.Font = "Comic Sans MS,8"
$cameraModelTextBox.Location = "140,75"
$cameraModelTextBox.Size = "200,15"
$mainForm.Controls.Add($cameraModelTextBox)
$colorSpaceTextBox = New-Object System.Windows.Forms.TextBox
$colorSpaceTextBox.Font = "Comic Sans MS,8"
$colorSpaceTextBox.Location = "140,100"
$colorSpaceTextBox.Size = "200,15"
$mainForm.Controls.Add($colorSpaceTextBox)
$contrastTextBox = New-Object System.Windows.Forms.TextBox
$contrastTextBox.Font = "Comic Sans MS,8"
$contrastTextBox.Location = "140,125"
$contrastTextBox.Size = "200,15"
$mainForm.Controls.Add($contrastTextBox)
$dateTakenTextBox = New-Object System.Windows.Forms.TextBox
$dateTakenTextBox.Font = "Comic Sans MS,8"
$dateTakenTextBox.Location = "140,150"
$dateTakenTextBox.Size = "200,15"
$mainForm.Controls.Add($dateTakenTextBox)
$exposureModeTextBox = New-Object System.Windows.Forms.TextBox
$exposureModeTextBox.Font = "Comic Sans MS,8"
$exposureModeTextBox.Location = "140,175"
$exposureModeTextBox.Size = "200,15"
$mainForm.Controls.Add($exposureModeTextBox)
$exposureTimeTextBox = New-Object System.Windows.Forms.TextBox
$exposureTimeTextBox.Font = "Comic Sans MS,8"
$exposureTimeTextBox.Location = "140,200"
$exposureTimeTextBox.Size = "200,15"
$mainForm.Controls.Add($exposureTimeTextBox)
$fstopTextBox = New-Object System.Windows.Forms.TextBox
$fstopTextBox.Font = "Comic Sans MS,8"
$fstopTextBox.Location = "140,225"
$fstopTextBox.Size = "200,15"
$mainForm.Controls.Add($fstopTextBox)
$fileNameTextBox = New-Object System.Windows.Forms.TextBox
$fileNameTextBox.Font = "Comic Sans MS,8"
$fileNameTextBox.Location = "140,250"
$fileNameTextBox.Size = "200,15"
$mainForm.Controls.Add($fileNameTextBox)
$flashTextBox = New-Object System.Windows.Forms.TextBox
$flashTextBox.Font = "Comic Sans MS,8"
$flashTextBox.Location = "140,275"
$flashTextBox.Size = "200,15"
$mainForm.Controls.Add($flashTextBox)
$focalTextBox = New-Object System.Windows.Forms.TextBox
$focalTextBox.Font = "Comic Sans MS,8"
$focalTextBox.Location = "140,300"
$focalTextBox.Size = "200,15"
$mainForm.Controls.Add($focalTextBox)
$heightTextBox = New-Object System.Windows.Forms.TextBox
$heightTextBox.Font = "Comic Sans MS,8"
$heightTextBox.Location = "140,325"
$heightTextBox.Size = "200,15"
$mainForm.Controls.Add($heightTextBox)
$heightResTextBox = New-Object System.Windows.Forms.TextBox
$heightResTextBox.Font = "Comic Sans MS,8"
$heightResTextBox.Location = "140,350"
$heightResTextBox.Size = "200,15"
$mainForm.Controls.Add($heightResTextBox)
$isoTextBox = New-Object System.Windows.Forms.TextBox
$isoTextBox.Font = "Comic Sans MS,8"
$isoTextBox.Location = "140,375"
$isoTextBox.Size = "200,15"
$mainForm.Controls.Add($isoTextBox)
$meterTextBox = New-Object System.Windows.Forms.TextBox
$meterTextBox.Font = "Comic Sans MS,8"
$meterTextBox.Location = "140,400"
$meterTextBox.Size = "200,15"
$mainForm.Controls.Add($meterTextBox)
$orientationTextBox = New-Object System.Windows.Forms.TextBox
$orientationTextBox.Font = "Comic Sans MS,8"
$orientationTextBox.Location = "140,425"
$orientationTextBox.Size = "200,15"
$mainForm.Controls.Add($orientationTextBox)
$saturationTextBox = New-Object System.Windows.Forms.TextBox
$saturationTextBox.Font = "Comic Sans MS,8"
$saturationTextBox.Location = "140,450"
$saturationTextBox.Size = "200,15"
$mainForm.Controls.Add($saturationTextBox)
$sceneTypeTextBox = New-Object System.Windows.Forms.TextBox
$sceneTypeTextBox.Font = "Comic Sans MS,8"
$sceneTypeTextBox.Location = "140,475"
$sceneTypeTextBox.Size = "200,15"
$mainForm.Controls.Add($sceneTypeTextBox)
$sharpnessTextBox = New-Object System.Windows.Forms.TextBox
$sharpnessTextBox.Font = "Comic Sans MS,8"
$sharpnessTextBox.Location = "140,500"
$sharpnessTextBox.Size = "200,15"
$mainForm.Controls.Add($sharpnessTextBox)
$whiteBalanceTextBox = New-Object System.Windows.Forms.TextBox
$whiteBalanceTextBox.Font = "Comic Sans MS,8"
$whiteBalanceTextBox.Location = "140,525"
$whiteBalanceTextBox.Size = "200,15"
$mainForm.Controls.Add($whiteBalanceTextBox)
$widthTextBox = New-Object System.Windows.Forms.TextBox
$widthTextBox.Font = "Comic Sans MS,8"
$widthTextBox.Location = "140,550"
$widthTextBox.Size = "200,15"
$mainForm.Controls.Add($widthTextBox)
$widthResTextBox = New-Object System.Windows.Forms.TextBox
$widthResTextBox.Font = "Comic Sans MS,8"
$widthResTextBox.Location = "140,575"
$widthResTextBox.Size = "200,15"
$mainForm.Controls.Add($widthResTextBox)

# SelectFile Button
$imageFileNameButton = New-Object System.Windows.Forms.Button 
$imageFileNameButton.Font = "Comic Sans MS,8"
$imageFileNameButton.Location = "30,612"
$imageFileNameButton.Size = "75,23"
$imageFileNameButton.ForeColor = "DarkBlue"
$imageFileNameButton.BackColor = "White"
$imageFileNameButton.Text = "Select File"
$imageFileNameButton.add_Click({selectFile})
$mainForm.Controls.Add($imageFileNameButton)

# Exit Button 
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "270,612"
$exitButton.Size = "75,23"
$exitButton.ForeColor = "Red"
$exitButton.BackColor = "White"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

function selectFile {
    $selectForm = New-Object System.Windows.Forms.OpenFileDialog
    $selectForm.Filter = "All Files (*.*)|*.*"
    $selectForm.InitialDirectory = ".\"
    $selectForm.Title = "Select a Image File to Process"
    $getKey = $selectForm.ShowDialog()
    If ($getKey -eq "OK") {
        $filename = $selectForm.FileName
        $photo = [System.Drawing.Image]::FromFile($filename)

        # Color Space
        $colorProperty = $photo.GetPropertyItem(40961)
        if ($colorProperty -ne $null){
            $colorSpace = [System.BitConverter]::ToUInt16($colorProperty.Value, 0)}
        if ($colorSpace -eq "1") {$colorSpace = "sRGB"}
        if ($colorSpace -eq "2") {$colorSpace = "Adobe RGB"}
        if ($colorSpace -eq "65535") {$colorSpace = "Uncalibrated"}
        $colorSpaceTextBox.Text = $colorSpace
        
        # Contrast
        $contrastProperty = $photo.GetPropertyItem(41992)
        if ($contrastProperty -ne $null){
            $contrast = [System.BitConverter]::ToUInt16($contrastProperty.Value, 0)}
        if ($contrast -eq "0") {$contrast = "Normal"}
        if ($contrast -eq "1") {$contrast = "Low"}
        if ($contrast -eq "2") {$contrast = "High"}
        $contrastTextBox.Text = $contrast

        
        # Date Taken
        $dateProperty = $photo.GetPropertyItem(36867)
        $dateTaken = (New-Object System.Text.UTF8Encoding).GetString($dateProperty.Value)
        $dateTakenTextBox.Text = $dateTaken
        
        # Exposure time
        $exposureTimeProperty = $photo.GetPropertyItem(33434)
        if ($exposureTimeProperty -ne $null){
            $exposureTime = MakeNumber($exposureTimeProperty)}
        $exposureTime = $exposureTime  | Out-String
        $exposureTimeTextBox.Text = $exposureTime + " sec"
                
        # Exposure Mode
        $exposureModeProperty = $photo.GetPropertyItem(41986)
        if ($exposureModeProperty -ne $null){
            $exposureMode = [System.BitConverter]::ToUInt16($exposureModeProperty.Value, 0)}
        if ($exposureMode -eq "0") {$exposureMode = "Auto"}
        if ($exposureMode -eq "1") {$exposureMode = "Manual"}
        if ($exposureMode -eq "2") {$exposureMode = "Auto Bracket"}
        $exposureModeTextBox.Text = $exposureMode
        
        # F-Stop
        $fstopProperty = $photo.GetPropertyItem(33437)
        if ($fstopProperty -ne $null){
            $fstop = MakeNumber($fstopProperty)}
        $fstopTextBox.Text = "f/" + $fstop

        # Filename
        $fileNameTextBox.Text = $fileName

        # Flash mode
        $flashProperty = $photo.GetPropertyItem(37385)
        if ($flashProperty -ne $null){
            $flash = [System.BitConverter]::ToUInt16($flashProperty.Value, 0)}
        if ($flash -eq "0") {$flash = "No Flash"}
        if ($flash -eq "1") {$flash = "Fired"}
        if ($flash -eq "5") {$flash = "Fired, Return not detected"}
        if ($flash -eq "7") {$flash = "Fired, Return detected"}
        if ($flash -eq "8") {$flash = "On, Did not fire"}
        if ($flash -eq "9") {$flash = "On, Fired"}
        if ($flash -eq "D") {$flash = "On, Return not detected"}
        if ($flash -eq "F") {$flash = "On, Return detected"}
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
        $flashTextBox.Text = $flash
           
        # Focal Length
        $focalProperty =$photo.GetPropertyItem(37386)
        if ($focalProperty -ne $null){
            $focal = MakeNumber($focalProperty)}
        $focal = $focal  | Out-String
        $focalTextBox.Text = $focal + " mm"
        
        # Height
        $heightProperty = $photo.GetPropertyItem(40963)
        if ($heightProperty -ne $null){
            $height = [System.BitConverter]::ToUInt16($heightProperty.Value, 0)}
        $height = $height  | Out-String
        $heightTextBox.Text = $height + " pixels"
        
        # Height Resolution
        $heightResProperty = $photo.GetPropertyItem(283)
        if ($heightResProperty -ne $null){
            $heightRes = [System.BitConverter]::ToUInt16($heightResProperty.Value, 0)}
        $heightRes = $heightRes  | Out-String
        $heightResTextBox.Text = $heightRes + " dpi"
        
        # ISO
        $isoProperty = $photo.GetPropertyItem(34855)
        if ($isoProperty -ne $null){
            $iso = [System.BitConverter]::ToUInt16($isoProperty.Value, 0)}
        $isoTextBox.Text = "ISO-" + $iso
        
        # Maker
        $cameraMakerProperty = $photo.GetPropertyItem(271)
        $cameraMaker = (New-Object System.Text.UTF8Encoding).GetString($cameraMakerProperty.Value)
        $cameraMakerTextBox.Text = $cameraMaker
     
        # Metering mode
        $meteringProperty = $photo.GetPropertyItem(37383)
        if ($meteringProperty -ne $null){
            $metering = [System.BitConverter]::ToUInt16($meteringProperty.Value, 0)}
        if ($metering -eq "0") {$metering = "Unknown"}
        if ($metering -eq "1") {$metering = "Average"}
        if ($metering -eq "2") {$metering = "Center-weighted Average"}
        if ($metering -eq "3") {$metering = "Spot"}
        if ($metering -eq "4") {$metering = "Multi-spot"}
        if ($metering -eq "5") {$metering = "Multi-segment"}
        if ($metering -eq "6") {$metering = "Partial"}
        if ($metering -eq "255") {$metering = "Other"}
        $meterTextBox.Text = $metering
        
        # Model
        $cameraModelProperty = $photo.GetPropertyItem(272)
        $cameraModel = (New-Object System.Text.UTF8Encoding).GetString($cameraModelProperty.Value)
        $cameraModelTextBox.Text = $cameraModel
        
        # Orientation
        $orientationProperty = $photo.GetPropertyItem(274)
        if ($orientationProperty -ne $null){
            $orientation = [System.BitConverter]::ToUInt16($orientationProperty.Value, 0)}
        if ($orientation -eq "1") {$orientation = "Horizontal"}
        if ($orientation -eq "2") {$orientation = "Mirror Horizontal"}
        if ($orientation -eq "3") {$orientation = "Rotate 180°"}
        if ($orientation -eq "4") {$orientation = "Mirror Vertical"}
        if ($orientation -eq "5") {$orientation = " Mirror Horizontal & Rotate 180°"}
        if ($orientation -eq "6") {$orientation = "Rotate 90°clockwise"}
        if ($orientation -eq "7") {$orientation = "Mirror Horizontal & Rotate 90°clockwise"}
        if ($orientation -eq "8") {$orientation = "Rotate 270°clockwise"}
        $orientationTextBox.Text = $orientation
        
        # Saturation
        $saturationProperty = $photo.GetPropertyItem(41993)
        if ($saturationProperty -ne $null){
            $saturation = [System.BitConverter]::ToUInt16($saturationProperty.Value, 0)}
        if ($saturation -eq "0") {$saturation = "Normal"}
        if ($saturation -eq "1") {$saturation = "Low"}
        if ($saturation -eq "2") {$saturation = "High"}
        $saturationTextBox.Text = $saturation
        
        # Scene Type
        $sceneTypeProperty = $photo.GetPropertyItem(41991)
        if ($sceneTypeProperty -ne $null){
            $sceneType = [System.BitConverter]::ToUInt16($sceneTypeProperty.Value, 0)}
        if ($sceneType -eq "0") {$sceneType = "Standard"}
        if ($sceneType -eq "1") {$sceneType = "Landscape"}
        if ($sceneType -eq "2") {$sceneType = "Portrait"}
        if ($sceneType -eq "3") {$sceneType = "Night"}
        $sceneTypeTextBox.Text = $sceneType

        
        # Sharpness
        $sharpnessProperty = $photo.GetPropertyItem(41994)
        if ($sharpnessProperty -ne $null){
            $sharpness = [System.BitConverter]::ToUInt16($sharpnessProperty.Value, 0)}
        if ($sharpness -eq "0") {$sharpness = "Normal"}
        if ($sharpness -eq "1") {$sharpness = "Soft"}
        if ($sharpness -eq "2") {$sharpness = "Hard"}
        $sharpnessTextBox.Text = $sharpness
        
        # White Balance
        $whiteBalanceProperty = $photo.GetPropertyItem(41987)
        if ($whiteBalanceProperty -ne $null){
            $whiteBalance = [System.BitConverter]::ToUInt16($whiteBalanceProperty.Value, 0)}
        if ($whiteBalance -eq "0") {$whiteBalance = "Auto"}
        if ($whiteBalance -eq "1") {$whiteBalance = "Manual"}
        $whiteBalanceTextBox.Text = $whiteBalance

        # Width
        $widthProperty = $photo.GetPropertyItem(40962)
        if ($widthProperty -ne $null){
            $width = [System.BitConverter]::ToUInt16($widthProperty.Value, 0)}
        $width = $width  | Out-String
        $widthTextBox.Text = $width + " pixels"
        
        # width Resoluton
        $widthResProperty =$photo.GetPropertyItem(282)
        if ($widthResProperty -ne $null){
            $widthRes = [System.BitConverter]::ToUInt16($widthResProperty.Value, 0)}
        $widthRes = $widthRes  | Out-String
        $widthResTextBox.Text = $widthRes + " dpi"

    } # End $getkey If
} # End SelectFile Function

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