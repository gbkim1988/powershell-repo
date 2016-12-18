# Text2Speech Demo

Param(
    [alias("r")]$Rate,
    [alias("v")]$Volume,
    [alias("p")]$Person,
    [alias("t")]$Text
)
$Voice = New-Object -com SAPI.SpVoice
$Voice.rate = $Rate
$Voice.volume = $Volume
$VoiceToUse = $Voice.GetVoices($Person)
$Voice.voice = $VoiceToUse.Item(0)
$Text2Speak = $Text
[void] $Voice.Speak($Text2Speak)