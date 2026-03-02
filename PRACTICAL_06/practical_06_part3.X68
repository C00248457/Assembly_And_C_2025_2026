*-----------------------------------------------------------
* Title      : Practical 6 Part 1
* Written by : Rachel O Shea
* Date       : 27/02/2026
* Description: Utilise conditional branches and control stuctures

; A7 is stack pointer - special purpose register that points to top of stack in memory

; NB: -(A7) means predecrement - A7 moves down by 1 byte first then
; stores the value there

; (A7)+ means postincrement - reads value first, then A7 moves up
; by one byte. Reads in reverse number

; Demonstrates LIFO! LAST IN FIRST OUT
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    LEA $4000, A7       ; sets stack pointer to memory address $4000
    
    MOVE.B  #1, -(A7)   ; pushing onto stack, stores 1 at $3FFF (underneath 4000) 
    MOVE.B  #2, -(A7)   ; ", stores 2 at $3FFE (again underneath $3FFF)
    MOVE.B  #3, -(A7)   ; ctd
    MOVE.B  #4, -(A7)   ; ctd
    
    MOVE.B  (A7)+, D1   ; pop - reads 4 from $3FFC, A7 increments to $3FFD
    MOVE.B  (A7)+, D1   ; ", reads 3 from $3FFD, A7 increments to $3FFE
    MOVE.B  (A7)+, D1   ; ctd
    MOVE.B  (A7)+, D1   ; ctd

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
