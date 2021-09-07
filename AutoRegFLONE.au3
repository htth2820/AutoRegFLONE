#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=AutoRegFLONE_x86.exe
#AutoIt3Wrapper_Outfile_x64=AutoRegFLONE_x64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=AutoRegFLONE
#AutoIt3Wrapper_Res_Description=Tự động đăng ký tín chỉ Đại học Ngoại thương
#AutoIt3Wrapper_Res_Fileversion=1.2.0.25
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=AutoRegFLONE
#AutoIt3Wrapper_Res_ProductVersion=2.2.0
#AutoIt3Wrapper_Res_CompanyName=Trần Thanh Hùng
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>

; *** End added by AutoIt3Wrapper ***
#cs
#### 1: Header 2: Source 4: 1+2


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

#cs BIG UPDATE: 20/07/2020
	+ Sửa lại Data2send đăng nhập: Dùng F12 của Firefox sẽ thấy dạng form của data2send dạng nhiều dòng chứ ko phải 1 dòng như trong Extension Http Headers Live. Đọc hướng dẫn trong file _HttpRequest, Practice => Post => Multipart Data
	+ Bỏ Insert Plan và Instruction bằng tính năng xem TKB (Chưa hoàn thiện) và Lọc/Xem kết quả đki
	+ Sửa lại các $iReturn trong _HttpRequest từ 4 về 2 và 0 sao cho tối ưu, bỏ bớt các hàm Sleep

_Login()
	+ Bỏ tính năng báo lỗi xảy ra khi đăng nhập để tối ưu tốc độ, do khi mở đki, nếu đăng nhập thành công sẽ Redirect đến trang đki luôn => Phải đợi load xong trang đki mới biết đăng nhập thành công hay không => Mất thời gian ====> Dự định code 1 tool kiểm tra lỗi một loạt các tài khoản
	+ Sửa lại tên cửa sổ khi đăng nhập thành công bằng tên và MSV

_Reg()
	+ Sửa lại phần đăng kí các môn mà mã có dấu + fix thành \+
	+ Sửa biến $fix do môn GDTC khi đki source sẽ tách thành GDTC GDTC.5 chứ ko viết liền như các môn khác
	+ Thêm phần lọc báo kết quả là "Không có môn học được mở"
	+ Vượt tiên quyết và Trùng lịch bằng cách bỏ $return[7] == "" trong câu lệnh If => Chưa xong, fix lại chỗ ko bỏ qua trùng lịch, và báo hỏi ng dùng có muốn vượt tiên quyết hay ko
	+ Bỏ phần "Ngoài thời gian đăng ký"
	+ Môn mã môn có 2 dòng: Lúc lọc phải bỏ dấu cách đi
_Logout()
	+ Chưa sửa lỗi logout

Updated: 11/1/2021
Đã làm:
	+) Thêm để xóa dấu cách khi insert mã môn, tránh bị lỗi
	+) Đã tối ưu thời gian Login
	+) Sửa func Del giúp xóa môn nhanh hơn....
	+) Thêm button del plan, xóa theo list có sẵn
	+) Thêm tính năng tự ghi log file đăng ký/xóa môn : Thành công/thất bại/....
	+) Tối ưu chọn đường dẫn, đỡ mất công tìm
	+) Thêm tính năng Set Alert: Báo động khi Bơm slot
Cần làm:
	+) Mày cần thêm tính năng đăng ký bằng cách lấy data trực tiếp từ Google Sheet
	+) Thêm tính năng tự động đăng ký phương án dự phòng
	+) Check slot trước khi hủy để chuyển lớp
	+) Báo lỗi nút lưu ko hiển thị, lưu xong mất môn,...

Updated: 14/1/2021
Đã làm:
	+) Sửa lỗi trong stringregexp khiến cho tool tự thoát ở phần Login và Reg
	+) Sửa lỗi bị logout nhưng báo mã lớp/mã nguồn có vấn đề
	+) Thêm biến user_agent để ẩn mình và update dễ dàng hơn
	+) Thay đổi lớn ở Login: Bỏ vòng lặp while, báo ra lỗi
	+) Sửa get tkb, thêm biến hocki
Cần làm:
	+) Bơm slot tự logout
	+) Reg Plan thì clear list
	+) Import xong ko can import lại
	+) Check tình trạng login mỗi 5s

#Updated: 03/07/2021
+) Sửa tính năng lấy tkb (Phải login mới xem đc tkb)
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
#include <MsgBoxConstants.au3>


$Form1 = GUICreate("AutoReg - FLONE by  Trần Thanh Hùng Version 3.0.4", 609, 412, 200, 135)
GUISetFont(10, 400, 0, "MS Sans Serif")
GUISetBkColor(0x646464, $Form1)

$LAccount = GUICtrlCreateLabel("Account:", 16, 24, 68, 28, BitOR($SS_CENTER, $SS_CENTERIMAGE)) ;, $WS_BORDER))
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, "-2")
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")

$Account = GUICtrlCreateInput("1411110035", 82, 24, 155, 24, BitOR($GUI_SS_DEFAULT_INPUT, $WS_BORDER))
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$LPassword = GUICtrlCreateLabel("Password:", 248, 24, 76, 28, BitOR($SS_CENTER, $SS_CENTERIMAGE)) ;, $WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, "-2")

$Password = GUICtrlCreateInput("ftu", 322, 24, 152, 24, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD, $WS_BORDER))
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Edit1 = GUICtrlCreateEdit("", 16, 72, 457, 289, BitOR($ES_AUTOVSCROLL, $ES_READONLY, $WS_VSCROLL))
GUICtrlSetData(-1, '')
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$CMD = GUICtrlCreateInput("", 16, 368, 457, 24)
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

$List = GUICtrlCreateButton("Check List", 496, 120, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Reg_plan = GUICtrlCreateButton("Reg Plan", 496, 170, 89, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)

$Clear = GUICtrlCreateButton("Delete Plan", 496, 220, 89, 25)
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

#Region Main
Global $user_agent = 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.101 Safari/537.36'
_Text('Programed by Trần Thanh Hùng')
_Text('Contact me: Facebook.com/htth.cursed')
_Cookie()

Dim $tach[3]
Global $cookie = ''
Global $ten
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $BLogin
			If GUICtrlRead($BLogin) = 'LOGIN' Then
				Global $acc = GUICtrlRead($Account)
				Global $pass = GUICtrlRead($Password)
				If $acc = '' Or $pass = '' Then
					MsgBox(16, 'Error', 'Vui lòng nhập đủ MSV và mật khẩu')
				Else
					_Login()
					;MsgBox(0,0,$ten)
					FileDelete(@ScriptDir &'\Logs\'& $ten & '.txt')
					FileWriteLine(@ScriptDir &'\Logs\'& $ten & '.txt', $ten)
				EndIf
			Else
				_Logout()
			EndIf

		Case $Schedule
			_Schedule()

		Case $List
			Dim $sub_data[3]
			$sub_data[2] = GUICtrlRead($CMD)
			If $sub_data[2] = '' Then
				$Show_dsdk = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, '', $user_agent & '|X-AjaxPro-Method: ShowDSDaDangKy')
				If StringInStr($Show_dsdk, 'System.NullReferenceException') Then
					_Text('Tài khoản đã bị đăng xuất. Vui lòng đăng nhập lại.')
				Else
					FileDelete(@ScriptDir & '\Show.html')
					FileWrite(@ScriptDir & '\Show.html', $Show_dsdk)
					ShellExecute(@ScriptDir & '\Show.html')
				EndIf
				;Else
				;	$Show_dsdk = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, '','X-AjaxPro-Method: LoadDanhSachKhoaLop')
				;	FileDelete(@ScriptDir & '\Show.html')
				;	FileWrite(@ScriptDir & '\Show.html', $Show_dsdk)
				;	ShellExecute(@ScriptDir & '\Show.html')
				;EndIf
			Else
				$kqloc = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"dkLoc":' & '"' & $sub_data[2] & '"' & '}', $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LocTheoMonHoc')
				If StringInStr($kqloc, 'System.NullReferenceException') Then
					_Text('Tài khoản đã bị đăng xuất. Vui lòng đăng nhập lại.')
				Else
					FileDelete(@ScriptDir & '\List.html')
					FileWrite(@ScriptDir & '\List.html', $kqloc)
					ShellExecute(@ScriptDir & '\List.html')
				EndIf
			EndIf

		Case $Reg_plan
			_GUICtrlListView_DeleteAllItems($ListView1)
			$file = FileOpenDialog('Choose Text files', @ScriptDir & '\DSDK\', 'Text files (*.txt)')
			If $file = '' Then
				_Text('Import thất bại. Vui lòng thử lại')
			Else
				_Text('Import danh sách thành công')
				_Text('Đang tiến hành đăng ký')
				For $i = 1 To _FileCountLines($file)
					GUICtrlSetData($CMD, '')
					GUICtrlSetData($CMD, FileReadLine($file, $i))
					Sleep(Random(1000, 2000, 1))
					_Reg()
				Next
				$check_trung = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: KiemTraTrungNhom')
				$luu = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuDanhSachDangKy')
				$luu_hople = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"isCheckSongHanh":false,"ChiaHP":false}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuDanhSachDangKy_HopLe')
				$Show_dsdk = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, '', $user_agent & '|X-AjaxPro-Method: ShowDSDaDangKy')
				FileDelete(@ScriptDir & '\Show.html')
				FileWrite(@ScriptDir & '\Show.html', $Show_dsdk)
				ShellExecute(@ScriptDir & '\Show.html')
				_Text('Đã đăng ký xong!')
			EndIf

		Case $Clear
			$file_del = FileOpenDialog('Choose Text files', @ScriptDir &'\DSDK\', 'Text files (*.txt)')
			If $file_del = '' Then
				_Text('Import thất bại. Vui lòng thử lại')
			Else
				_Text('Import danh sách thành công')
				_Text('Đang tiến hành xóa môn')
				For $i = 1 To _FileCountLines($file_del)
					GUICtrlSetData($CMD, '')
					GUICtrlSetData($CMD, FileReadLine($file_del, $i))
					Sleep(2000)
					_Del()
					_Text('Xóa môn ' & $sub_data[2] & ' thành công!')
					GUICtrlCreateListViewItem($sub_data[1] & '|' & $sub_data[2] & '|' & 'Đã Xóa', $ListView1)
				Next
				_HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: KiemTraTrungNhom')
				_HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuDanhSachDangKy')
				$end = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"isCheckSongHanh":false,"ChiaHP":false}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuDanhSachDangKy_HopLe')
				_Text('Đã xóa ký xong!')
				$Show_dsdk = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, '', $user_agent & '|X-AjaxPro-Method: ShowDSDaDangKy')
				FileDelete(@ScriptDir & '\Show.html')
				FileWrite(@ScriptDir & '\Show.html', $Show_dsdk)
				ShellExecute(@ScriptDir & '\Show.html')
			EndIf
#cs
			_GUICtrlListView_DeleteAllItems($ListView1)
			GUICtrlSetData($Edit1, '')
			_Text('Programed by Trần Thanh Hùng')
			_Text('Contact me: Facebook.com/htth.cursed')
#ce
		Case $Alert
			If GUICtrlRead($Alert) = 'Set Alert' Then
				_Alert()
			Else

			EndIf

		Case $Delete
			_Del()
			_HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: KiemTraTrungNhom')
			_HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuDanhSachDangKy')
			$end = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"isCheckSongHanh":false,"ChiaHP":false}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuDanhSachDangKy_HopLe')

		Case $Send
			_Reg()
			$check_trung = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: KiemTraTrungNhom')
			$luu = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuDanhSachDangKy')
			$luu_hople = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"isCheckSongHanh":false,"ChiaHP":false}', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', 'X-AjaxPro-Method: LuuDanhSachDangKy_HopLe')
			;$Show_dsdk = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, '', $user_agent & '|X-AjaxPro-Method: ShowDSDaDangKy')
			;FileDelete(@ScriptDir & '\Show.html')
			;FileWrite(@ScriptDir & '\Show.html', $Show_dsdk)
			;ShellExecute(@ScriptDir & '\Show.html')

		Case $Contact
			_Captcha()
			;_showAboutDialog('Auto Reg FTU', '3.0.4', 'Trần Thanh Hùng', Default, Default, 'https://www.facebook.com/htth.cursed')

		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd
#EndRegion Main

#Region Functions
;==============================_Captcha=========================
Func _Captcha()
	_Text('Đang tiến hành bypass Captcha....')
	Local $source = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', $user_agent & '|Upgrade-Insecure-Requests: 1')

	$capt = StringRegExp($source, 'id="ctl00_ContentPlaceHolder1_ctl00_lblCapcha" class="Label" style="color:#0066FF;font-family:Comic Sans MS;font-size:20pt;font-weight:bold;font-style:italic;">(.*?)</span></span>', 1)[0]

	$source = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/', 'data2send', $cookie, '', $user_agent & '|Upgrade-Insecure-Requests: 1')
	If StringInStr($source, '') > 0 Then
		_Text('Bypass Captcha thành công. Vui lòng tiến hành đăng nhập')
	Else
		_Text('Bypass Captcha thất bại. Vui lòng thử lại sau')
#ce
		FileDelete(@ScriptDir & '\test1.html')
		FileWrite(@ScriptDir & '\test1.html', $source)
		ShellExecute(@ScriptDir & '\test1.html')
	;EndIf
EndFunc

;==============================_Text============================
Func _Text($txt)
	GUICtrlSetData($Edit1, "[" & @HOUR & ":" & @MIN & ":" & @SEC & "] " & $txt & @CRLF, 1)
EndFunc   ;==>_Text

;==============================_Cookie==========================
Func _Cookie()
	_Text('Xin chờ....')
	_Text('Đang tiến hành lấy Cookie....')
	Global $source_login = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', '', '', $user_agent & '|Upgrade-Insecure-Requests: 1')
	Global $cookie = _GetCookie($source_login[0])
	If $cookie <> '' Then
		_Text('Đã lấy xong Cookie.')
		;$source = _HttpRequest(4, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
	Else
		_Text('Không lấy được Cookie, vui lòng thử lại sau!')
	EndIf
EndFunc   ;==>_Cookie

;==============================_Login===========================
Func _Login()
	;While 1
	$acc = GUICtrlRead($Account)
	$pass = GUICtrlRead($Password)
	$in__VIEWSTATE = StringRegExp($source_login[1], 'name="__VIEWSTATE" id="__VIEWSTATE" value="(.*?)"', 1)
	$in__VIEWSTATEGENERATOR = StringRegExp($source_login[1], 'name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="(.*?)"', 1)
	Local $aForm = [['__EVENTTARGET', ''], ['__EVENTARGUMENT', ''], ['__VIEWSTATE', $in__VIEWSTATE[0]], ['__VIEWSTATEGENERATOR', $in__VIEWSTATEGENERATOR[0]], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtTaiKhoa', $acc], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$txtMatKhau', $pass], ['ctl00$ContentPlaceHolder1$ctl00$ucDangNhap$btnDangNhap', 'Đăng Nhập']]
	$data_login = _HttpRequest_DataFormCreate($aForm)
	;FileWrite(@ScriptDir&'\data.txt', $data_login)
	$login = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/default.aspx', $data_login, $cookie, 'http://ftugate.ftu.edu.vn/default.aspx', $user_agent & '|Origin: http://ftugate.ftu.edu.vn|Origin: http://ftugate.ftu.edu.vn|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')
		;	FileDelete(@ScriptDir & '\test1.html')
		;	FileWrite(@ScriptDir & '\test1.html', $login)
		;	ShellExecute(@ScriptDir & '\test1.html')
	If StringInStr($login, ' không được phép đăng ký môn học do không trong thời gian được phân bổ') Then
		_Text('Chưa đến thời gian đăng ký')
		Return False
	EndIf

; *******Dòng login này điều hướng về trang chủ??? Tạm thời bỏ đi vào ngày 15/01
	;$login = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', $user_agent & '|DNT: 1|Connection: keep-alive|Upgrade-Insecure-Requests: 1')

	If StringRegExp($login, 'font-weight:bold;">Chào bạn (.*?)</span>&nbsp', 0) = 1 Then
		Global $ten = StringRegExp($login, 'font-weight:bold;">Chào bạn (.*?)</span>&nbsp', 1)[0]
		If $ten = '' Then
			If (StringInStr($login, "ctl00_ContentPlaceHolder1_ctl00_ucDangNhap_lblError") > 0) Then
				If StringInStr($login, "Hệ thống đang bận vì quá tải") > 0 Or StringInStr($login, "Please login again after 10 minutes") > 0 Then
					_Text("[LOGIN] Hệ thống quá tải, hãy thử lại sau")
				ElseIf StringInStr($login, "Sai thông tin") > 0 Then
					_Text("[LOGIN] Sai thông tin đăng nhập")
					GUICtrlSetBkColor($LAccount, "0xf4564d")
					GUICtrlSetBkColor($LPassword, "0xf4564d")
				ElseIf StringInStr($login, 'ngoài thời gian') > 0 Then
					_Text("[LOGIN] Ngoài thời gian đăng ký môn học")
				Else
					_Text("[LOGIN] Lỗi không xác định")
				EndIf
			ElseIf StringInStr($login, 'trở lại sau 15 phút') > 0 Then
					_Text('Server đang tải lại dữ liệu. Vui lòng trở lại sau 15 phút!')
			ElseIf StringInStr($login, 'liên hệ quản trị viên') > 0 Then
					_Text('Tài khoản của bạn đã bị khóa')
			EndIf
		ElseIf $ten <> '' Then
			$tlogin = 0
			;ShellExecute(@ScriptDir & '\Alert.mp3')
			GUICtrlSetBkColor($LAccount, '-2')
			GUICtrlSetBkColor($LPassword, '-2')
			;GUICtrlSetData($Form1, $ten[0] & ' - ' & $acc)
			WinSetTitle($Form1, '', $ten)
			WinSetTitle($Form2, '', $ten)
			GUICtrlSetData($BLogin, 'LOGOUT')
			_Text("ĐĂNG NHẬP THÀNH CÔNG")
			_Text("Xin chào " & $ten)
			_Text("=====================================================")
			_Text('Đang lấy danh sách môn học....')
			_Load()
			Return True
		Else
			_Text("Lỗi không xác định")
			Return False
		EndIf
		;EndIf
		;Return False
		;EndIf

	ElseIf StringRegExp($login, 'font-weight:bold;">Hello (.*?)</span>&nbsp', 0) = 1 Then
		Global $ten = StringRegExp($login, 'font-weight:bold;">Hello (.*?)</span>&nbsp', 1)[0]
		If $ten = '' Then
			If (StringInStr($login, "ctl00_ContentPlaceHolder1_ctl00_ucDangNhap_lblError") > 0) Then
				If StringInStr($login, "Hệ thống đang bận vì quá tải") > 0 Or StringInStr($login, "Please login again after 10 minutes") > 0 Then
					_Text("[LOGIN] Hệ thống quá tải, hãy thử lại sau")
				ElseIf StringInStr($login, "Sai thông tin") > 0 Then
					_Text("[LOGIN] Sai thông tin đăng nhập")
					GUICtrlSetBkColor($LAccount, "0xf4564d")
					GUICtrlSetBkColor($LPassword, "0xf4564d")
				ElseIf StringInStr($login, 'ngoài thời gian') > 0 Then
					_Text("[LOGIN] Ngoài thời gian đăng ký môn học")
				Else
					_Text("[LOGIN] Lỗi không xác định")
				EndIf
			ElseIf StringInStr($login, 'trở lại sau 15 phút') > 0 Then
					_Text('Server đang tải lại dữ liệu. Vui lòng trở lại sau 15 phút!')
			ElseIf StringInStr($login, 'liên hệ quản trị viên') > 0 Then
					_Text('Tài khoản của bạn đã bị khóa')
			EndIf
		ElseIf $ten <> '' Then
			$tlogin = 0
			ShellExecute(@ScriptDir & '\Alert.mp3')
			GUICtrlSetBkColor($LAccount, '-2')
			GUICtrlSetBkColor($LPassword, '-2')
			;GUICtrlSetData($Form1, $ten[0] & ' - ' & $acc)
			WinSetTitle($Form1, '', $ten)
			WinSetTitle($Form2, '', $ten)
			GUICtrlSetData($BLogin, 'LOGOUT')
			_Text("ĐĂNG NHẬP THÀNH CÔNG")
			_Text("Xin chào " & $ten)
			_Text("=====================================================")
			_Text('Đang lấy danh sách môn học....')
			_Load()
			Return True
		Else
			_Text("Lỗi không xác định")
			Return False
		EndIf
	Else
		_Text("Lỗi không xác định. Tài khoản có thể bị khóa vì học phí")
	EndIf
	;WEnd
EndFunc   ;==>_Login

;==============================_Load============================
Func _Load()
	$load_header = _HttpRequest(1, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{}', $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LoadDanhSachKhoaLop|DNT: 1')
	If StringInStr($load_header, 'HTTP/1.1 200 OK') Then
		_Text('Đã load xong danh sách môn.')
		_Text('Nhập Mã lớp tín chỉ vào ô dưới để tiến hành đăng kí (REG) hoặc xóa môn (DELETE)')
		_Text('Để trắng và nhấn Check List để xem kết quả đăng ký')
		_Text('Nhập tên hoặc mã môn cần lọc và nhấn Check List để xem danh sách các lớp tín chỉ')
		_Text('VD: Nhập XHH101E(1-1920).1_LT để chọn môn Xã hội học .1')
	Else
		_Text('Chưa load được danh sách.... Vui lòng thử lại sau')
		_Load()
	EndIf
EndFunc   ;==>_Load

;==============================_Reg=============================
Func _Reg()
	Dim $sub_data[3]
	$sub_data[2] = StringStripWS(GUICtrlRead($CMD), 8)
	If StringInStr($sub_data[2], ' ') = 0 Then
		$sub_data[1] = StringRegExp($sub_data[2], '(.*?)\(', 1)[0]
	Else
		$sub_data[1] = StringRegExp($sub_data[2], '(.*?) \(', 1)[0]
	EndIf
	$sub_data[0] = StringReplace(StringReplace(StringReplace(StringReplace(StringReplace($sub_data[2], '(', '\('), ')', '\)'), '/', '\/'), '+', '\+'), '.', '\.')
	$fix = $sub_data[1] & $sub_data[0]
	If StringInStr($sub_data[2], 'GDTC') Then
		$fix = $sub_data[1] & ' ' & $sub_data[0]
	EndIf
	$kqloc = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"dkLoc":' & '"' & $sub_data[1] & '"' & '}', $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LocTheoMonHoc')
	;FileDelete(@ScriptDir & '\after.html')
	;FileWrite(@ScriptDir & '\after.html', $kqloc)
	;ShellExecute(@ScriptDir & '\after.html')
	;FileDelete(@ScriptDir & '\key.txt')
	;FileWrite(@ScriptDir & '\key.txt', "align='center'>" & $sub_data[0] & "(.*?)\\r\\n")
	;ShellExecute(@ScriptDir & '\key.txt')
	If StringInStr($kqloc, 'System.NullReferenceException') Then
		_Text('Tài khoản đã bị đăng xuất. Vui lòng đăng nhập lại.')
	EndIf
	If StringInStr($kqloc, 'Không có môn học được mở') Then
		_Text('Mã môn học hoặc mã lớp tín chỉ không chính xác.')
	ElseIf StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 0) = 1 Then
		If StringInStr(StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 1)[0], 'Hết') Or StringInStr(StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 1)[0], 'lblFull') Or StringInStr(StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 1)[0], 'Full') Then
		_Text('Môn ' & $sub_data[2] & ' đã hết slot')
		GUICtrlCreateListViewItem($sub_data[1] & '|' & $sub_data[2] & '|' & 'Hết Slot', $ListView1)
		FileWriteLine(@ScriptDir &'\Logs\'& $ten & '.txt', $sub_data[2] & ': ' & ' Hết Slot')
		Else
			$tach = StringRegExp($kqloc, "id='chk_" & $fix & "  '  \\r\\nvalue=\\" & '"(.*?)\\"', 1)
			If $tach <> 0 Then
				Global $split_data = StringSplit($tach[0], '|')
				If $split_data[0] >= 13 Then
					_Text('Đang gửi lệnh đăng kí môn ' & $sub_data[2] &' đến máy chủ....')
					;$dkmh = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', '', $cookie, '', $user_agent & '')
					$data_reg = '{"check":true,"maDK":"' & $split_data[1] & '","maMH":"' & $split_data[2] & '","tenMH":"' & $split_data[3] & '","maNh":"' & $split_data[4] & '","sotc":"' & $split_data[5] & '","strSoTCHP":"' & $split_data[6] & '","ngaythistr":"' & $split_data[7] & '","tietbd":"' & $split_data[8] & '","sotiet":"' & $split_data[9] & '","soTCTichLuyToiThieuMonYeuCau":"' & $split_data[10] & '","choTrung":"' & $split_data[11] & '","soTCMinMonYeuCau":"' & $split_data[12] & '","maKhoiSinhVien":"' & $split_data[13] & '"}'
					;			FileWrite(@ScriptDir&'\test1.txt',$data_reg)
					$reg = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', $data_reg, $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: DangKySelectedChange')
					$return = StringSplit($reg, '|')
					;		FileDelete(@ScriptDir&'\tienquyet.html')
					;		FileWrite(@ScriptDir&'\tienquyet.html',$reg)
					;		ShellExecute(@ScriptDir&'\tienquyet.html')
					;If StringInStr($reg, 'Ngoài thời gian đăng ký') <> 0 Then
					If $return[0] > 30 Then
						If Number($return[10]) == 0 Then
							If (($return[7] = "") Or StringInStr($return[7], 'cần học trước')) And $return[8] == "" And $return[11] == "" Then
								;If $return[7] == "" And $return[8] == "" And $return[11] == "" Then
								_Text("[REG] Được đăng ký, đang lưu dữ liệu")
								$data_reg = '{"isValidCoso":false,"isValidTKB":false,"maDK":"' & $split_data[1] & '","maMH":"' & $split_data[2] & '","sotc":"' & $split_data[5] & '","tenMH":"' & $split_data[3] & '","maNh":"' & $split_data[4] & '","strsoTCHP":"' & $split_data[6] & '","isCheck":"true","oldMaDK":"' & $return[5] & '","strngayThi":"' & $split_data[7] & '","tietBD":"' & $split_data[8] & '","soTiet":"' & $split_data[9] & '","isMHDangKyCungKhoiSV":"' & $return[36] & '"}'
								$check_luu = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', $data_reg, $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LuuVaoKetQuaDangKy')
								_Text('Đăng kí xong môn: ' & $split_data[3])
								GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thành Công', $ListView1)
								FileWriteLine(@ScriptDir &'\Logs\'& $ten & '.txt', $sub_data[2] & ': ' & ' Thành Công')
								_Text($split_data[3])
							Else
								GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thất Bại', $ListView1)
								FileWriteLine(@ScriptDir &'\Logs\'& $ten & '.txt', $sub_data[2] & ': ' & ' Thất Bại')
								;If ($return[7] <> "") Then
								;	_Text("[REG] Lỗi Tiên quyết: " & $return[7])
								If ($return[8] <> "") Then _Text("[REG] Lỗi " & $return[8])
								If ($return[11] <> "") Then _Text("[REG] Lỗi môn này ko thể tự đăng ký do phần tử 11 = " & $return[11])
							EndIf
						Else
							GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Trùng lịch', $ListView1)
							FileWriteLine(@ScriptDir &'\Logs\'& $ten & '.txt', $sub_data[2] & ': ' & ' Trùng lịch')
							_Text("[REG] Bạn bị trùng lịch môn học này")
						EndIf
					Else
						_Text("[REG] Tách dữ liệu đăng ký thất bại.")
						GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thất Bại', $ListView1)
						FileWriteLine(@ScriptDir &'\Logs\'& $ten & '.txt', $sub_data[2] & ': ' & ' Thất Bại')
					EndIf
					;Else
					;	_Text("[REG] Chưa đến thời gian đăng kí.")
					;	GUICtrlCreateListViewItem($split_data[3] & '|' & $sub_data[2] & '|' & 'Thất Bại', $ListView1)
					;EndIf
				EndIf
			Else
				_Text('Lỗi trong mã nguồn')
				FileDelete(@ScriptDir & '\Loidk.html')
				FileWrite(@ScriptDir & '\Loidk.html', $kqloc)
				ShellExecute(@ScriptDir & '\Loidk.html')
			EndIf
		EndIf
	Else
		_Text('Mã lớp hoặc mã nguồn có vấn đề.')
		GUICtrlCreateListViewItem($sub_data[1] & '|' & $sub_data[2] & '|' & 'Mã Nguồn?', $ListView1)
		FileWriteLine(@ScriptDir &'\Logs\'& $ten & '.txt', $sub_data[2] & ': ' & ' Mã Nguồn?')
		Return False
	EndIf
EndFunc   ;==>_Reg

;==============================_Del=============================
Func _Del()
	_Text('Đang gửi lệnh xóa môn....')
	;$dkmh = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', '', $cookie, '', $user_agent & '')
	Dim $sub_data[3]
	$sub_data[2] = StringStripWS(GUICtrlRead($CMD), 8)
	If StringInStr($sub_data[2], ' ') = 0 Then
		$sub_data[1] = StringRegExp($sub_data[2], '(.*?)\(', 1)[0]
	Else
		$sub_data[1] = StringRegExp($sub_data[2], '(.*?) \(', 1)[0]
	EndIf
	$fix = $sub_data[1] & $sub_data[2]
	If StringInStr($sub_data[2], 'GDTC') Then
		$fix = $sub_data[1] & ' ' & $sub_data[0]
	EndIf
	$data_del = '{"danhSachMaDangKy":",' & $fix & '  "}'
	$del = _HttpRequest(0, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', $data_del, $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: XoaKQDKTheoMaDK')
	;FileWrite(@ScriptDir&'\del.txt',$end[1])
	;ShellExecute(@ScriptDir&'\del.txt')
	_Text('Xóa môn ' & $sub_data[2] & ' thành công!')
	GUICtrlCreateListViewItem($sub_data[1] & '|' & $sub_data[2] & '|' & 'Đã Xóa', $ListView1)
EndFunc   ;==>_Del

;==============================_Logout==========================
Func _Logout()
	$source_logout = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/', '', $cookie, '', $user_agent & '|Upgrade-Insecure-Requests: 1')
	$out__VIEWSTATE = StringRegExp($source_logout, 'name="__VIEWSTATE" id="__VIEWSTATE" value="(.*?)"', 1)[0]
	$out__VIEWSTATEGEN = StringRegExp($source_logout, 'name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="(.*?)"', 1)[0]
	Local $aFormOut = [['__EVENTTARGET', 'ctl00$Header1$Logout1$lbtnLogOut'], ['__EVENTARGUMENT', ''], ['__VIEWSTATE', $out__VIEWSTATE], ['__VIEWSTATEGENERATOR', $out__VIEWSTATEGEN]]
	$data_logout = _HttpRequest_DataFormCreate($aFormOut)
	$logout = _HttpRequest(1, 'http://ftugate.ftu.edu.vn/default.aspx?page=gioithieu', $data_logout, $cookie, '', $user_agent & '|Upgrade-Insecure-Requests: 1')

	If StringInStr($logout, 'http://ftugate.ftu.edu.vn/default.aspx') Then
		_Text('Đăng xuất thành công')
		_GUICtrlListView_DeleteAllItems($ListView1)
		GUICtrlSetData($BLogin, 'LOGIN')
		WinSetTitle($Form1, '', "AutoReg - FLONE by  Trần Thanh Hùng Version 3.0.4")
		WinSetTitle($Form2, '', "AutoReg - FLONE by  Trần Thanh Hùng Version 3.0.4")
		GUICtrlSetData($Edit1, '')
		_Text('Programed by Trần Thanh Hùng')
		_Text('Contact me: Facebook.com/htth.cursed')

	Else
		_Text('Không thể đăng xuất, vui lòng thử lại')
	EndIf
EndFunc   ;==>_Logout

;==============================_Alert===========================
Func _Alert()
	GUICtrlSetData($Alert, 'Waiting...')
	Dim $sub_data[3]
	$sub_data[2] = StringStripWS(GUICtrlRead($CMD), 8)
	If StringInStr($sub_data[2], ' ') = 0 Then
		$sub_data[1] = StringRegExp($sub_data[2], '(.*?)\(', 1)[0]
	Else
		$sub_data[1] = StringRegExp($sub_data[2], '(.*?) \(', 1)[0]
	EndIf
	$sub_data[0] = StringReplace(StringReplace(StringReplace(StringReplace(StringReplace($sub_data[2], '(', '\('), ')', '\)'), '/', '\/'), '+', '\+'), '.', '\.')
	$fix = $sub_data[1] & $sub_data[0]
	If StringInStr($sub_data[2], 'GDTC') Then
		$fix = $sub_data[1] & ' ' & $sub_data[0]
	EndIf
	$cf = 0
	While 1
		$kqloc = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/ajaxpro/EduSoft.Web.UC.DangKyMonHoc,EduSoft.Web.ashx', '{"dkLoc":' & '"' & $sub_data[1] & '"' & '}', $cookie, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', $user_agent & '|X-AjaxPro-Method: LocTheoMonHoc')
		;FileDelete(@ScriptDir & '\after.html')
		;FileWrite(@ScriptDir & '\after.html', $kqloc)
		;ShellExecute(@ScriptDir & '\after.html')
		;FileDelete(@ScriptDir & '\key.txt')
		;FileWrite(@ScriptDir & '\key.txt', "align='center'>" & $sub_data[0] & "(.*?)\\r\\n")
		;ShellExecute(@ScriptDir & '\key.txt')
		If StringInStr($kqloc, 'Không có môn học được mở') Then
			_Text('Mã môn học hoặc mã lớp tín chỉ không chính xác.')
			ExitLoop
		ElseIf StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 0) = 1 Then
			If StringInStr(StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 1)[0], 'Hết') Or StringInStr(StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 1)[0], 'lblFull') Or StringInStr(StringRegExp($kqloc, "align='center'>" & $sub_data[0] & "(.*?)\\r\\n", 1)[0], 'Full') Then
				_Text('Môn ' & $sub_data[2] & ' đã hết slot')
				$cf = 0
			EndIf
		Else
			$cf += 1
			If $cf > 1 Then
				ShellExecute(@ScriptDir & '\Alert.m4a')
				GUICtrlSetData($Alert, 'Set Alert')
				ExitLoop
			EndIf
		EndIf
		$k = 0
		While 1
			$k += 1
			;ConsoleWrite($k & @CRLF)
			If _IsPressed("C0") Then
				_Text('Đã dừng check slot')
				GUICtrlSetData($Alert, 'Set Alert')
				ExitLoop 2
			ElseIf $k > 100 Then
				Sleep(Random(3000, 5000, 1))
				ExitLoop 1
			EndIf
			Sleep(20)
		WEnd
	WEnd
EndFunc   ;==>_Alert

#cs
	While 1
		$dkmh = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/Default.aspx?page=dkmonhoc', '', $cookie, '', $user_agent & '')
		If StringInStr($dkmh, 'ngoài thời gian') Then
			Sleep(Random(3500, 7000, 1))
			ContinueLoop
		Else
			ShellExecute(@ScriptDir & '\Alert.m4a')
			GUICtrlSetData($Alert, 'Set Alert')
			ExitLoop
		EndIf
	WEnd

EndFunc   ;==>_Alert
#ce

;==============================_About===========================
Func _showAboutDialog($softwareName, $version, $author, $copyrightStart = Default, $copyrightEnd = Default, $website = Default, $hwnd = Default, $icon = Default, $width = Default, $height = Default, $colorbg = Default, $colofg = Default)
	Opt("GUIOnEventMode", 0)

	If $hwnd = Default Then $hwnd = WinGetHandle(AutoItWinGetTitle())
	Global $colorfg = Default
	; Icon
	Local $iconName = -1
	If $icon = Default Then
		$icon = (@Compiled) ? @ScriptFullPath : 'shell32.dll'
		If Not @Compiled Then $iconName = 3     ; icon from shell32.dll
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
		Local $labelWebsite = GUICtrlCreateLabel('https://www.facebook.com/htth.cursed', 80, 80, 300, 25)
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

;==============================_Schedule===========================
Func _Schedule()
	$post_sch = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/Default.aspx?page=thoikhoabieu&id=' & GUICtrlRead($Account))
#cs
$hocki = 20202
	$get_sch = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/Default.aspx?page=thoikhoabieu&id=' & GUICtrlRead($Account), '', $cookie, 'http://ftugate.ftu.edu.vn/default.aspx?page=dkmonhoc', $user_agent & '|Upgrade-Insecure-Requests: 1')
	$ViewStateSch = StringRegExp($get_sch, 'name="__VIEWSTATE" id="__VIEWSTATE" value="(.*?)"', 1)[0]
	$ViewStateGenSch = StringRegExp($get_sch, 'name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="(.*?)"', 1)[0]

	Local $aFormSch = [['__EVENTTARGET', 'ctl00$ContentPlaceHolder1$ctl00$rad_ThuTiet'], ['__EVENTARGUMENT', ''], ['__LASTFOCUS', ''], ['__VIEWSTATE', $ViewStateSch], ['__VIEWSTATEGENERATOR', $ViewStateGenSch], ['ctl00$ContentPlaceHolder1$ctl00$ddlChonNHHK', $hocki], ['ctl00$ContentPlaceHolder1$ctl00$ddlLoai', '1'], ['ctl00$ContentPlaceHolder1$ctl00$rad_ThuTiet', 'rad_ThuTiet'], ['ctl00$ContentPlaceHolder1$ctl00$rad_MonHoc', 'rad_MonHoc']]
	$data2send = _HttpRequest_DataFormCreate($aFormSch)
	$post_sch = _HttpRequest(2, 'http://ftugate.ftu.edu.vn/Default.aspx?page=thoikhoabieu&id=' & GUICtrlRead($Account), $data2send, $cookie, '', $user_agent & '|DNT: 1|Host: ftugate.ftu.edu.vn|Origin: http://ftugate.ftu.edu.vn|Upgrade-Insecure-Requests: 1')
#ce
	FileDelete(@ScriptDir & '\tkb1.html')
	FileWrite(@ScriptDir & '\tkb1.html', $post_sch)
	ShellExecute(@ScriptDir & '\tkb1.html')
EndFunc   ;==>_Schedule

#EndRegion Functions



#cs

Updated: 11/1/2021
Đã làm:
	+) Thêm xxx để xóa dấu cách khi insert xxx, tránh bị lỗi
	+) Đã tối ưu thời gian xxx
	+) Sửa func xxx giúp xxx nhanh hơn....
	+) Thêm tính năng xxx để báo động khi xxx (Đang thử nghiệm)
	+) Thêm button xxx plan, xxx theo list có sẵn
	+) Thêm tính năng tự ghi log file đăng ký/xóa môn : Thành công/thất bại/....
	+) Tối ưu chọn đường dẫn, đỡ mất công tìm
Cần làm:
	+) 'Server đang tải lại dữ liệu. Vui lòng trở lại sau 15 phút!'
	+) Sửa thống báo: stringreg() if @error then mb(@error)
	+) Mày cần thêm tính năng đăng ký bằng cách lấy data trực tiếp từ Google Sheet
	+) Sửa xxx để, thay [0] sau stringreg bằng 1 biến riêng ra để If @error được, tránh trường hợp tool tự đóng bất thường
	+) Thêm tính năng tự động đăng ký phương án dự phòng

#ce







