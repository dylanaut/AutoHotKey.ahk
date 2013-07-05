; http://paperlined.org/apps/autohotkey/small_bits/IndicateSynergyFocusedThisScreen.ahk
FlashScreen()
{
    ; create the window
    GUI, Destroy
    GUI, +AlwaysOnTop -SysMenu +ToolWindow -Caption     ; consumes entire screen
    ; flash the screen  
    GUI, Color, 696969  ; background color is red
    GUI, Show, X0 Y0 W%A_ScreenWidth% H%A_ScreenHeight% NA  ; maximize, but DO NOT take focus
    Sleep,50
    GUI, Color, 000000  ; black
    Sleep,50
    GUI, Color, 307F20  ; red
    Sleep,50
    GUI, Hide
}