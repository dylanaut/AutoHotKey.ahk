#NoEnv  							  
#SingleInstance, Force  
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.

#include %A_ScriptDir%\Lib\0x4a.ahk
#include %A_ScriptDir%\Lib\Tray.ahk
#include %A_ScriptDir%\Lib\Notify.ahk
#include %A_ScriptDir%\Lib\SafelyRemoveHardware.ahk
#include %A_ScriptDir%\Lib\FlashScreen.ahk
#include %A_ScriptDir%\Lib\RefreshTray.ahk


dropboxDir = Y:\Dropbox


;Ensures a consistent starting directory.
SetWorkingDir %dropboxDir% 
; SetWorkingDir %A_ScriptDir% 

Gosub, TRAYMENU   
Gosub, NOTIFY_STARTUP


/*
todo:
=====
read toogle state persistent from ini
set utility path in ini
set shortcuts via ini
set shortcut executable path in ini
http://www.autohotkey.com/board/topic/25515-globalsfromini-creates-globals-from-an-ini-file/
http://www.autohotkey.com/board/topic/33506-read-ini-file-in-one-go/
http://www.autohotkey.com/board/topic/67411-iniread-read-someall-values-from-an-ini-file/


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
#e::RunOrActivate("c:\Programme\PSPad\PSPad.exe", "PSPad")
^#e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
#u::SafelyRemoveHardware()
#k::Run %dropboxDir%\Tools\KeePass\KeePass.exe
#g::Run c:\Programme\SmartGit 3\bin\smartgit.exe
#p::RunOrActivate(dropboxDir "\Tools\KiTTY\kitty_portable.exe", "KiTTY")
#s::RunOrActivate(dropboxDir "\Tools\WinSCP\WinSCP.exe", "WinSCP")
#a::Run %dropboxDir%\Tools\foobar2000\foobar2000.exe
#v::RunOrActivate("C:\Programme\VideoLAN\VLC\vlc.exe", "VLC")
#t::RunOrActivate(dropboxDir "\Tools\ConEmu\ConEMu.exe", "ahk_class VirtualConsoleClass", "newtab")
#n::RunOrActivate(dropboxDir "\Tools\NirLauncher\Nirlauncher.exe", "ahk_class NirLauncher")
#c::RunOrActivate("C:\Programme\Miranda IM\miranda32.exe", "ahk_class Miranda")
#i::RunOrActivate("C:\Programme\Mozilla Firefox\firefox.exe", "ahk_class MozillaWindowClass", "newtab")
#m::PostMessage, 0x112, 0xF020,,,A
#y::RunOrActivate("X:\Eigene Dateien\Dropbox\Tools\emacs\emacs.bat", "ahk_class Emacs")

#w::GoSub, GMINDER     
#q::GoSub, QMCALENDAR

; Process Hacker
^+esc::Run %dropboxDir%\Tools\processhacker\x86\ProcessHacker.exe
                               
;total commander
#SPACE::
  if not WinExist( "ahk_class TTOTAL_CMD" )
		Run %dropboxDir%\totalcmd.exe
	WinActivate
	Return
                                       
          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	Hotstrings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HOTSTRINGS:
::MfG::Mit freundlichen Grüßen  
::zB::z.B.
::zT::zum Teil
::jmd::jemand
::evtl::eventuell
::ijmd::irgendjemand
::iwas::irgendwas
::iwo::irgendwo
::iwie::irgendwie
::iwann::irgendwann
::bfeld::Birkenfeld
::abach::Arnbach
::nbg::Neuenbürg
::bg::bis gleich                
::aso::achso


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	Program Tweaks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TWEAKS:
; TOTAL COMMANDER: always COPY/MOVE in BACKGROUND
;#IfWinActive ahk_class TInpComboDlg
;	$Enter::SendInput, {F2}

; Turn off Caps Lock
CapsLock::AppsKey
 
; TOTALCMD: minimize on esc  
;#ifWinActive ahk_class TTOTAL_CMD
;  $Escape::WinMinimize A

; TOTALCMD: always unpack into seperate directory
~!F6:: 
~!F9:: 
If WinActive("ahk_class TTOTAL_CMD") or WinActive("ahk_class TDLGUNZIPALL")
{
  WinWaitActive, ahk_class TDLGUNZIPALL
  ControlSend, TCheckBox1, {SPACE}
  ControlFocus, TAltEdit1
  ; If you always want to extract to the active panel, uncomment:
  ;Send {DEL}
}
Return


 
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


; wait for icon-file to become available (dropbox startup-delay)
If FileExist( "X:\Eigene Dateien\Code\AHK\0x4a\key.ico" )
    Menu,Tray,Icon, %A_MyDocuments%\Code\AHK\0x4a\key.ico
else
{
    Sleep 15000
    If FileExist("X:\Eigene Dateien\Code\AHK\0x4a\key.ico")
        Menu,Tray,Icon, %A_MyDocuments%\Code\0x4a\AHK\key.ico          
}

Menu,ahkmenu,Standard   

Menu,googlemenu,Add, Mail, GMAIL
Menu,googlemenu,Add, Kalender, GCAL
Menu,googlemenu,Add, Dokumente, GDOCS
Menu,googlemenu,Add, Reader, GREADER

Menu,toolsmenu,Add,%str_StartClock%,STARTCLOCK
Menu,toolsmenu,Add,%str_WindowDrag%,WINDOWDRAG
Menu,toolsmenu,Add,%str_ImCaro%,IM_CARO
Menu,toolsmenu,Add,%str_RGB%,RGB_PICK
Menu,toolsmenu,Add,
Menu,toolsmenu,Add,Win-Kalender,SHOWCALENDAR
Menu,toolsmenu,Add,GMinder,GMINDER
Menu,toolsmenu,Add,Kalender,QMCALENDAR
Menu,toolsmenu,Add,WLAN,NET_WLAN
Menu,toolsmenu,Add,Bluetooth,NET_BT


Menu,Tray,Tip,%applicationname%                                            
Menu,Tray,NoStandard
Menu,Tray,DeleteAll

Menu,Tray,Add,Autohotkey, :ahkmenu
Menu,Tray,Add,Google `t..., :googlemenu
Menu,Tray,Add,Tools, :toolsmenu
Menu,Tray,Add,
Menu,Tray,Add,About..., ABOUT
Menu,Tray,Add,E&xit,EXIT
;Menu,Tray,Default,Google     

CheckTrayMenu("EasyWindowDrag.exe", str_WindowDrag)                         
return

NOTIFY_STARTUP:
  notify_options:="GC=D4D0C8 GR=0 BR=0 BW=2 TS=8 TF=segoe ui BK=005555 MC=000000 BC=000000"
  notify_text= %applicationname% started
  Notify(notify_text, "" ,5,notify_options) ;= pretty simple
return


GMAIL:
Run "C:\Dokumente und Einstellungen\Jekyll\Lokale Einstellungen\Anwendungsdaten\Google\Chrome\Application\chrome.exe" https://mail.google.com/mail
return

GCAL:
Run "C:\Dokumente und Einstellungen\Jekyll\Lokale Einstellungen\Anwendungsdaten\Google\Chrome\Application\chrome.exe" https://www.google.com/calendar
return

GDOCS:
Run "C:\Dokumente und Einstellungen\Jekyll\Lokale Einstellungen\Anwendungsdaten\Google\Chrome\Application\chrome.exe" https://docs.google.com
return

GREADER:
Run "C:\Dokumente und Einstellungen\Jekyll\Lokale Einstellungen\Anwendungsdaten\Google\Chrome\Application\chrome.exe" http://www.google.com/reader/view/
return



 

 
ABOUT:
#include d:\nc10\x\Eigene Dateien\Code\AHK\0x4a\aboutmenu.ahk
return



SHOWCALENDAR:
Run,RunDll32.exe shell32.dll`,Control_RunDLL timedate.cpl,,UseErrorLevel
return

QMCALENDAR:
Send, !+^{q}

While !keys:=(GetKeyState("LButton","P") . GetKeyState("Escape","P"))
   Sleep, 10
Sleep, 100
If keys=10
   Send, !+^{q}  ; LButton
Else
   Send, !+^{q}  ; ESC
   
/*
#IfWinActive, ahk_class SysMonthCal321
  LButton::Send !+^{q}  
return

#IfWinNotActive, ahk_class SysMonthCal321
  tooltip notactive
  ;LButton::
  
return

  */
return   

GMINDER:
BlockInput, on
CoordMode, Mouse, Screen
pos := Tray_Define("GMinder.exe", "i") 
MouseGetPos, mouseX, mouseY
Sleep 150
MouseMove,250,576,0   
Tray_Click(pos, "L")
Sleep 150
MouseMove,%mouseX%,%mouseY%,0
CoordMode, Mouse, Relative
BlockInput off
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




STARTCLOCK:
; Shows the time on the Start button and date and more in the tray.
; by Skrommel 2005
RunFromTrayMenu("X:\Eigene Dateien\Dropbox\Tools\AHK\scripts\StartClock.exe", str_StartClock)
return


WINDOWDRAG:
; Easy Window Dragging -- KDE style (requires XP/2k/NT) -- by Jonny
; http://www.autohotkey.com
RunFromTrayMenu("", str_WindowDrag)
return


IM_CARO:
if WinExist("Caro")
    WinActivate
else if WinExist( "ahk_class Miranda" )
{
;;move mouse to starting position
    BlockInput on
    WinActivate ahk_class Miranda
    Send {Click, 100, 100, right}
    Send {down}{down}{Enter}
    Send caro{enter}
    WinActivate ahk_class Miranda
    Send {Click, 100, 100, right}
    Send {down}{down}{Enter} 
    WinActivate "Caro"
    BlockInput off
}
else 
    MsgBox, 277, ahk, Miranda not running, 10
    IfMsgBox, Retry
        Run C:\Programme\Miranda IM\miranda32.exe
return

RGB_PICK:
return



EXIT:
ExitApp







