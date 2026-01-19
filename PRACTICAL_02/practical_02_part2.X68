*-----------------------------------------------------------
* Title      : Practical 02
* Written by : Rachel O Shea
* Date       : 19/01/2026
* Description: Practical 2 Part 2
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program

    MOVE.L  #%100,  D0      ; binary value
    MOVE.L  #$100,  D1      ; hex value
    MOVE.L  #100,   D2      ; decimal value
    
    MOVE.L  D0,     $3000   ; move data register D0 to memory location $3000
    MOVE.L  D1,     $3010
    MOVE.L  D2,     $3020
    
    MOVE.W  #100,   $3020   ; move decimal value 100 to memory location $3020
    MOVE.W  #$100,  $3010
    MOVE.W  #$100,  $3000

    SIMHALT             ; halt simulator

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
