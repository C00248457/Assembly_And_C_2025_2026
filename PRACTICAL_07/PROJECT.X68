*-----------------------------------------------------------
* Title      : The Grains of Fate
* Written by : Rachel O Shea - C00248457
* Date       : 17/02/2026
* Description: 'Rice' to the occasion as a tiny chef in control of curbing his hunger
*-----------------------------------------------------------
* STARTING MEMORY ADDRESS FOR THE PROGRAMME $1000  
*-----------------------------------------------------------
    ORG    $1000
    
EXIT            EQU 0   ; USED TO EXIT THE PROGRAM
START_FLAVOUR   EQU 100 ; STARTING FLAVOUR POINTS
START_FRESHNESS EQU 100 ; STARTING FRESHNESS POINTS
PERFECT_BOWL    EQU 150 ; MINIMUM SCORE NEEDED FOR PERFECT BOWL
BAD_BOWL        EQU 90  ; MAXMIMUM SCORE POSSIBLE FOR BAD BOWL
WASABI_HIGH     EQU 65  ; FULL BONUS FLAVOUR
WASABI_LOW      EQU 40  ; PENALTY FLAVOUR

START:                  ; first instruction of program



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
