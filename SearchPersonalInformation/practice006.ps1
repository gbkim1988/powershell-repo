Function Test-Parameters
{
    Param(
        [ValidatePattern("(?!<?[0-9])[0-9]{6}([ \t]|(\r?\n)|(\r\n?)|<[bB][rR]( ?/)?>|&[nN][bB][sS][pP];?){0,5}(([-~∼ㅡ]|&#0?4(5;|5(?!>?[0-9])))([ \t]|(\r?\n)|(\r\n?)|<[bB][rR]( ?/)?>|&[nN][bB][sS][pP];?){0,5})?[0-9]{7}(?!>?[0-9])")]
    )
}