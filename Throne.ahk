class KeyPressHandler extends Object {
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

$1:: {
    static key1Handler := KeyPressHandler("1", -2950)
    if (TLProcessExists() and WinActiveTitleIsTL()) {
        if key1Handler.KeyPressedPreviously() {
            return
        }

        key1Handler.PressKey()

        PressKeyAfterDelay(&key1Handler)
    } else {
        Send "1"
    }
}

$3:: {
    static key3_presses := 0

    if (TLProcessExists() and WinActiveTitleIsTL()) {
        if key3_presses > 0 {
            return
        }

        key3_presses += 1
        Send "3"

        SetTimer SendKey3AfterDelay, -8950
    } else {
        Send "3"
    }
}

TLProcessExists() {
    return ProcessExist("TL.exe")
}

WinActiveTitleIsTL() {
    activeWinTitle := WinGetTitle("A")
    return InStr(activeWinTitle, "TL")
}

PressKeyAfterDelay(&keyHandler) {
    SetTimer () => keyHandler.PressKeyWithReset(), keyHandler.delay
}

SendKey1AfterDelay() {
    Send "1"
    key1_presses := 0
}

SendKey3AfterDelay() {
    Send "3"
    key3_presses := 0
}
