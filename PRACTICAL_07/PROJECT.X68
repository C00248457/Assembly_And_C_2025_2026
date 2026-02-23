*-----------------------------------------------------------
* Title      : The Grains of Fate
* Written by : Rachel O Shea - C00248457
* Date       : 21/02/2026
* Description: 'Rice' to the occasion as a tiny chef responsible for feeding the ancient cosmic entity that inhabits the pocket dimension you live in
*-----------------------------------------------------------
* STARTING MEMORY ADDRESS FOR THE PROGRAMME $1000  
*-----------------------------------------------------------
    ORG    $1000
    
EXIT            EQU 0                   ; USED TO EXIT THE PROGRAM
START_FLAVOUR   EQU 100                 ; STARTING FLAVOUR POINTS
START_FRESHNESS EQU 100                 ; STARTING FRESHNESS POINTS
PERFECT_BOWL    EQU 150                 ; MINIMUM SCORE NEEDED FOR PERFECT BOWL
BAD_BOWL        EQU 90                  ; MAXMIMUM SCORE POSSIBLE FOR BAD BOWL
WASABI_HIGH     EQU 65                  ; FULL BONUS FLAVOUR
WASABI_LOW      EQU 40                  ; PENALTY FLAVOUR

START:                  
    MOVE.B  START_FLAVOUR, $4000        ; PUT FLAVOUR POINTS IN MEMORY LOCATION $4000
    LEA     $4000, A2                   ; ASSIGN ADDRESS A2 TO THAT MEMORY LOCATION
    MOVE.B  START_FRESHNESS, $4001      ; PUT FRESHNESS POINTS IN MEMORY LOCATION $4001
    LEA     $4001, A3                   ; ASSIGN ADDRESS A3 TO THAT MEMORY LOCATION
    
    BSR     WELCOME                     ; BRANCH TO WELCOME SUBROUTINE
    BSR     INPUT                       ; BRANCH TO THE INPUT SUBROUTINE
    BSR     GAME                        ; BRANCH TO GAME SUBROUTINE  

*GAME LOOP
    ORG     $3000                       ; REST OF PROGRAM LOCATED FROM 3000 ONWARDS

*--------------------GAME SUBROUTINE-------------------------    
GAME:
    BSR     GAMELOOP                    ; BRANCH TO GAMELOOP SUBROUTINE
    RTS                                 ; RETURN FROM GAME: SUBROUTINE
    
*--------------------WELCOME SUBROUTINE---------------------- 
WELCOME:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     WELCOME_MSG, A1             ; ASSIGN WELCOME MESSAGE TO ADDRESS REGISTER 1
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0 
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    BSR     RESUME                      ; BRANCH TO RESUME SUBROUTINE

*--------------------GAMELOOP (MAIN LOOP)--------------------   
GAMELOOP:
    BSR     LARDER                      ; BRANCH TO LARDER SUBROUTINE
    BSR     FRIDGE                      ; BRANCH TO FRIDGE SUBROUTINE
    BSR     ANOMALY                     ; BRANCH TO ANOMALY SUBROUTINE
    BSR     SPICERACK                   ; BRANCH TO SPICERACK SUBROUTINE
    BSR     END                         ; BRANCH TO END SUBROUTINE
    BSR     REPLAY                      ; BRANCH TO REPLAY SUBROUTINE
    BSR     CLEAR_SCREEN                ; CLEAR THE SCREEN
    RTS                                 ; RETURN FROM GAME: SUBROUTINE

*---------------------LARDER SUBROUTINE----------------------   
LARDER:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     LARDER_MESSAGE              ; ASSIGN LARDER MESSAGE TO ADDRESS REGISER 1
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    
    
    SIMHALT             ; halt simulator

WELCOME_MSG:    DC.B    '***********************************************'
                DC.B    $0D, $0A
                DC.B    'WELCOME TO THE KITCHEN'
                DC.B    $0D, $0A
                DC.B    'CHOOSE BETWEEN THE INGREDIENTS AVAILABLE TO YOU'
                DC.B    $0D, $0A
                DC.B    'BUT BE WARNED'
                DC.B    $0D, $0A
                DC.B    'YOUR ACTIONS MAY HAVE CONSEQUENCES...'
                DC.B    $0D, $0A
                DC.B    '***********************************************'
                DC.B    $0D, $0A, 0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
