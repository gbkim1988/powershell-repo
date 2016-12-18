<#
[0] cmdletBinding 키워드의 의미 (The Scripting Guys)
    https://blogs.technet.microsoft.com/heyscriptingguy/2012/07/07/weekend-scripter-cmdletbinding-attribute-simplifies-powershell-functions/
    cmdletBinding 은 attribute 이며 Powershell 함수를 단순화한다. 
    효과 : additional parameter checking, the ability to easily use the Write-Verbose cmdlet 
    [] -> attribute tag 라고 부름 
    필요조건 : param 키워드 사용
    
    만약 파라미터가 필요하지 않은 함수라면 다음과 같이 작성할 수 있다. 
    Pattern1 ::=
    function my-function
    { 
        [cmdletBinding()]
        Param()
    }

    Pattern1-Usage ::= 
    function my-function
    {
        [cmdletBinding()]
        Param()
        Write-Verbose "verbose stream"
    }

[1] VerbosePreference 사용 방법
    출처 : https://technet.microsoft.com/ko-KR/library/dd315274.aspx
    
    Write-Verbose cmdlet 은 호출 시 출력문자열이 보이지 않는다. 
    그 이유는 switch 설정이 -Verbose 가 아니기 때문이다. 이 Verbose switch를 설정하는
    방법은 두 가지인데 Write-Verbose "" -Verbose 처럼 일일이 걸어주는 방법과 
    $VerbosePreference = "Continue" 문구를 적시하는 방법이다. 

    verbose 메시지는 다음의 경우 유용하게 사용될 수 있다.
    - remote connection
    - loading modules
    - for debugging message
[2] cmdletBinding 의 기능 
    출처 : https://blogs.technet.microsoft.com/heyscriptingguy/2012/07/07/weekend-scripter-cmdletbinding-attribute-simplifies-powershell-functions/

    Automatic parameter checks 
    - Param($a) 라고 두는 경우 -a 옵션을 지정해야 파라미터로 받아들인다. 
      만약 Param($a) 라고 쓰고 -b, -c 옵션을 제공하면 인식하지 않는다.
      이는 cmdletBinding attribute tag를 설정하지 않았을 경우 현상이다. 
      cmdletBinding attribute tag 를 설정하면 파라미터 검증을 자동으로 
      수행하므로 이러한 현상은 발생하지 않는다. 
#>
    $args.count
$VerbosePreference = "Continue"
function my_function
{
    #[cmdletBinding()]
    Param($a, $b, $c)
    Write-Verbose "verbose stream"
}
my_function -b 1 -c 2,3,4 -a 5,6,7