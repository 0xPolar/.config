#Requires AutoHotkey v2.0
; Toggle suspension with Ctrl+Alt+P
^!p::Suspend -1  ; -1 = toggle, 0 = off, 1 = on

; Use a hook to completely intercept CapsLock before Windows processes it
*CapsLock::
{
    ; Wait for CapsLock to be released or timeout
    result := KeyWait("CapsLock", "T0.2")  ; Wait 200ms
    
    if (!result) {  ; Timeout occurred - key was held down
        ; It's being held - act as Hyper modifier
        Send "{Ctrl down}{Alt down}{Shift down}"
        KeyWait "CapsLock"  ; Wait for release
        Send "{Ctrl up}{Alt up}{Shift up}"
    } else {
        ; It was tapped - toggle CapsLock manually
        SetCapsLockState !GetKeyState("CapsLock", "T")
    }
}

; Ensure CapsLock state doesn't change from system
*CapsLock up::return