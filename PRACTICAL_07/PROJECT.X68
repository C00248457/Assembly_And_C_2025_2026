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
    RTS                                 ; RETURN FROM GAME SUBROUTINE
    
*--------------------WELCOME SUBROUTINE---------------------- 
WELCOME:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     WELCOME_MSG, A1             ; ASSIGN WELCOME MESSAGE TO ADDRESS REGISTER 1
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0 
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE

*--------------------GAMELOOP (MAIN LOOP)--------------------   
GAMELOOP:
    BSR     LARDER                      ; BRANCH TO LARDER SUBROUTINE
    BSR     FRIDGE                      ; BRANCH TO FRIDGE SUBROUTINE
    BSR     ANOMALY                     ; BRANCH TO ANOMALY SUBROUTINE
    BSR     SPICERACK                   ; BRANCH TO SPICERACK SUBROUTINE
    BSR     END                         ; BRANCH TO END SUBROUTINE
    BSR     REPLAY                      ; BRANCH TO REPLAY SUBROUTINE
    BSR     CLEAR_SCREEN                ; CLEAR THE SCREEN
    RTS                                 ; RETURN FROM GAME SUBROUTINE

*---------------------LARDER SUBROUTINE----------------------   
LARDER:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     LARDER_MESSAGE, A1          ; ASSIGN LARDER MESSAGE TO ADDRESS REGISER 1
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    RTS                                 ; RETURN FROM LARDER SUBROUTINE
    

*---------------------FRIDGE SUBROUTINE---------------------- 
FRIDGE:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     FRIDGE_MESSAGE, A1          ; ASSIGN FRIDGE MESSAGE TO ADDRESS REGISTER 1    
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    RTS                                 ; RETURN FROM FRIDGE SUBROUTINE
    
*---------------------ANOMALY SUBROUTINE----------------------  
ANOMALY:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     ANOMALY_MESSAGE, A1         ; ASSIGN ANOMALY MESSAGE TO ADDRESS REGISTER 1
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    RTS                                 ; RETURN FROM ANOMALY SUBROUTINE

*---------------------SPICERACK SUBROUTINE---------------------
SPICERACK:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     SPICERACK_MESSAGE, A1       ; ASSIGN SPICERACK MESSAGE TO ADDRESS REGISTER 1  
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    RTS                                 ; RETURN FROM SPICERACK SUBROUTINE
    
*---------------------END SUBROUTINE---------------------------
END:
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    LEA     END_MESSAGE, A1             ; ASSIGN END MESSAGE TO ADDRESS REGISTER 1
    MOVE.B  #14, D0                     ; MOVE LITERAL 14 TO D0
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    BSR     ENDL                        ; BRANCH TO ENDL SUBROUTINE
    RTS                                 ; RETURN FROM END SUBROUTINE

*---------------------REPLAY SUBROUTINE-----------------------
REPLAY:
    BSR     GAMELOOP                    ; BRANCH TO GAME LOOP WHERE GAME STARTS ** REVIEW THIS**

*---------------------CLEAR SCREEN SUBROUTINE-----------------
CLEAR_SCREEN:

*---------------------ENDL SUBROUTINE-------------------------
ENDL:
    MOVEM.L D0/A1,-(A7)                 ; SAVE D0 AND A1
    MOVE    #14, D0                     ; MOVE LITERAL 14 TO D0
    LEA     CRLF, A1                    ; ASSIGN CRLF TO ADDRESS REGISTER A1
    TRAP    #15                         ; TRAP AND INTERPRET VALUE IN D0
    MOVEM.L (A7)+, D0/A1                ; RESTORE D0 AND A1
    RTS                                 ; RETURN FROM ENDL SUBROUTINE
         
*---------------------INPUT SUBROUTINE------------------------
INPUT:
    RTS                                 ; RETURN FROM ENDL SUBROUTINE  

    SIMHALT             ; halt simulator

WELCOME_MSG:        DC.B    '***********************************************'
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
                      
LARDER_MESSAGE:     DC.B    '***********************************************'
                    DC.B    $0D, $0A
                    DC.B    'RICE OR NOODLES?'
                    DC.B    $0D, $0A
                    DC.B    '***********************************************'
                    DC.B    $0D, $0A, 0
                    
FRIDGE_MESSAGE:     DC.B    '***********************************************'
                    DC.B    $0D, $0A
                    DC.B    'SALMON OR EGG?'
                    DC.B    $0D, $0A
                    DC.B    '***********************************************'
                    DC.B    $0D, $0A, 0
                    
ANOMALY_MESSAGE:    DC.B    '***********************************************'
                    DC.B    $0D, $0A
                    DC.B    'OH NO! THE CAT ATE SOME OF YOUR SALMON! YOU HAVE LOST FRESHNESS POINTS'
                    DC.B    $0D, $0A
                    DC.B    '***********************************************'
                    DC.B    $0D, $0A, 0
                    
SPICERACK_MESSAGE:  DC.B    '***********************************************'
                    DC.B    $0D, $0A
                    DC.B    'CHOOSE YOUR FLAVOUR ENHANCER'
                    DC.B    $0D, $0A
                    DC.B    'SOY SAUCE OR WASABI?'
                    DC.B    $0D, $0A
                    DC.B    '***********************************************'
                    DC.B    $0D, $0A, 0
                    
END_MESSAGE:        DC.B    '***********************************************'
                    DC.B    $0D, $0A 
                    DC.B    'THE ENTITY HAS RETURNED...'
                    DC.B    $0D, $0A
                    DC.B    'HE LOOK AT YOUR FOOD, DISCERNING'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY DEVOURS THE FOOD'
                    DC.B    $0D, $0A
                    DC.B    'YOUR FATE AWAITS...'
                    DC.B    $0D, $0A 
                    DC.B    '***********************************************'
                    DC.B    $0D, $0A, 0  
                    
REPLAY_MESSAGE:     DC.B    '***********************************************'
                    DC.B    $0D, $0A 
                    DC.B    'THE ENTITY IS HUNGRY AGAIN...'
                    DC.B    $0D, $0A                     
                    DC.B    '***********************************************'
                    DC.B    $0D, $0A, 0                   
                    
CRLF:               DC.B    $0D, $0A, 0  

PERFECT_BOWL:       DC.B    '***********************************************'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY SMILES, HE IS IMPRESSED' 
                    DC.B    $0D, $0A
                    DC.B    '"YOU HAVE SUCCEEDED WHERE OTHERS HAVE FAILED"'
                    DC.B    $0D, $0A
                    DC.B    'YOU LIVE TO SEE ANOTHER DAY, MORTAL'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY TURNS, FLOATING AWAY...'
                    DC.B    $0D, $0A
                    DC.B    'CURIOSITY SEIZES YOU, YOU CALL TO HIM'
                    DC.B    $0D, $0A
                    DC.B    '"WHAT DO I CALL YOU?"'
                    DC.B    $0D, $0A
                    DC.B    'YOU MAY CALL ME...'
                    DC.B    $0D, $0A
                    DC.B    'GERALD'
                    DC.B    $0D, $0A 
                    DC.B    '***********************************************'
                    DC.B    $0D, $0A, 0 
                    

DECENT_BOWL:        DC.B    '***********************************************'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY IS UNIMPRESSED'
                    DC.B    $0D, $0A 
                    DC.B    'HE POOFS AWAY, MEAL HALF-EATEN'
                    DC.B    $0D, $0A 
                    DCB.    'THE CAT MEOWS'
                    DC.B    $0D, $0A
                    DC.B    '***********************************************'   
                    DC.B    $0D, $0A, 0   

BAD_BOWL:           DC.B    '***********************************************'
                    DC.B    'THE ENTITY ROARS, THE EARTH BEGINS TO SHAKE'
                    DC.B    $0D, $0A
                    DC.B    'THE CAT SNARLS AT YOU'
                    DC.B    $0D, $0A 
                    DC.B    'WITH A SUPERSONIC BOOM, YOUR DIMENSION COLLAPSES IN ON ITSELF'
                    DC.B    $0D, $0A
                    DC.B    'YOU HAVE DIED, AND YOUR UNIVERSE ALONG WITH YOU'
                    DC.B    $0D, $0A
                    DC.B    '***********************************************'                

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
