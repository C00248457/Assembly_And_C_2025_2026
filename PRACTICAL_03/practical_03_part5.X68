*-----------------------------------------------------------
* Title      : Practical 3 Task 5
* Written by : Rachel O Shea
* Date       : 26/01/26
* Description: Understanding and utilising address registers
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program

    *START:
    MOVEA.L #ACHIEVEMENT_POINTS, A1
    MOVE.L  #0, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
ACHIEVEMENT_POINTS: DC.L    5, 10, 15, 20, 30

END:

    SIMHALT             ; halt simulator



    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
