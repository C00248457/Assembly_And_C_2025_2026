*-----------------------------------------------------------
* Title      :  Practical 05 Task 1
* Written by :  Rachel O Shea
* Date       :  09/02/2026
* Description:  Utilise conditional branches and control structures
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    INITIALISE:
        MOVE.B #3, D0
        MOVE.B #0, D1
        
    GAME_LOOP:
        CMP.B #1, D0    ; compares (but doesn't edit the value in register)
        BNE GAME_POINTS ; branch if not equal
        BEQ GAME_OVER   ; branch if equal
        
    GAME_POINTS:
        ADD.B   #10, D1
        SUB.B   #1, D0
        BRA     GAME_LOOP
        
    GAME_OVER:          ; game loops 3 times until BEQ is true

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
