#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\Desktop\Release\icon.ico
#AutoIt3Wrapper_Outfile=AutoRegFTU_x86.exe
#AutoIt3Wrapper_Outfile_x64=AutoRegFTU_x64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=AutoRegFTU
#AutoIt3Wrapper_Res_Description=Tự động đăng ký tín chỉ Đại học Ngoại thương
#AutoIt3Wrapper_Res_Fileversion=1.2.0.4
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=AutoRegFTU
#AutoIt3Wrapper_Res_ProductVersion=2.2.0
#AutoIt3Wrapper_Res_CompanyName=Trần Thanh Hùng
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs
	+ Nếu nhập sai tài khoản và nhập lại thì data không được reload vì vòng $acc và $pass chỉ được lấy 1 lần ở vòng While đầu tiên   ====> Done
	+ Lỗi đăng nhập thành công rồi tự thoát chương trình là do đoạn lệnh dùng để tách tên $tach   ====> Done
	+ duconmemaynhahahaha
	+ Nhập sai khi đệ quy hàm _Login() sẽ xảy ra lỗi không get được cookie từ trang tìn chỉ    ====> Done
	+ Vẫn chưa thể "Sai thông tin đăng nhập" và đăng nhập lại  ====> Done
	+ Khai báo biến ở hàm _Cookie() phải là Global   =====> Done
	+ If BLogin=LOGOUT thì logout   =====> Done
	+ Dùng hàm StringSplit   =====> Done
	+ Lỗi StrinhRegExp trong Func _Reg vì bộ lọc thiếu \ trước các kí tự đặc biệt
	+ Fjunc list vào vòng while thì ko ra đc
	+ Sau mỗi lần list thì code bị thay đổi => Done
	+ Môn có dấu / vd: TTR103:TTR103(58-1/1920).BS.1_LT bị lỗi $split_data = StringSplit($tach[0], '|')
$split_data = StringSplit($tach^ ERROR      ====>Done Do mã môn học thay đổi với những lớp BS
	+ Nhập sai mã môn ctrinh tự động tắt      =====>Báo lỗi khi mã môn ko khớp: Thêm 1 lệnh If $tach=1 (Tìm thấy) hoặc $tach=0 (Không tìm thấy)
	+ Thêm dòng vào trang đki môn học ở dòng 305: $dkmh=..... để chuyển tiếp trước khi tiến hành reg or del
	+ Lỗi khi đăng kí môn VJP101E(58-1/1920)VJCC.1_LT	 và VJP412E(57VJCC).1_LT
#ce

#Region ### Begin
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <_HttpRequest.au3>
#include <GUIListView.au3>
#include <ListViewConstants.au3>
#include <StringConstants.au3>
#include <pause.au3>

$Form1 = GUICreate("AutoRegFTU by  Trần Thanh Hùng Version 2.1.0", 609, 412, 200, 135)
GUISetFont(10, 400, 0, "MS Sans Serif")
GUISetBkColor(0x646464, $Form1)

$LAccount = GUICtrlCreateLabel("Account:", 16, 24, 68, 28, BitOR($SS_CENTER, $SS_CENTERIMAGE)) ;, $WS_BORDER))
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, "-2")
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")

$Account = GUICtrlCreateInput("1914410163", 82, 24, 155, 24, BitOR($GUI_SS_DEFAULT_INPUT, $WS_BORDER))
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$LPassword = GUICtrlCreateLabel("Password:", 248, 24, 76, 28, BitOR($SS_CENTER, $SS_CENTERIMAGE)) ;, $WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, "-2")

$Password = GUICtrlCreateInput("nguyenmaininh13052001", 322, 24, 152, 24, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD, $WS_BORDER))
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Edit1 = GUICtrlCreateEdit("", 16, 72, 457, 289, BitOR($ES_AUTOVSCROLL, $ES_READONLY, $WS_VSCROLL))
GUICtrlSetData(-1, '')
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$CMD = GUICtrlCreateInput("Nhập Mã lớp tín chỉ", 16, 368, 457, 24)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$BLogin = GUICtrlCreateButton("LOGIN", 496, 24, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetCursor(-1, 0)

$Schedule = GUICtrlCreateButton("Schedule", 496, 70, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Insert_plan = GUICtrlCreateButton("Insert Plan", 496, 120, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Reg_plan = GUICtrlCreateButton("Reg Plan", 496, 170, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Clear = GUICtrlCreateButton("Clear All", 496, 220, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Alert = GUICtrlCreateButton("Set Alert", 496, 270, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Contact = GUICtrlCreateButton("Contact Me", 496, 320, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Delete = GUICtrlCreateButton("DELETE", 496, 358, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0xFFFF00)
GUICtrlSetBkColor(-1, 0xFF0000)

$Send = GUICtrlCreateButton("REG", 496, 382, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetBkColor(-1, 0x00FF00)

GUISetState(@SW_SHOW)
Global $Form2 = GUICreate("Kết quả đăng ký", 350, 438, 812, 136, 0) ;, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
Global $ListView1 = GUICtrlCreateListView("Tên Môn Học|Mã lớp tín chỉ|Tình Trạng", 0, 0, 345, 409)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 150)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 120)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 71)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 0, 2)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 1, 2)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 2, 2)
GUISetState(@SW_SHOW)
;	GUICtrlCreateListViewItem('a|b|c', $ListView1)
;	_GUICtrlListView_DeleteAllItems($ListView1)
#EndRegion ### END Koda GUI section ###

Sleep(1000)
_Text('Programed by Trần Thanh Hùng')
Sleep(300)
_Text('Contact me: Facebook.com/darrenhtth')
_Cookie()

Global $maxtimes = 500
Dim $tach[3]

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $BLogin
			If GUICtrlRead($BLogin) = 'LOGIN' Then
				Global $acc = GUICtrlRead($Account)
				$pass = GUICtrlRead($Password)
				If $acc = '' Or $pass = '' Then
					MsgBox(16, 'Error', 'Vui lòng nhập đủ MSV và mật khẩu')
				Else
					_Login()
				EndIf
			Else
				_Logout()
			EndIf
		Case $Send
			_Reg()
			$check_trung = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: KiemTraTrungNhom')
			$luu = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy')
			$luu_hople = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"isCheckSongHanh":false,"ChiaHP":false}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy_HopLe')
		Case $Schedule
			_Schedule()
		Case $Delete
			_Del()
		Case $Contact
			_showAboutDialog('Auto Reg FTU', '1.1.0', 'Trần Thanh Hùng', Default, Default, 'https://www.facebook.com/darrenhtth')
		Case $Insert_plan
			MsgBox(64, 'Instruction', 'Nhập Mã lớp tín chỉ vào file Plan.txt' & @CRLF & 'VD: XHH101E(1-1920).1_LT' & @CRLF & 'Mỗi môn ghi trên một dòng' & @CRLF & 'Ghi xong nhớ Save (Ctrl+S)')
			FileWrite(@ScriptDir & '\Plan.txt', '')
			ShellExecute(@ScriptDir & '\Plan.txt')
		Case $Reg_plan
			For $i = 1 To _FileCountLines(@ScriptDir & '\Plan.txt')
				GUICtrlSetData($CMD, '')
				GUICtrlSetData($CMD, FileReadLine(@ScriptDir & '\Plan.txt', $i))
				_Reg()
			Next
			$check_trung = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: KiemTraTrungNhom')
			$luu = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy')
			$luu_hople = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"isCheckSongHanh":false,"ChiaHP":false}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy_HopLe')
			_Text('Đã đăng ký xong!')
		Case $Clear
			_GUICtrlListView_DeleteAllItems($ListView1)
			GUICtrlSetData($Edit1, '')
			;FileDelete(@ScriptDir & '\Plan.txt')
		Case $Alert
			If GUICtrlRead($Alert) = 'Set Alert' Then
				_Alert()
			Else

			EndIf
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

;==============================_Cookie==========================
Func _Cookie()
		_Text('Xin chờ....')
		Sleep(300)
		_Text('Đang tiến hành lấy Cookie....')
		Global $source_login = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', '', '', 'Upgrade-Insecure-Requests: 1')
		Global $cookie = _GetCookie($source_login[0])
		If $cookie <> '' Then
			_Text('Đã lấy xong Cookie. Vui lòng đăng nhập.')
			$source = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
		Else
			_Text('Không lấy được Cookie, vui lòng thử lại sau!')
		EndIf
EndFunc   ;==>_Cookie

;==============================_Login===========================
Func _Login($times = 0)
	While 1
		$acc = GUICtrlRead($Account)
		$pass = GUICtrlRead($Password)
		$in__VIEWSTATE = StringRegExp($source_login[1], 'name="__VIEWSTATE" id="__VIEWSTATE" value="(.*?)"', 1)
		$in__VIEWSTATEGENERATOR = StringRegExp($source_login[1], 'name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="(.*?)"', 1)
		Local $aForm = [['__EVENTTARGET', ''], ['__EVENTARGUMENT', ''], ['__VIEWSTATE', $in__VIEWSTATE[0]], ['__VIEWSTATEGENERATOR', $in__VIEWSTATEGENERATOR[0]], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtTaiKhoa', $acc], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtMatKhau', $pass], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$btnDangNhap', 'Đăng Nhập']]
		$data_login = _HttpRequest_DataFormCreate($aForm)
		$login = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/default.aspx', $data_login, $cookie, 'http://ftugate.ftu.edu.vn/default.aspx', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0|Origin: http://ftugate.ftu.edu.vn|Origin: http://ftugate.ftu.edu.vn|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
		FileDelete(@ScriptDir & '\test1.html')
		FileWrite(@ScriptDir & '\test1.html', $login[1])
		ShellExecute(@ScriptDir & '\test1.html')
		If @error Then
			_Text('Không lấy được nội dung trang tín chỉ. Đang thử lại....')
		Else
			If (StringInStr($login[1], "ctl00_ContentPlaceHolder1_ctl00_ucDangNhap_lblError") > 0) Then
				If (StringInStr($login[1], "Hệ thống đang bận vì quá tải") > 0 Or StringInStr($login[1], "Please login again after 10 minutes") > 0 > 0) Then
					If ($times >= $maxtimes) Then
						_Text("[LOGIN] Hệ thống quá tải, hãy thử lại sau")
						ExitLoop
					Else
						_Text("[LOGIN] Hệ thống quá tải, đang thử lại lần " & $times + 1 & "/" & $maxtimes)
						Sleep(1000)
						_Login($times + 1)
					EndIf
				ElseIf (StringInStr($login[1], "Sai thông tin") > 0) Then
					_Text("[LOGIN] Sai thông tin đăng nhập")
					GUICtrlSetBkColor($LAccount, "0xf4564d")
					GUICtrlSetBkColor($LPassword, "0xf4564d")
					ExitLoop
				ElseIf (StringInStr($login[1], 'ngoài thời gian đăng ký môn học') > 0) Then
					_Text("[LOGIN] Ngoài thời gian đăng ký môn học")
				Else
					_Text("[LOGIN] Lỗi không xác định")
					ExitLoop
				EndIf
			ElseIf (StringInStr($login[1], 'Server đang tải lại dữ liệu. Vui lòng trở lại sau 15 phút!') > 0) Then
				If ($times >= $maxtimes) Then
					_Text("[LOGIN] Hệ thống quá tải, hãy thử lại sau")
					ExitLoop
				Else
					_Text('Server đang tải lại dữ liệu. Vui lòng trở lại sau 15 phút!')
					_Text("[LOGIN] Đang thử lại lần " & $times + 1 & "/" & $maxtimes)
					Sleep(1000)
					_Login($times + 1)
				EndIf
				#cs ElseIf (StringInStr($login[1], "ctl00_Header1_ucLogout_lblNguoiDung") > 0) Then
					$ten = StringRegExp($login[1], 'font-weight:bold;">Chào bạn  (.*?)</span>', 1)
					GUICtrlSetBkColor($LAccount, '-2')
					GUICtrlSetBkColor($LPassword, '-2')
					GUICtrlSetData($Form1, $ten[0] & ' - ' & $acc)
					GUICtrlSetData($BLogin, 'LOGOUT')
					_Text("[LOGIN] ĐĂNG NHẬP THÀNH CÔNG")
					_Text("[LOGIN] Xin chào " & $ten[0])
					_Text("=====================================================")
					_Text('Đang lấy danh sách môn học....')
					_Load()
					ExitLoop
					Return True
				#ce ElseIf (StringInStr($login[1], "ctl00_Header1_ucLogout_lblNguoiDung") > 0) Then
			Else
				$login = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
				If (StringInStr($login[1], "ctl00_Header1_Logout1_lblNguoiDung") > 0) Then
					$ten = StringRegExp($login[1], 'font-weight:bold;">Chào bạn (.*?)</span>&nbsp', 1)
					GUICtrlSetBkColor($LAccount, '-2')
					GUICtrlSetBkColor($LPassword, '-2')
					;GUICtrlSetData($Form1, $ten[0] & ' - ' & $acc)
					WinSetTitle($Form1, '', $ten[0])
					WinSetTitle($Form2, '', $ten[0])
					GUICtrlSetData($BLogin, 'LOGOUT')
					_Text("[LOGIN] ĐĂNG NHẬP THÀNH CÔNG")
					_Text("[LOGIN] Xin chào " & $ten[0])
					_Text("=====================================================")
					_Text('Đang lấy danh sách môn học....')
					_Load()
					ExitLoop
					Return True
				Else
					_Text("Lỗi không xác định")
					ExitLoop
					Return False
				EndIf
				;_Text("[LOGIN] Phiên đăng nhập hết hạn, đang lấy lại captcha và đăng nhập lại")
				;_Cookie()
				;ExitLoop

			EndIf
			Return False
		EndIf
	WEnd
EndFunc   ;==>_Login

;==============================_Logout==========================
Func _Logout()
	$source_logout = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', 'Upgrade-Insecure-Requests: 1')
	$out__VIEWSTATE = StringRegExp($source_logout, 'name="__VIEWSTATE" id="__VIEWSTATE" value="(.*?)"', 1)
	$data_logout = _Data2SendEncode('__EVENTTARGET=ctl00$Header1$ucLogout$lbtnLogOut&__EVENTARGUMENT=&__VIEWSTATE=' & $out__VIEWSTATE[0])
	$logout = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', $data_logout, $cookie, '', 'Upgrade-Insecure-Requests: 1')
	If @error Then
		_Text('Không thể đăng xuất, vui lòng thử lại')
	Else
		_Text('Đăng xuất thành công')
		FileDelete(@ScriptDir & '\Plan.txt')
		_GUICtrlListView_DeleteAllItems($ListView1)
		GUICtrlSetData($BLogin, 'LOGIN')
	EndIf
EndFunc   ;==>_Logout
;==============================_Text============================
Func _Text($txt)
	GUICtrlSetData($Edit1, "[" & @HOUR & ":" & @MIN & ":" & @SEC & "] " & $txt & @CRLF, 1)
EndFunc   ;==>_Text

;==============================_Load============================
Func _Load()
	$load_header = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LoadDanhSachKhoaLop|DNT: 1')
	Sleep(1500)
	If StringInStr($load_header[0], 'HTTP/1.1 200 OK') > 0 Then
		_Text('Đã load xong danh sách môn.')
		_Text('Nhập Mã lớp tín chỉ vào ô dưới để tiến hành đăng kí (REG) hoặc xóa môn (DELETE)')
		_Text('VD: Nhập XHH101E(1-1920).1_LT để chọn môn Xã hội học .1')
	Else
		_Text('Chưa load được danh sách.... Đang thử lại')
		_Load()
	EndIf
EndFunc   ;==>_Load

;==============================_Reg=============================
Func _Reg()
	;$sub_data = StringSplit(GUICtrlRead($CMD), ':')
	Dim $sub_data[3]
	$sub_data[2] = GUICtrlRead($CMD)
	$sub_data[1] = StringRegExp($sub_data[2], '(.*?)\(', 1)[0]
	$sub_data[0] = StringReplace(StringReplace(StringReplace(StringReplace($sub_data[2], '(', '\('), ')', '\)'), '/', '\/'), '+', '\+')
	$fix = $sub_data[1] & $sub_data[0]
	$kqloc = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"dkLoc":' & '"' & $sub_data[1] & '"' & '}', $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LocTheoMonHoc')
	FileDelete(@ScriptDir & '\after.html')
	FileWrite(@ScriptDir & '\after.html', $kqloc[1])
	ShellExecute(@ScriptDir & '\after.html')
	If StringInStr(StringRegExp($kqloc[1], "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 1)[0], 'Hết') > 0 Then
		_Text('Môn ' & $sub_data[2] & ' đã hết slot')
		GUICtrlCreateListViewItem($sub_data[1] & '|' & $sub_data[2] & '|' & 'Hết Slot', $ListView1)
	Else
		$tach = StringRegExp($kqloc[1], "id='chk_" & $fix & "  '  \\r\\nvalue=\\" & '"(.*?)\\"', 1)
		If $tach <> 0 Then
			Global $split_data = StringSplit($tach[0], '|')
			If $split_data[0] >= 13 Then
				_Text('Đang gửi lệnh đăng kí đến máy chủ....')
				$dkmh = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', '', $cookie)
				$data_reg = '{"check":true,"maDK":"' & $split_data[1] & '","maMH":"' & $split_data[2] & '","tenMH":"' & $split_data[3] & '","maNh":"' & $split_data[4] & '","sotc":"' & $split_data[5] & '","strSoTCHP":"' & $split_data[6] & '","ngaythistr":"' & $split_data[7] & '","tietbd":"' & $split_data[8] & '","sotiet":"' & $split_data[9] & '","soTCTichLuyToiThieuMonYeuCau":"' & $split_data[10] & '","choTrung":"' & $split_data[11] & '","soTCMinMonYeuCau":"' & $split_data[12] & '","maKhoiSinhVien":"' & $split_data[13] & '"}'
				;			FileWrite(@ScriptDir&'\test1.txt',$data_reg)
				$reg = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', $data_reg, $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: DangKySelectedChange')
				$return = StringSplit($reg[1], '|')
				;		FileWrite(@ScriptDir&'\test.html',$reg[1])
				;		FileDelete(@ScriptDir&'\after.html')
				;		FileWrite(@ScriptDir&'\after.html',$reg[1])
				;		ShellExecute(@ScriptDir&'\after.html')
				;			If $reg[1] <> '{"value":""}' Then
				If StringInStr($reg[1], 'Ngoài thời gian đăng ký') <> 0 Then    ;<input type="button" id="btnLuu" value="Lưu Đăng Ký" onclick="LuuDanhSachDangKy()">
					If $return[0] > 30 Then
						If Number($return[10]) == 0 Then
							If $return[7] == "" And $return[8] == "" And $return[11] == "" Then
								_Text("[REG] Được đăng ký, đang lưu dữ liệu")
								$data_reg = '{"isValidCoso":false,"isValidTKB":false,"maDK":"' & $split_data[1] & '","maMH":"' & $split_data[2] & '","sotc":"' & $split_data[5] & '","tenMH":"' & $split_data[3] & '","maNh":"' & $split_data[4] & '","strsoTCHP":"' & $split_data[6] & '","isCheck":"true","oldMaDK":"' & $return[5] & '","strngayThi":"' & $split_data[7] & '","tietBD":"' & $split_data[8] & '","soTiet":"' & $split_data[9] & '","isMHDangKyCungKhoiSV":"' & $return[36] & '"}'
								$check_luu = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', $data_reg, $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuVaoKetQuaDangKy')

								#cs						$check_trung = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: KiemTraTrungNhom')
														$luu = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy')
								#ce						$check_trung = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: KiemTraTrungNhom')
								_Text('Đăng kí xong môn: ' & $split_data[3])
								GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thành Công', $ListView1)
								_Text($split_data[3])
							Else
								GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thất Bại', $ListView1)
								If ($return[7] <> "") Then _Text("[REG] Lỗi " & $return[7])
								If ($return[8] <> "") Then _Text("[REG] Lỗi " & $return[8])
								If ($return[11] <> "") Then _Text("[REG] Lỗi môn này ko thể tự đăng ký do phần tử 11 = " & $return[11])
							EndIf
						Else
							GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Trùng lịch', $ListView1)
							_Text("[REG] Bạn bị trùng lịch môn học này")
						EndIf
					Else
						_Text("[REG] Tách dữ liệu đăng ký thất bại.")
						GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thất Bại', $ListView1)
					EndIf
				Else
					_Text("[REG] Chưa đến thời gian đăng kí.")
					GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thất Bại', $ListView1)
				EndIf
			EndIf
		Else
			_Text('Mã môn học hoặc mã lớp tín chỉ không chính xác.')
			_Text('Vui lòng kiểm tra lại!')
		EndIf
	EndIf
EndFunc   ;==>_Reg

;==============================_Del=============================
Func _Del()
	_Text('Đang gửi lệnh xóa môn....')
	$dkmh = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', '', $cookie)
	Dim $sub_data[3]
	$sub_data[2] = GUICtrlRead($CMD)
	$sub_data[1] = StringRegExp($sub_data[2], '(.*?)\(', 1)[0]
	$data_del = '{"danhSachMaDangKy":",' & $sub_data[1] & $sub_data[2] & '  "}'
	$del = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', $data_del, $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: XoaKQDKTheoMaDK')
	_HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: KiemTraTrungNhom')
	_HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy')
	$end = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"isCheckSongHanh":false,"ChiaHP":false}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy_HopLe')
	Sleep(500)
	;FileWrite(@ScriptDir&'\del.txt',$end[1])
	;ShellExecute(@ScriptDir&'\del.txt')
	;	If $end[1]='{"value":"||default.aspx?page=dkmonhoc"}' Then
	_Text('Xóa môn ' & $sub_data[2] & ' thành công!')
	GUICtrlCreateListViewItem($sub_data[1] & '|' & $sub_data[2] & '|' & 'Đã Xóa', $ListView1)
	;		Return
	;	Else
	#cs	For $i = 1 To 10
			_Text('Thất bại! Đang thử lại lần ' & $i & '/10')
			_Del()
	#ce	For $i = 1 To 10
	;		_Text('Không thể xóa môn. Vui lòng thử lại sau.')
	;	EndIf
EndFunc   ;==>_Del

;==============================_Alert===========================
Func _Alert()
	GUICtrlSetData($Alert, 'Waiting...')
	While 1
		$dkmh = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', '', $cookie)
		If StringInStr($dkmh, 'Ngoài thời gian đăng ký') > 0 Then
			ContinueLoop
			;'<input type="button" id="btnLuu" value="Lưu Đăng Ký" onclick="LuuDanhSachDangKy()">'
			;<input type="button" id="btnLuu" disabled="" value="Lưu Đăng Ký" onclick="LuuDanhSachDangKy()">
			;<span id="ctl00_ContentPlaceHolder1_ctl00_xxxx" class="Label" style="color:White;background-color:Blue;font-size:Large;font-weight:bold;">Ngoài thời gian đăng ký</span>
		Else
			ShellExecute(@ScriptDir & '\Alert.m4a')
			GUICtrlSetData($Alert, 'Set Alert')
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>_Alert

;==============================_About===========================
Func _showAboutDialog($softwareName, $version, $author, $copyrightStart = Default, $copyrightEnd = Default, $website = Default, $hwnd = Default, $icon = Default, $width = Default, $height = Default, $colorbg = Default, $colofg = Default)
	Opt("GUIOnEventMode", 0)

	If $hwnd = Default Then $hwnd = WinGetHandle(AutoItWinGetTitle())
	Global $colorfg = Default
	; Icon
	Local $iconName = -1
	If $icon = Default Then
		$icon = (@Compiled) ? @ScriptFullPath : 'shell32.dll'
		If Not @Compiled Then $iconName = 3 ; icon from shell32.dll
	EndIf

	; Line 01
	If (StringLeft($version, 1) <> 'v') Then $version = 'v' & $version
	$softwareName &= ' ' & $version

	; Line 02
	Local $copyright = 'Copyright ' & Chr(169) & ' '
	If $copyrightStart <> Default Then $copyright &= $copyrightStart & '-'
	If $copyrightEnd = Default Then $copyrightEnd = @YEAR
	$copyright &= $copyrightEnd & ' ' & $author

	; Check website
	Local $GUIheight = ($website = Default) ? 135 : 160
	Local $btnTop = ($website = Default) ? 85 : 115

	#Region ### START Koda GUI section ###
	Local $FormMain = GUICreate('About', 393, $GUIheight, -1, -1, BitXOR($GUI_SS_DEFAULT_GUI, $WS_MINIMIZEBOX), -1, $hwnd)
	; BG Color
	If ($colorbg <> Default) Then GUISetBkColor($colorbg)

	GUISetFont(12, 400, 0, 'Segoe UI')
	GUICtrlCreateIcon($icon, $iconName, 20, 20, 48, 48)
	GUICtrlCreateLabel($softwareName, 80, 20, 238, 25)
	; Set custom color for label
	If ($colorfg <> Default) Then GUICtrlSetColor(-1, $colorfg)
	GUICtrlCreateLabel($copyright, 80, 50, 257, 25)
	; Set custom color for label
	If ($colorfg <> Default) Then GUICtrlSetColor(-1, $colorfg)

	If $website <> Default Then
		Local $labelWebsite = GUICtrlCreateLabel('https://www.facebook.com/darrenhtth', 80, 80, 300, 25)
		GUICtrlSetFont(-1, 12, 400, 4, 'Segoe UI')
		; Set custom color for label
		If ($colorfg <> Default) Then
			GUICtrlSetColor(-1, $colorfg)
		Else
			GUICtrlSetColor(-1, 0x0000FF)
		EndIf
		GUICtrlSetCursor(-1, 0)
	Else
		; Prevent GUIGetMsg error
		Local $labelWebsite = GUICtrlCreateDummy()
	EndIf

	Local $btnOK = GUICtrlCreateButton('OK', 283, $btnTop, 65, 25, $BS_DEFPUSHBUTTON)
	GUICtrlSetCursor(-1, 0)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	Local $iMsg = 0
	While 1
		$iMsg = GUIGetMsg()
		Switch $iMsg
			Case $labelWebsite
				; Make sure it is an valid URL
				Local $url = GUICtrlRead($labelWebsite)
				If StringLeft($url, 4) = 'http' Or StringLeft($url, 3) = 'www' Then ShellExecute($url)

			Case $btnOK
				ExitLoop

			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	GUIDelete($FormMain)
EndFunc   ;==>_showAboutDialog
