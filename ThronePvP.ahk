#Requires AutoHotkey v2.0

; shift + 3
+$3:: {
    static key3 := "3"

    static filter := KeyPressFilter(key3)
    if (!filter.CanContinue()) {
        return
    }

    Send key3
    Sleep 250
    Send "e"
    Sleep 400
    Send "2"
    Sleep 500
    Send "4"
    Sleep 1600
    Send "r"
}

$XButton1:: {
    static mouse4 := "X1"

    static filter := MouseClickFilter(mouse4)
    if (!filter.CanContinue()) {
        return
    }

    WinGetPos ,,&width,,"A"

    MouseClick "Left"
    MouseGetPos &xpos, &ypos
    MouseMove width, 0
    MouseClick "X1"
    MouseMove xpos, ypos
}

class InputFilterBase {
    input := ""

    ; Setup key
    __New(input) {
        this.input := input
    }

    CanContinue() {
		; Inheritors should implement this
		MsgBox "CanContinue not implemented"
    }

    TLProcessExists() {
        return ProcessExist("TL.exe")
    }

    WinActiveTitleIsTL() {
        activeWinTitle := WinGetTitle("A")
        return InStr(activeWinTitle, "TL")
    }
}

class KeyPressFilter extends InputFilterBase {

    CanContinue() {
        if (!this.WinActiveTitleIsTL()) {
            Send this.input
        }

        if (this.TLProcessExists() && !this.WinActiveTitleIsTL()) {
            return 0
        }

        return 1
    }
}

class MouseClickFilter extends InputFilterBase {

	CanContinue() {
        if (!this.WinActiveTitleIsTL()) {
            MouseClick this.input
        }

        if (this.TLProcessExists() && !this.WinActiveTitleIsTL()) {
            return 0
        }

        return 1
    }
}

class KeyPressHandler {
    keyPressCount := 0
    sendKey := ""
    delay := 0

    ; Setup key and delay for eventual send
    __New(sendKey, delay) {
        this.sendKey := sendKey
        this.delay := delay
    }

    KeyPressedPreviously() {
        return this.keyPressCount > 0
    }

    PressKey() {
        this.keyPressCount += 1
        Send this.sendKey
    }

    PressKeyWithReset() {
        Send this.sendKey
        this.keyPressCount := 0
    }
}

SetupPressKeyAfterDelay(&keyHandler) {
    SetTimer () => keyHandler.PressKeyWithReset(), keyHandler.delay
}
