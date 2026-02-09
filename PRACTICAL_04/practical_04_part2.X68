*-----------------------------------------------------------
* Title      :  Pratical 4
* Written by :  Rachel O Shea
* Date       :  04/02/2026
* Description:  Practical 4 Part 2
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    ; Move Health to Memory Location $3000
    MOVE.B  #100, $3000
    
    ; Move Location of Player into Data Register
    ; X first Byte 1 to 15
    ; Y second byte 0 to 15
    MOVE.B  #$12, D2
    
    ; Move Location of NPC into Data Register
    ; X first Byte 0 to 15
    ; Y second Byte 0 to 15
    MOVE.B  #$22, D3
    
    ; Bitwise and D2 and D3
    ; What's new location of Player
    AND.B D2, D3
    
    ; Load Memory Address $3000 into
    ; Address Rehister A1
    LEA     $3000, A1
    
    ; Hit by NPS
    ; Non Player Character
    SUB.B   #20, (A1)
    
    ; Pickup Health Found
    ADD.B   #10, (A1)

    ; Use logical or to perform OR logical between source and destination operand
    OR.B    #$100, (A1) 

    ; Invert bits in the location
    NOT.B   D2,     D3
    
    ; Compares the bits
    EOR.B   D2,     D3
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
