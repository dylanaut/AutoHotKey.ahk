Gui, Destroy
Gui, Margin,6,2
Gui, Add,Picture,xm Icon1,%applicationname%.exe

;Gui, Add, Button, x126 y297 w130 h30 , OK
Gui, Add, Button, x126 y297 w100 h30 CloseAbout, Close

Gui, Add, Tab, x0 y0 w380 h290 , About|Hotkeys|Tweaks|Utilities|Text Replacement
Gui, Tab, About
Gui, Font,Bold
Gui, Add, Text, x16 y37 w340 h20, 
(
%applicationname% v0.1
)
Gui, Font
Gui, Add, Text, x16 y60 w340 h60,
(
%A_Space%%A_Space%%A_Space% 2011 Daniel Jackel
eMail: jekyll@0x4a.net
)


Gui, Font, s10
Gui, Add, Text, x16 y60 w12 h12, ©
Gui, Font, s8
Gui, Add, Text, x16 y107 w340 h100, 
(
keyboard shortcuts for essential programs 
various tweaks (e.g. Total Commander , Mozilla Firefox, Miranda IM)
automatic text replacement (german only)
(auto)start utilities
)
Gui, Tab, Hotkeys

Gui, Add, Text, x16 y87 w175 h150,
(
Mozilla Firefox `t Win + I 
Miranda IM `t Win + C
PSPad Editor `t Win + E
KeePass `t Win + K
PuTTY `t`t Win + P
WinSCP `t Win + S
Console `t Win + C
)

Gui, Add, Text, x166 y87 w185 h150,
(
Foobar2000 `t`t Win + A
VLC `t`t`t Win + V
NirLauncher `t`t Win + N
Total Commander `t Win + Space
gMinder `t`t Win + W
QM Calendar `t`t Win + Q
KeyNote NF `t`t Win + Y
Minimize Window `t Win + M
)




; Generated using SmartGUI Creator 4.0
Gui, Show, x258 y101 h330 w380, About %applicationname%
Return

CloseAbout:
Tooltip close
Gui Destroy
return 

GuiClose:
Gui Destroy
;ExitApp