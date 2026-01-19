*-----------------------------------------------------------
* Title      : Practical 02
* Written by : Rachel O Shea
* Date       : 19/01/2026
* Description: Practical 2 Part 1
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program

    MOVE.L  #%100,  D0      ; binary value to data register 0
    MOVE.L  #$100,  D1      ; hex value to data register 1
    MOVE.L  #100,   D2      ; literal decimal value to data register 2
    
    MOVE.L  D0, $3000       ; data in data register to moved to memory location $3000
    MOVE.L  D1, $3010
    MOVE.L  D2, $3020
    

    SIMHALT             ; halt simulator

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
