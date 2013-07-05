; by SWIN - http://www.autohotkey.com/community/viewtopic.php?t=8086
RefreshTray() {
   WM_MOUSEMOVE := 0x200
   ControlGetPos, xTray,, wTray,, ToolbarWindow321, ahk_class Shell_TrayWnd
   endX := xTray + wTray
   x := 5
   y := 12
   Loop
   {
      if (x > endX)
         break
      point := (y << 16) + x
      PostMessage, %WM_MOUSEMOVE%, 0, %point%, ToolbarWindow321, ahk_class Shell_TrayWnd
      x += 18
   }
}
