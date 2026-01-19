*-----------------------------------------------------------
* Title      : Practical 02
* Written by : Rachel O Shea
* Date       : 19/01/2026
* Description: Practical 2 Part 3
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program

    MOVE.L  #%100,  D0      ; takes literal value of binary number
    MOVE.L  #$100,  D1      ; takes literal value of hex number
    MOVE.L  #100,   D2      ; takes literal value of decimal number
    
    MOVE.L  D0,     $3000
    MOVE.L  D1,     $3010
    MOVE.L  D2,     $3020
    
    MOVE.W  #100,   $3020
    MOVE.W  #$100,  $3010
    MOVE.W  #%100,  $3000
    
    MOVE.B  #100,   $3020
    MOVE.B  #$64,   $3010
    MOVE.B  #%10001111,     $3000       ; move binary value to specified $3000 memory location

    SIMHALT             ; halt simulator

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
