#include <File.au3>
#include <_HttpRequest.au3>

$a = _HttpRequest(2, 'https://nhanisme.com/mua-tai-khoan-netflix/')
FileDelete(@ScriptDir & '\Show.html')
FileWrite(@ScriptDir & '\Show.html', $a)
ShellExecute(@ScriptDir & '\Show.html')