;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	Funktionen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CheckTrayMenu(TargetExe, TrayMenuEntry)
{
  Process, Exist, %TargetExe%
  If (ErrorLevel > 0) 
  {  
    ;tooltip running
    menu, toolsmenu, Check, %TrayMenuEntry%
  }
  Else 
  {   
    ;tooltip not running
    menu, toolsmenu, UnCheck, %TrayMenuEntry%
  }
}

RunFromTrayMenu(Target, TrayMenuEntry)
{
  SplitPath, Target, TargetExe
  Process, Exist, %TargetExe%
  
  If (ErrorLevel = 0) 
  {  
    Run %Target%
    menu, toolsmenu, Check, %TrayMenuEntry%
  }
  Else 
  {
    Process, Close, %ErrorLevel%  
    RefreshTray()    
    menu, toolsmenu, UnCheck, %TrayMenuEntry%
  }       
}


RunOrActivateKeynote(Target)  {
  SplitPath, Target, TargetNameOnly
  Process, Exist, %TargetNameOnly%
  If ErrorLevel > 0
  {
    ;running
    SendInput +^{y}
    ;PID = %ErrorLevel%
  }
  Else
  { 
    ;not running
    FlashScreen()
    Run, %Target%, , , ;PID  
  }
}

RunOrActivate(Target, WinTitle = "", Option = "") {
SplitPath, Target, TargetNameOnly
Process, Exist, %TargetNameOnly%
    If ErrorLevel > 0
        PID = %ErrorLevel%
    Else
    {
      FlashScreen()
      Run, %Target%, , , PID  
    } 
    If WinTitle <>
    {
      SetTitleMatchMode, 2
      WinWait, %WinTitle%, , 3
      WinActivate, %WinTitle%
    }
    Else
    {
      WinWait, ahk_pid %PID%, , 3
      WinActivate, ahk_pid %PID%
    }
        
    If Option = newtab
    {
      WinWait, %WinTitle%,,30
      Send ^t
    }         
}

