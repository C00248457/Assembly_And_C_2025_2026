*-----------------------------------------------------------
* Title      : Practical 6 Part 1
* Written by : Rachel O Shea
* Date       : 01/03/2026
* Description: Utilise conditional branches and control stuctures
*-----------------------------------------------------------
    ORG    $1000
START:                  
    MOVE.L  #HEALTHM -(SP)  ; Note position in stack
    
    MOVE.B  #14, D0
    MOVE.B  #14, D1
    
    MOVE.L D0, -(SP) ;  Player X
    MOVE.L D1, -(SP) ;  Enemy X
    
    JSR GAME_LOOP
    BSR HEADS_UP_DISPLAY
    BRA END_GAME
    
GAME_LOOP:
    
    MOVE.L  4(SP), D1   ; Note depth in stack
    MOVE.L  8(SP), D0   ; Note depth in stack
    
    CMP DO, D1
    BEQ DAMAGE
    BRA NO_DAMAGE
    
DAMAGE:

    MOVEA.L 12(SP), A1  ; Note depth in stack
    SUB.B   #10, (A1)
    
NO_DAMAGE:

    RTS
    
HEADS_UP_DISPLAY:

    MOVE.B  HEALTH, D1
    MOVE.B  #3, D0
    TRAP    15
    RTS
  
END_GAME

    SIMHALT             ; halt simulator

HEALTH: DC.B 100

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
