#include <_HttpRequest.au3>
$get_source = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', '', '', 'Upgrade-Insecure-Requests: 1')
$cookie = _GetCookie($get_source[0])
$source = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
$ViewState = StringRegExp($get_source[1], 'name="__VIEWSTATE" id="__VIEWSTATE" value="(.*?)"',1)
$Gen = StringRegExp($get_source[1], 'name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="(.*?)"',1)
$acc='1914410163'
$pass = 'nguyenmaininh13052001'
Local $aForm = [['__EVENTTARGET',''], ['__EVENTARGUMENT',''], ['__VIEWSTATE',$ViewState[0]], ['__VIEWSTATEGENERATOR',$Gen[0]], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtTaiKhoa',$acc], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtMatKhau',$pass], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$btnDangNhap','Đăng Nhập']]
$data2send = _HttpRequest_DataFormCreate($aForm)
;$data2send = '__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE='& $ViewState[0] & '&__VIEWSTATEGENERATOR=' & $Gen[0] & '&ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtTaiKhoa=' & $acc & '&ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtMatKhau=' & $pass & '&ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$btnDangNhap=Đăng Nhập'
;$source = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.GioiThieu,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx', 'X-AjaxPro-Method: GetHitCounter|Origin: http://ftugate.ftu.edu.vn')
$login = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/default.aspx', $data2send, $cookie, 'http://ftugate.ftu.edu.vn/default.aspx', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0|Origin: http://ftugate.ftu.edu.vn|Origin: http://ftugate.ftu.edu.vn|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
$login = $source = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
$check_tkb = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/Default.aspx?page=thoikhoabieu', '', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'Upgrade-Insecure-Requests: 1')

FileDelete(@ScriptDir&'\test1.html')
FileWrite(@ScriptDir&'\test1.html',$check_tkb[1])
ShellExecute(@ScriptDir&'\test1.html')


;__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=/wEPDwl2pz+5y&__VIEWSTATEGENERATOR=CA0B0334&ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtTaiKhoa=1711110006 &ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtMatKhau=an2109201099&ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$btnDangNhap=Đăng Nhập