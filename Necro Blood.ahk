$q::{
	If WinActive("Diablo IV")
	{
		Send "q"
		Click "Right"
		Send "+{LButton}"
		Sleep 1000
		Send "e"
	}
}