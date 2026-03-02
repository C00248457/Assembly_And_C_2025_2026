*-----------------------------------------------------------
* Title      : Practical 6 Part 1
* Written by : Rachel O Shea
* Date       : 27/02/2026
* Description: Utilise conditional branches and control stuctures

; SP is another name for A7 - same register
; Stands for stack pointer
; Makes clearer that you're working with stack rather than generic register

; LEA $4000, SP exactly same as LEA $4000, A7
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA $4000, SP       ; sets stack pointer to memory address $4000
    
    MOVE.B  #1, -(SP)   ; pushing onto stack, stores 1 at $3FFF (underneath 4000) 
    MOVE.B  #2, -(SP)   ; ", stores 2 at $3FFE (again underneath $3FFF)
    MOVE.B  #3, -(SP)   ; ctd
    MOVE.B  #4, -(SP)   ; ctd
    
    MOVE.B  (SP)+, D1   ; pop - reads 4 from $3FFC, A7 increments to $3FFD
    MOVE.B  (SP)+, D1   ; ", reads 3 from $3FFD, A7 increments to $3FFE
    MOVE.B  (SP)+, D1   ; ctd
    MOVE.B  (SP)+, D1   ; ctd

    SIMHALT             ; halt simulator

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
