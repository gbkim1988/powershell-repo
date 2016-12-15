# Set-ExecutionPolicy 명령을 건드리지 않고 파워쉘 스크립트 파일을 실행하는 방법

#http://stackoverflow.com/questions/13724940/how-to-run-a-powershell-script-from-the-command-line-and-pass-a-directory-as-a-p

powershell -executionPolicy bypass -noexit -file "c:\temp\test.ps1" "c:\test with space"
