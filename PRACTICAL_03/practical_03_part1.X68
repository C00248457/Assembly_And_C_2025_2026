*-----------------------------------------------------------
* Title      : Practical 3 Task 1
* Written by : Rachel O Shea
* Date       : 26/01/26
* Description: Understanding and utilising address registers
*-----------------------------------------------------------
    ORG    $1000
    START:              ; first instruction of program
    
    LEA $4000, A1       ; load effective address
    MOVE.B #100, (A1)   ; move value into memory location pointed to by address register A1

    SIMHALT             ; halt simulator



    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
