$1:: {
    static key1 := "1"
	
    static filter := KeyPressFilter(key1)
    if (!filter.CanContinue()) {
        return
    }

    static handler := KeyPressHandler(key1, -2950)
    if handler.KeyPressedPreviously() {
        return
    } else {
        handler.PressKey()
        SetupPressKeyAfterDelay(&handler)
    }
}

$3:: {
    static key3 := "3"

	static filter := KeyPressFilter(key3)
    if (!filter.CanContinue()) {
        return
    }

    static handler := KeyPressHandler(key3, -8950)
    if handler.KeyPressedPreviously() {
        return
    } else {
        handler.PressKey()
        SetupPressKeyAfterDelay(&handler)
    }
}

class KeyPressFilter {
	sendKey := ""

	; Setup key
    __New(sendKey) {
        this.sendKey := sendKey
    }

	CanContinue() {
		if (!this.WinActiveTitleIsTL()) {
			Send this.sendKey
		}
	
		if (this.TLProcessExists() && !this.WinActiveTitleIsTL()) {
			return 0
		}

		return 1
	}

	TLProcessExists() {
		return ProcessExist("TL.exe")
	}
	
	WinActiveTitleIsTL() {
		activeWinTitle := WinGetTitle("A")
		return InStr(activeWinTitle, "TL")
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
