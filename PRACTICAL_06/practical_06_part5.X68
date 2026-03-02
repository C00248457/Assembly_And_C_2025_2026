*-----------------------------------------------------------
* Title      : Practical 6 Part 1
* Written by : Rachel O Shea
* Date       : 28/02/2026
* Description: Utilise conditional branches and control stuctures
*-----------------------------------------------------------
    ORG    $1000
START:                  
    MOVE.L  #HEALTH, -(SP)
    JSR     GAME_LOOP
    BSR     HEADS_UP_DISPLAY
    BRA     END
    
GAME_LOOP:
    MOVEA.L 4(SP),A1
    SUB.B   #10, (A1)
    RTS

HEADS_UP_DISPLAY:
    LEA MESSAGE, A1
    MOVE.B  #14, D0
    TRAP    #15
    MOVE.B  HEALTH, D1
    MOVE.B  #3, D0
    TRAP    #15
    RTS
    
END: 

    SIMHALT             ; halt simulator

HEALTH:     DC.B 100
MESSAGE:    DC.B 'Health:', 0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
