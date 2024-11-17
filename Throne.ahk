class KeyPressTracker {
	static keyPressCount := 0
	static sendKey := ""
	static delay := 0

	; Setup key and delay for eventual send
	constructor(key, delay) {
		keyPressCount := 0
	}

	KeyPressedPreviously(){
		return keyPressCount > 0
	}
}

$1::{
	static key1_presses := 0

	If (TLProcessExists() and WinActiveTitleIsTL())
	{
		if key1_presses > 0
		{
			return
		}
		
		key1_presses += 1
		Send "1"
		
		SetTimer SendKey1AfterDelay, 2950
	} else {
		Send "1"
	}
}

$3::{
	static key3_presses := 0

	If (TLProcessExists() and WinActiveTitleIsTL())
	{
		if key3_presses > 0
		{
			return
		}
		
		key3_presses += 1
		Send "3"
		
		SetTimer SendKey3AfterDelay, 8950
	} else {
		Send "3"
	}
}

TLProcessExists(){
	return ProcessExist("TL.exe")
}
	
WinActiveTitleIsTL(){
	activeWinTitle := WinGetTitle("A")
	return InStr(activeWinTitle, "TL")
}
	
SendKey1AfterDelay(){
	Send "1"
	key1_presses := 0
}

SendKey3AfterDelay(){
	Send "3"
	key3_presses := 0
}