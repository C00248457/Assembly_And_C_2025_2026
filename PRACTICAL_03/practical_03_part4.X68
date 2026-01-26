*-----------------------------------------------------------
* Title      : Practical 3 Task 4
* Written by : Rachel O Shea
* Date       : 26/01/26
* Description: Understanding and utilising address registers
*-----------------------------------------------------------
    ORG    $1000
    START:                      ; first instruction of program

    LEA DATA, A1                ; create label and point to address register 0
    LEA PLAYER_HEALTH, A2       ; create label and point to address register 1
    LEA POINTS, A3              ; create label and point to address register 3
    LEA BOSS_HEALTH, A4         ; create label and point to address register 4
    LEA PLAYER_LIVES, A5        ; create label and point to address register 5
    LEA POSITION, A6            ; create label and point to address register 6

    
    MOVE.B #100, (A1)           ; change value in A1

    SIMHALT                     ; halt simulator


DATA dc.b $64                   ; reserve a byte of memory, sets value to 100
HEALTH dc.b $64                 ; reserve a byte of memory, sets value to 100

    END    START                ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
