; by SKAN - http://www.autohotkey.com/community/viewtopic.php?t=41097
SafelyRemoveHardware()
{ 
  DetectHiddenWindows, On
  CoordMode, Mouse, Screen
  MouseGetPos, mouseX1, mouseY1
  MouseMove, A_ScreenWidth, A_ScreenHeight, 0
  hWnd := WinExist( "ahk_class SystemTray_Main" )
  if (WinExist(ahk_id %hWnd%))
  {
  SendMessage, 1226, 1226, 0x201,, ahk_id %hWnd% ; Left Click down
  SendMessage, 1226, 1226, 0x202,, ahk_id %hWnd% ; Left Click Up
  WinWaitActive, ahk_id %hWnd%,,1                ; Wait for SRH Tray left-click-Menu
  ControlSend,,{Down},ahk_id %hWnd%
  }
  if (WinActive(ahk_id %hWnd%))
  {
  ; TODO!
  Notify("No USB-Devices connected","",5)
  }
  MouseMove, %mouseX1%, %mouseY1%, 0
  CoordMode, Mouse, Relative
  DetectHiddenWindows, Off
}