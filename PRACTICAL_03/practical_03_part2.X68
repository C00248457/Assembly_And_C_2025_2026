*-----------------------------------------------------------
* Title      : Practical 3 Task 2
* Written by : Rachel O Shea
* Date       : 26/01/26
* Description: Understanding and utilising address registers
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program
    LEA $4000, A2           ; load effective address
    MOVE.B #100, (A2)       ; move value into memory location pointed to by A2 (i.e. $4000)
    SUB.B #10, (A2)         ; subtract from value loaded into address register


    SIMHALT                 ; halt simulator



    END    START            ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
