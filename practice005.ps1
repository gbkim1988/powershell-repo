<#
    [0] Foreach and ForEach-Object 

    Get-Alias -Definition ForEach-Object

    Why in the world are there two ForEach options in Windows Powershell?
    > When you are piping input into ForEach, it is the alias for ForEach-
    Object. But when you place ForEach at the begining of the line, it is
    a Windows PowerShell statement.

    ForEach-Object 는 pipeline을 통해 데이터를 보낼때 사용된다. 이는 객체 스트림
    을 다음 명령으로 지속적으로 계속해서 전송할 수 있기 때문. 반면, ForEach는 파이
    프라인에 연결할 경우 에러를 발생한다. ForEach를 파이프라인에 연결하려면 객체에
    할당 후 파이프라인을 연결하는 방식으로 가능하다. 

#>

Get-Alias -Definition ForEach-Object