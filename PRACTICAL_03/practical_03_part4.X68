*-----------------------------------------------------------
* Title      : Practical 3 Task 4
* Written by : Rachel O Shea
* Date       : 26/01/26
* Description: Understanding and utilising address registers
*-----------------------------------------------------------
    ORG    $1000
    START:                      ; first instruction of program

    LEA PLAYER_HEALTH, A1       ; create label and point to address register 1
    MOVE.B  #$64, (A1)          ; set initial player health to 100    
    SUB.B #10, (A1)             ; player takes 10 damage
    
    LEA PLAYER_LIVES, A2        ; create label and point to address register 2
    MOVE.B #3, (A2)             ; store number of lives
    ADD.B #2, (A2)              ; adds lives
    
    LEA PLAYER_X, A3            ; create label and point to address register 3
    MOVE.W #100, (A3)           ; store x coordinate
    
    LEA PLAYER_Y, A4            ; create label and point to address register 4
    MOVE.W #100, (A4)           ; store y coordinate
    
    LEA BOSS_HEALTH, A5         ; create label and point to address register 5
    MOVE.B #100, (A5)           ; set initial boss health to 100
    
    LEA PLAYER_POINTS, A6       ; create label and point to address register 6
    MOVE.L #5000, (A6)          ; set points to 5000

    SIMHALT                     ; halt simulator


PLAYER_HEALTH dc.b $64          ; reserve a byte of memory, sets value to 100
PLAYER_LIVES dc.b 5             ; reserve byte for player lives
BOSS_HEALTH dc.b $64            ; reserve a byte of memory, sets value to 100
PLAYER_X dc.w 100               ; reserve 2 bytes
PLAYER_Y dc.w 100               ; reserve 2 bytes
PLAYER_POINTS dc.l 5000         ; reserve 4 bytes

 

    END    START                ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
