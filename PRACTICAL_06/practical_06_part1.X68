*-----------------------------------------------------------
* Title      : Practical 6 Part 1
* Written by : Rachel O Shea
* Date       : 25/02/2026
* Description: Utilise conditional branches and control stuctures
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    ; Move trap task to D0
    MOVE.B  #2, D0
    ; Interrupt and trap task
    TRAP    #15
    
    LEA     MESSAGE, A1
    MOVE.B  #13, D0
    TRAP    #15


    MESSAGE: DC.B 'Trap Task Test',0
    
    END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
