*-----------------------------------------------------------
* Title      :  Pratical 4
* Written by :  Rachel O Shea
* Date       :  04/02/2026
* Description:  Practical 4 Task 3
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    ; Move Health to Memory Location $3000
    MOVE.B  #100, $3000
    
    ; Load Memory Address $3000 into
    ; Address Register A1
    LEA     $3000, A1
    
    ; Branch to TAKING_DAMAGE
    BSR     TAKING_DAMAGE
    
BACK_IN_THE_GAME:
    ; Lets Help this player out
    BSR     HEALTH_PICKUP   ; Branch to subroutine
    BRA     GAME_END
    
TAKING_DAMAGE:
    ; Hit by NPC
    ; Non Player Character
    SUB.B   #20, (A1)
    BRA     BACK_IN_THE_GAME
    
HEALTH_PICKUP:
    ; Pickup Health Found
    ADD.B   #10, (A1)
    RTS     ; Return from Subroutine
    
GAME_END:
    ; Game Over
    MOVE.B  #$00, (A1)

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
