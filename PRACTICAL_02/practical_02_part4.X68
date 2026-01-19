*-----------------------------------------------------------
* Title      : Practical 02
* Written by : Rachel O Shea
* Date       : 19/01/2026
* Description: Practical 2 Part 4
*-----------------------------------------------------------
    ORG    $1000
    START:                  ; first instruction of program

    MOVE.L  #$101,  $2000   ; move hex value into memory location $2000
    MOVE.B  #%100,  $2010   ; move binary value into memory location $2010
    MOVE.W  #100,   $2020   ; move decimal value into memory location $2020
    
    MOVE.L  #%1010, $2030   ; move binary value into memory location $2030
    MOVE.B  #$10,   $2040   ; move hex value into memory location $2040
    MOVE.W  #1,     $2050   ; move decimal value into memory location $2050
    
    MOVE.L  #1001,  $2070   ; move decimal value into memory location $2070
    MOVE.B  #$10,   $2080   ; move hex value into memory location $2080
    MOVE.W  #%1011, $2090   ; move binary value into memory location $2090
    
    MOVE.L  #1110,  $3020   ; move decimal value into memory location $3020
    MOVE.B  #$11,   $3030   ; move hex value into memory location $3030
    MOVE.W  #%1111, $3040   ; move binary value into memory location $3040

    MOVE.L  $2030,  $2060   ; overwrite (currently empty) $2060 with value in $2030
    MOVE.B  $2070,  $3000   ; overwrite (currently empty) $3000 with value in $2070
    MOVE.W  $2090,  $3010   ; overwrite (currently empty) $3010 with value in $2090
    
    MOVE.L  $2000,  D0      ; moves hex value in memory location $2000 to data register D0
    MOVE.B  $2010,  D1      ; moves binary value in memory location $2010 to data register D1
    MOVE.W  $2020,  D2      ; moves decimal value in memory location $2020 to data register D2
    
    MOVE.L  D2,     D3      ; D2 data to D3
    MOVE.B  $2040,  D4      ; moves $2040 into D4
    MOVE.W  $2050,  D5      ; moves $2050 into D5
    
    MOVE.L  D5,     D6      ; D5 data to D6
    MOVE.B  D4,     D7      ; D4 to D7
    MOVE.W  D5,     D0      ; overwrite data in D0 with data in data register 5
    
    
                            ; originally used memory locations $1000, $1010, $1020
                            ; didn't work, got error
                            ; possibly reserved memory locations?

    SIMHALT                 ; halt simulator

    END    START            ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

