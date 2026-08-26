#Requires AutoHotkey v2.0

; カーソル移動
F13 & j::Send("{Blind}{left}")  ; ←
F13 & k::Send("{Blind}{down}")  ; ↓
F13 & i::Send("{Blind}{up}")    ; ↑
F13 & l::Send("{Blind}{right}") ; →

F13 & a::Send("{Blind}^{left}")  ; Ctrl + ←
F13 & d::Send("{Blind}^{right}") ; Ctrl + →
F13 & u::Send("{Blind}{Home}") ; Home
F13 & o::Send("{Blind}{End}")  ; End
F13 & w::Send("{Blind}{PgUp}") ; PageUp
F13 & s::Send("{Blind}{PgDn}") ; PageDown

; エディタ
F13 & f::Send("{Blind}!+f") ; Alt + Shift + f: コードのフォーマット(VSCode方式)

; 改行を削除してペースト
F13 & v:: {
    clipboardContent := A_Clipboard ; クリップボードの内容を取得

    clipboardContent := StrReplace(clipboardContent, "`r`n", "") ; `r`nを空白文字に置換
    clipboardContent := StrReplace(clipboardContent, "`n", "") ; `nを空白文字に置換

    A_Clipboard := clipboardContent ; 整形したテキストをクリップボードに戻す
    Send("+^v") ; Ctrl + Shift + v: ペーストを実行
}

; メディア操作
F13 & p::Media_Play_Pause ; メディアの再生を停止
F13 & m::Volume_Mute      ; 音声をミュート
F13 & WheelUp:: SoundSetVolume("+4")   ; 音量を上げる
F13 & WheelDown:: SoundSetVolume("-4") ; 音量を下げる

; Lockキー
#HotIf GetKeyState("Shift", "P")
F13 & c::Send("{Blind}+{CapsLock}")
F13 & n::Send("{Blind}{NumLock}")
#HotIf

; ブラウザ
F13 & ,::Send("{Blind}!{Left}")  ; Alt + ←: 前のページ
F13 & .::Send("{Blind}!{Right}") ; Alt + →: 次のページ

; 日付と時刻の挿入
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
