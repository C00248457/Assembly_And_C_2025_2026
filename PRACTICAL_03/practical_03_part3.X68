*-----------------------------------------------------------
* Title      : Practical 3 Task 3
* Written by : Rachel O Shea
* Date       : 26/01/26
* Description: Understanding and utilising address registers
*-----------------------------------------------------------
    ORG    $1000
    START:              ; first instruction of program
    
    LEA HEALTH, A3      ; move into address register 3
    SUB.B   #10, (A3)   ; subtract from value in address register 3


    SIMHALT             ; halt simulator

HEALTH dc.b $64         ; reserve a byte of memory at this location, initialise with value $64

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
