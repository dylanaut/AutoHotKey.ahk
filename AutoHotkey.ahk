#NoEnv  							  
#SingleInstance, Force  
SendMode Input 

#include %A_ScriptDir%\Lib\0x4a.ahk
#include %A_ScriptDir%\Lib\Tray.ahk
#include %A_ScriptDir%\Lib\Notify.ahk
#include %A_ScriptDir%\Lib\FlashScreen.ahk
#include %A_ScriptDir%\Lib\RefreshTray.ahk

toolDir = F:\tools
toolCryptDir = Y:\tools

SetWorkingDir %toolDir% 

Gosub, TRAYMENU   
Gosub, NOTIFY_STARTUP

/*
run tools on truecrypt ONLY when mountet, otherwise msgbox and offer to mount it
--> funtion runcrypto & runcryptooractivate

tools direkt aus dropbox starten und F als backup, nich umgeklehrt

tools to add:
startclock
windowdrag
pick rgb
addquotes.ahk
AeroSnap
clipstep.ahk
fastnavkeys.ahk
globale-autokorrektur.ahk
IdleMute 
PlainPaste
ReRun
ShowOff
WinWarden
ZoneSize
tc_SetTitleBar2ActivePath


tofix:
qmc mouseclick close nur ausserhalb
keynote shortcut wenns schon läuft error
tray-funktionen nutzen
about
namen & pfade in variablen speichern
labels&gosubs durch funktionen ersetzen
errors & messages unten links popup
funktion für programme im tray checken und bei uncheck beenden
-->checkstate dynamisch statt flipflop

hotstrings toggle
startclock toggle
twofingerscroll toggle    
filenotfound bei run !!!
menu für alle shortcuts
tweak flash()

*/



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	KEYBOARD SHORTCUTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SHORTCUTS: 
#n::Run %toolDir%\open\Notepad2\Notepad2.exe
#u::Run %toolDir%\control\Total Commander\utils\USBDiskEjector\USB_Disk_Eject.exe
#k::Run %toolDir%\control\KeePass\KeePass.exe
#p::RunOrActivate(toolDir "\control\KiTTY\mtputty.exe", "MTPuTTY")
#s::RunOrActivate(toolDir "\control\WinSCP\WinSCP.exe", "WinSCP")
#a::Run %toolCryptDir%\Audio\foobar2000\foobar2000.exe
#v::RunOrActivate(A_ProgramFiles "\VideoLAN\VLC\vlc.exe", "VLC")
#t::RunOrActivate(toolDir "\control\clink\clink.bat", "ahk_class ConsoleWindowClass")
#c::RunOrActivate(A_ProgramFiles "\Miranda IM\miranda32.exe", "ahk_class Miranda")
#i::RunOrActivate(A_ProgramFiles "\Mozilla Firefox\firefox.exe", "ahk_class MozillaWindowClass", "newtab")
#m::PostMessage, 0x112, 0xF020,,,A
#y::RunOrActivate(toolCryptDir "\emacs\emacs.bat", "ahk_class Emacs")
PrintScreen::Run %toolDir%\util\fscapture\FSCapture.exe



; Process Hacker
^+esc::Run %toolDir%\control\processhacker\x86\ProcessHacker.exe

;total commander
#SPACE::
  if not WinExist( "ahk_class TTOTAL_CMD" )
		Run %toolDir%\control\totalcmd\TOTALCMD.EXE
	WinActivate
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	Hotstrings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; #include %A_ScriptDir%\Lib\globale-autokorrektur.ahk

HOTSTRINGS:
::!mfg::Mit freundlichen Grüßen  
::ijmd::irgendjemand
::iwas::irgendwas
::iwo::irgendwo
::iwie::irgendwie
::iwann::irgendwann



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	Program Tweaks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TWEAKS:

; Turn off Caps Lock
CapsLock::AppsKey


; PROCESS HACKER: close on esc
#ifWinActive ahk_class ProcessHacker
    $Escape::SendInput !{F4}
            
; FIREFOX: use STRG-E for SEARCH
#IfWinActive ahk_class MozillaWindowClass
    $^e::SendInput ^{k}

; FIREFOX: use STRG-Space for LOCATION BAR
#IfWinActive ahk_class MozillaWindowClass
    $^SPACE::SendInput ^{l}
    
; cmd.exe: close on Strg + D
#IfWinActive ahk_class ConsoleWindowClass
    $^d::SendInput exit{enter}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	Labels
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TRAYMENU:  
; names for menu items   
applicationname = Jekyll's Autohotkey  
str_StartClock := "Start-Button Clock"
str_WindowDrag := "Easy Window Drag"
str_ImCaro := "Caro ICQ"
str_RGB := "RGB Picker"


Menu,Tray,Icon, %A_ScriptDir%\Lib\key.ico

Menu,ahkmenu,Standard   

Menu,toolsmenu,Add,%str_WindowDrag%,WINDOWDRAG
Menu,toolsmenu,Add,%str_RGB%,RGB_PICK
Menu,toolsmenu,Add,
Menu,toolsmenu,Add,WLAN,NET_WLAN
Menu,toolsmenu,Add,Bluetooth,NET_BT


Menu,Tray,Tip,%applicationname%                                            
Menu,Tray,NoStandard
Menu,Tray,DeleteAll

Menu,Tray,Add,Autohotkey, :ahkmenu
Menu,Tray,Add,Tools, :toolsmenu
Menu,Tray,Add,
Menu,Tray,Add,About..., ABOUT
Menu,Tray,Add,E&xit,EXIT   

CheckTrayMenu("EasyWindowDrag.exe", str_WindowDrag)                         
return

NOTIFY_STARTUP:
  notify_options:="GC=D4D0C8 GR=0 BR=0 BW=2 TS=8 TF=segoe ui BK=005555 MC=000000 BC=000000"
  notify_text= %applicationname% started
  Notify(notify_text, "" ,5,notify_options) ;= pretty simple
return

ABOUT:
	#include %A_ScriptDir%\Lib\aboutmenu.ahk
return

NET_WLAN:
BlockInput, on
CoordMode, Mouse, Screen
pos := Tray_Define(3, "i") 
Tray_Click(pos, "L")
CoordMode, Mouse, Relative
BlockInput off
return

NET_BT:
BlockInput, on
CoordMode, Mouse, Screen
pos := Tray_Define("BTTRAY.EXE", "i") 
Tray_Click(pos, "R")
sleep 100
Send, {up}{Enter}
CoordMode, Mouse, Relative
BlockInput off
return

WINDOWDRAG:
; Easy Window Dragging -- KDE style (requires XP/2k/NT) -- by Jonny
; http://www.autohotkey.com
RunFromTrayMenu("", str_WindowDrag)
return

RGB_PICK:
return



EXIT:
ExitApp





