$1:: {
    static key1 := "1"
    if (!WinActiveTitleIsTL()) {
        Send key1
    }

    if (TLProcessExists() && !WinActiveTitleIsTL()) {
        return
    }

    static key1Handler := KeyPressHandler(key1, -2950)
    if key1Handler.KeyPressedPreviously() {
        return
    } else {
        key1Handler.PressKey()
        SetupPressKeyAfterDelay(&key1Handler)
    }
}

$3:: {
    static key3 := "3"
    if (!WinActiveTitleIsTL()) {
        Send key3
    }

    if (TLProcessExists() && !WinActiveTitleIsTL()) {
        return
    }

    static key3Handler := KeyPressHandler(key3, -8950)
    if key3Handler.KeyPressedPreviously() {
        return
    } else {
        key3Handler.PressKey()
        SetupPressKeyAfterDelay(&key3Handler)
    }
}

class ProcessHandler extends Object {
	
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

TLProcessExists() {
    return ProcessExist("TL.exe")
}

WinActiveTitleIsTL() {
    activeWinTitle := WinGetTitle("A")
    return InStr(activeWinTitle, "TL")
}

SetupPressKeyAfterDelay(&keyHandler) {
    SetTimer () => keyHandler.PressKeyWithReset(), keyHandler.delay
}
