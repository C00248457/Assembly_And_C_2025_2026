*-----------------------------------------------------------
* Title      : Part 3
* Written by : Rachel O Shea
* Date       : 14/01/2026
* Description: Part 3
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program
    MOVE.B #$64, D1         ; Load immediate value (100 in decimal) into D1
    LEA text, A1            ; Load address of text into A1
    MOVE #14, D0            ; Execute TRAP (Output D0 to console)
    TRAP #15                ; Execute TRAP (Output D0 to console)
    
    MOVE #3, D0             ; Load immediate value (3) into D0
    TRAP #15                ; Execute TRAP (Output D0 to console)
    

    SIMHALT             ; halt simulator

    text:   dc.b 'Data Register: ', 0   ; Define the string 'Data Register:'

    END    START        ; last line of source
    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
