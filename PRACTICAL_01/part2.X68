*-----------------------------------------------------------
* Title      : Part2
* Written by : Rachel O Shea
* Date       : 14/01/2025
* Description: Part 2 
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program

    MOVE.L #%00001111, D1   ; Load immediate value into D1

    MOVE.B D1, D2           ; Copy byte from D1 to D2

    MOVE.B D1, $2000        ; Store byte from D1 to memory location $2000

    MOVE.B $2000, D2        ; Load byte from memory location $2000 into D2

    MOVE.B $2000, $3000     ; Copy byte from $2000 to memory location $3000

    SIMHALT             ; halt simulator

    * Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
