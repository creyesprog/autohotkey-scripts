$1:: {
	static key1 := "1"
    static key1Handler := KeyPressHandler(key1, -2950)
    if (TLProcessExists() and WinActiveTitleIsTL()) {
        if key1Handler.KeyPressedPreviously() {
            return
        }

        key1Handler.PressKey()

        PressKeyAfterDelay(&key1Handler)
    } else {
        Send key1
    }
}

$3:: {
	static key3 := "3"
	static key3Handler := KeyPressHandler(key3, -8950)
    if (TLProcessExists() and WinActiveTitleIsTL()) {
        if key3Handler.KeyPressedPreviously() {
            return
        }

        key3Handler.PressKey()

        PressKeyAfterDelay(&key3Handler)
    } else {
        Send key3
    }
}

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
