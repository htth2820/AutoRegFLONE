#include <MsgBoxConstants.au3>

; Press Esc to terminate script, Pause/Break to "pause"

Global $g_bPaused = False

HotKeySet("^+X", "TogglePause")  ;Ctrl+Shift+X
HotKeySet("{ESC}", "Terminate")
;HotKeySet("^+P", "_ExitLoop") ; Ctr Shift P

;Func _ExitLoop()
;	ExitLoop
;EndFunc

Func TogglePause()
	$g_bPaused = Not $g_bPaused
	While $g_bPaused
		Sleep(100)
		ToolTip('Script is "Paused"', 0, 0)
	WEnd
	ToolTip("")
EndFunc   ;==>TogglePause

Func Terminate()
	Exit
EndFunc   ;==>Terminate
