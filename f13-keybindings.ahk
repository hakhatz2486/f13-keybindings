#Requires AutoHotkey v2.0
; CapsLockをF13に置き換えた前提で、F13との組み合わせをショートカットとして提供する。修飾キーの状態を保つため送信は原則{Blind}を使う。

; カーソル移動
F13 & j::Send("{Blind}{left}")  ; ←
F13 & k::Send("{Blind}{down}")  ; ↓
F13 & i::Send("{Blind}{up}")    ; ↑
F13 & l::Send("{Blind}{right}") ; →

F13 & a::Send("{Blind}^{left}")  ; Ctrl + ←
F13 & d::Send("{Blind}^{right}") ; Ctrl + →
F13 & q::Send("{Blind}{Home}") ; Home
F13 & e::Send("{Blind}{End}")  ; End
F13 & w::Send("{Blind}{PgUp}") ; PageUp
F13 & s::Send("{Blind}{PgDn}") ; PageDown

; エディタ
F13 & f::Send("{Blind}!+f") ; Alt + Shift + f: コードのフォーマット

; Lockキー
F13 & c::Send("{Blind}{CapsLock}")
F13 & n::Send("{Blind}{NumLock}")

; ブラウザ
F13 & ,::Send("{Blind}!{Left}")  ; Alt + ←: 前のページ
F13 & .::Send("{Blind}!{Right}") ; Alt + →: 次のページ

; メディア
F13 & [::Send("{Volume_Up}")
F13 & ]::Send("{Volume_Down}")
F13 & WheelUp:: SoundSetVolume("+4")   ; 音量を上げる
F13 & WheelDown:: SoundSetVolume("-4") ; 音量を下げる
F13 & m::Send("{Volume_Mute}")      ; ミュート切り替え
F13 & p::Send("{Media_Play_Pause}") ; 再生停止切り替え

; マウス
F13 & Space:: {
    ; 押下ごとに現在の速度を取得するため、通常感度をWindows側で変更しても追従する
    speed := 0
    DllCall("SystemParametersInfo", "UInt", 0x70, "UInt", 0, "UInt*", &speed, "UInt", 0) ; SPI_GETMOUSESPEED
    try {
        ; SPI_SETMOUSESPEEDはpvParamにポインタではなく値そのものを渡す仕様。速度の最小値は1
        ; fWinIniを0にしてレジストリへ保存しない。スクリプトが異常終了しても再ログインで元に戻る
        DllCall("SystemParametersInfo", "UInt", 0x71, "UInt", 0, "Ptr", Max(1, Round(speed * 0.5)), "UInt", 0) ; SPI_SETMOUSESPEED
        KeyWait("Space")
    } finally {
        DllCall("SystemParametersInfo", "UInt", 0x71, "UInt", 0, "Ptr", speed, "UInt", 0)
    }
}

; 日付と時刻の挿入(区切り文字あり)
F13 & y::SendInput(FormatTime(, "yyyy-MM-dd'T'HH:mm")) ; 2026-07-18T22:49
F13 & r::SendInput(FormatTime(, "yyyy-MM-dd"))         ; 2026-07-18
F13 & t::SendInput(FormatTime(, "HH:mm"))              ; 22:49

; 日付と時刻の挿入(区切り文字なし)
#HotIf GetKeyState("Alt", "P")
F13 & y:: {
    SendInput("{Alt up}")
    SendInput(FormatTime(, "yyyyMMdd'T'HHmm")) ; 20260724T1430
}
F13 & r:: {
    SendInput("{Alt up}")
    SendInput(FormatTime(, "yyyyMMdd")) ; 20260724
}
F13 & t:: {
    SendInput("{Alt up}")
    SendInput(FormatTime(, "HHmm")) ; 1430
}
#HotIf
