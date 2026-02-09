*-----------------------------------------------------------
* Title      :  Pratical 4
* Written by :  Rachel O Shea
* Date       :  04/02/2026
* Description:  Practical 4 Part 1
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    ; Move Health to Memory Location $3000
    MOVE.B #100, $3000
    
    ; Load Memory Address $3000 into
    ; Address Register A1  
    LEA     $3000, A1
    
    ; Hit by NPC
    ; Non Player Character
    SUB.B   #20, (A1)
    
    ; Pickup Health Found
    ADD.B   #10, (A1)

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
