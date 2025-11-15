#Requires AutoHotkey v2.0

; لیست تمام برنامه‌هایی که در آن‌ها دکمه‌های موس عمل می‌کنند
apps := [
    "msedge.exe", "chrome.exe", "firefox.exe", "opera.exe",
    "obsidian.exe", "explorer.exe", "notepad.exe",
    "freeplane.exe", "PDFXEdit.exe", "Code.exe",
    "Everything.exe", "Paint.exe", "winword.exe"
]

; برنامه‌های تب‌دار که Ctrl+W آنها تب فعال را می‌بندد
tabApps := ["msedge.exe","chrome.exe","firefox.exe","opera.exe","Code.exe","freeplane.exe","PDFXEdit.exe","winword.exe","obsidian.exe","Everything.exe"]

; تابع بررسی اینکه آیا برنامه فعال در لیست هست یا نه
IsTargetApp() {
    global apps
    win := WinGetProcessName("A")
    for app in apps {
        if (win = app)
            return true
    }
    return false
}

; -------------------------
; XButton1 → بستن تب یا برنامه بسته به برنامه فعال
; -------------------------
#HotIf
XButton1::
{
    hwnd := WinGetID("A")
    process := WinGetProcessName("A")

    ; Paint → همیشه Alt+F4
    if (process = "mspaint.exe") {
        Send("!{F4}")
        return
    }

    ; Explorer → Ctrl+F4، اگر تب نبود Alt+F4
    if (process = "explorer.exe") {
        Send("^{F4}")
        Sleep(50)
        if (WinGetID("A") = hwnd)
            Send("!{F4}")
        return
    }

    ; برنامه‌های تب‌دار → Ctrl+W
    for app in tabApps {
        if (process = app) {
            Send("^w")
            return
        }
    }

    ; برنامه‌های دیگر → Alt+F4
    Send("!{F4}")
    return
}
#HotIf

; -------------------------
; دکمه ۵ موس → Alt+Left (برگشت یا عقب)
; -------------------------
XButton2::Send("!{Left}")
