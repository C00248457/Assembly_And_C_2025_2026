*-----------------------------------------------------------
* Title      : The Grains of Fate
* Written by : Rachel O Shea - C00248457
* Date       : 21/02/2026 - 05/03/2026
* Description: 'Rice' to the occasion as a tiny chef 
; responsible for feeding the ancient cosmic entity
; that has kidnapped you
*-----------------------------------------------------------
    ORG    $1000

BAD_BOWL        EQU 30              ; BAD SCORE
DECENT_BOWL     EQU 50              ; DECENT BOWL
PERFECT_BOWL    EQU 70              ; PERFECT BOWL

START:  

    CLR         D3                  ; CLEAR REGISTER D3 SO NO LEFTOVER VALUES
    CLR         D4                  ; CLEAR REGISTER D4 SO NO LEFTOVER VALUES
    
    MOVE.B      #13, D0             ; MOVE TRAP TASK TO D0
    LEA         ASK_NAME, A1        ; ASK USER FOR THEIR NAME
    TRAP        #15                 ; INTERRUPT AND TRAP TASK
                        
    MOVE.B      #2, D0              ; MOVE TRAP TASK TO D0
    LEA         NAME, A1            ; LOAD NAME TO A1
    TRAP        #15                 ; INTERRUPT AND TRAP TASK
    
    MOVE.B      #23, D0
    TRAP        #15
    MOVE.B      D1, COUNTER
    
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN
    BSR         WELCOME             ; BRANCH TO WELCCOME SUBROUTINE 
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN
    BRA         LARDER              ; BRANCH TO LARDER SUBROUTINE

GAME_LOOP:
    CLR         D3
    CLR         D4
    
    BSR         CLEAR_SCREEN
    
    MOVE.B      #13, D0
    LEA         NEW_GAME_MSG, A1
    TRAP        #15
    BRA         LARDER
    
*--------------------WELCOME SUBROUTINE---------------------- 
WELCOME:
    MOVE.B      #11, D0
    MOVE.W      #$2001, D1          ; COLUMN 37 ($25) ROW 0 ($0)
    TRAP        #15
    
    LEA         WELCOME_MSG, A1     ; LOAD WELCOME MESSAGE TO A1
    MOVE.B      #14, D0
    TRAP        #15
                                           
    LEA         NAME, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    LEA         INTRODUCTION, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY 
    BSR         CLEAR_SCREEN 
  
    RTS
    
*--------------------LARDER SUBROUTINE----------------------
LARDER:
    
    LEA         LARDER_MSG, A1      ; LOAD LARDER MESSAGE TO A1
    MOVE.B      #13, D0             
    TRAP        #15
    
    MOVE.B      #4, D0
    TRAP        #15
    
    CMP         #1, D1              ; COMPARE CHOICE TO 1
    BEQ         RICE                ; BRANCH TO RICE IF 1
    
    CMP         #2, D1              ; COMPARE CHOICE TO 2
    BEQ         NOODLES             ; BRANCH TO NOODLES IF 2
  
    BRA         LARDER_FAIL_PATH           ; VALIDATION CHECK
    
    
    
*--------------------RICE SUBROUTINE------------------------
RICE:  
    
    ADD.B       #10, D3         ; ADD RICE FLAVOUR POINTS
    ADD.B       #10, D4         ; ADD RICE FRESHNESS POINTS
    
    LEA         RICE_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY
    BSR         CLEAR_SCREEN
    
    LEA         FRIDGE_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
RICE_INPUT:

    
    MOVE.B      #4, D0
    TRAP        #15
    
    CMP         #1, D1              ; COMPARE CHOICE TO 1
    BEQ         RICE_SALMON
    
    CMP         #2, D1
    BEQ         RICE_EGG
    
    BRA         RICE_FRIDGE_FAIL

*--------------------NOODLES SUBROUTINE----------------------
NOODLES:
    
    ADD.B       #15, D3             ; ADD NOODLE FLAVOUR POINTS
    ADD.B       #15, D4             ; ADD NOODLE FRESHNESS POINTS
    
    LEA         NOODLES_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    LEA         FRIDGE_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
NOODLES_INPUT:
    
    MOVE.B      #4, D0
    TRAP        #15
    
    CMP         #1, D1              ; COMPARE CHOICE TO 1
    BEQ         NOODLES_SALMON
    
    CMP         #2, D1
    BEQ         NOODLES_EGG
    
    BRA         NOODLES_FRIDGE_FAIL
    

*--------------------RICE SALMON SUBROUTINE--------------------- 
RICE_SALMON:
    
    ADD.B       #15, D3                 ; ADD SALMON FLAVOUR POINTS
    ADD.B       #10, D4                  ; ADD SALMON FRESHNESS POINTS
    
    LEA         RICE_SALMON_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    MOVE.B      #1, D5                  ; STORE VALUE FOR RICE/SALMON IN D5

    BRA         SPICE

*--------------------RICE EGG SUBROUTINE---------------------------
RICE_EGG:
    ADD.B       #5, D3              ; ADD EGG FLAVOUR POINTS
    ADD.B       #10, D4             ; ADD EGG FRESHNESS POINTS
    
    LEA         RICE_EGG_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    MOVE.B      #2, D5                  ; STORE VALUE FOR RICE/EGG IN D5
    
    BRA         SPICE
    
*--------------------NOODLES SALMON SUBROUTINE--------------------- 
NOODLES_SALMON:   
    SUB.B       #5, D3                  ; DEDUCT SALMON FLAVOUR POINTS
    ADD.B       #5, D4                  ; ADD SALMON FRESHNESS POINTS
    
    LEA         NOODLES_SALMON_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    MOVE.B      #3, D5                  ; STORE VALUE FOR NOODLES/SALMON IN D5
    
    BRA         SPICE
    
*--------------------NOODLES EGG SUBROUTINE--------------------------
NOODLES_EGG:
    ADD.B       #5, D3              ; ADD EGG FLAVOUR POINTS
    ADD.B       #10, D4             ; ADD EGG FRESHNESS POINTS
    
    LEA         NOODLES_EGG_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    MOVE.B      #4, D5                  ; STORE VALUE FOR NOODLES/EGG IN D5
    
    BRA         SPICE
    
*--------------------SPICE SUBROUTINE--------------------------------
SPICE:
    LEA         SPICE_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15  
    
SPICE_INPUT:   
    MOVE.B      #4, D0
    TRAP        #15
    
    CMP.B       #1, D1
    BEQ         SOY_SAUCE
    
    CMP.B       #2, D1
    BEQ         WASABI

    BRA         SPICE_FAIL_PATH
    
*--------------------SOY SAUCE SUBROUTINE------------------------------
SOY_SAUCE:       
    CMP.B       #1, D5              ; IF RICE/SALMON, EXTRA POINTS
    BEQ         SOY_BONUS
    
    CMP.B       #4, D5              ; IF NOODLES/EGG
    BEQ         SOY_BONUS
    
    LEA         SOY_SAUCE_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    ADD.B       #10, D3
    ADD.B       #5, D4
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
        
    BRA         MYSTERY_EVENT
    
*--------------------SOY BONUS SUBROUTINE------------------------------
SOY_BONUS:    
    LEA         SOY_BONUS_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    ADD.B       #20, D3
    ADD.B       #5, D4

    BRA         MYSTERY_EVENT       
    
*--------------------WASABI SUBROUTINE---------------------------------    
WASABI:
    CMP.B       #2, D5              ; IF RICE/EGG
    BEQ         WASABI_BONUS
    
    CMP.B       #4, D5              ; IF NOODLES/EGG
    BEQ         WASABI_BONUS
    
    CMP.B       #1, D5              ; IF RICE/SALMON
    BEQ         WASABI_PENALTY
    
    LEA         WASABI_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    ADD.B       #10, D3             ; ADD WASABI FLAVOUR POINTS
    ADD.B       #15, D4             ; ADD WASABI FRESHNESS POINTS

    
    BRA         MYSTERY_EVENT
    
*--------------------WASABI BONUS SUBROUTINE--------------------------
WASABI_BONUS:
    LEA         WASABI_BONUS_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    ADD.B       #15, D3
    ADD.B       #10, D4
    BRA         MYSTERY_EVENT

*--------------------WASABI PENALTY SUBROUTINE------------------------
WASABI_PENALTY:    
    LEA         WASABI_PENALTY_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    SUB.B       #10, D3
    ADD.B       #5, D4
    BRA         MYSTERY_EVENT    
    
*-------------------- LARDER FAIL_PATH SUBROUTINE---------------------
LARDER_FAIL_PATH:
    LEA         FAIL_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15   
    BRA         LARDER
    
*-------------------- RICE FRIDGE FAIL_PATH SUBROUTINE---------------------
RICE_FRIDGE_FAIL:
    LEA         FAIL_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    BRA         RICE_INPUT
    
*-------------------- NOODLES FRIDGE FAIL_PATH SUBROUTINE-------------------
NOODLES_FRIDGE_FAIL:
    LEA         FAIL_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    BRA         NOODLES_INPUT
    
*-------------------- SPICE FAIL_PATH SUBROUTINE---------------------------
SPICE_FAIL_PATH:
    LEA         FAIL_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    BRA         SPICE_INPUT
    
*---------------------CLEAR SCREEN SUBROUTINE------------------------------
CLEAR_SCREEN:
    MOVE.B      #11, D0
    MOVE.W      #$FF00, D1      ; CLEAR SCREEN
    TRAP        #15
    
    MOVE.B      #11, D0
    MOVE.W      #$0000, D1      ; SET CURSOR POSITION TO TOP LEFT TO AVOID CUTTING OFF TEXT 
    TRAP        #15
    
    RTS

    
*---------------------PRESS KEY SUBROUTINE------------------------------    
PRESS_KEY:
    ADD.B       #1, COUNTER
    
    MOVE.B      #11, D0
    MOVE.W      #$1B1E, D1      ; COLUMN 27, ROW 30 (AVOIDS MISSING LINE)
    TRAP        #15
    
    LEA         PRESS_KEY_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    MOVE.B      #5, D0
    TRAP        #15
    
    RTS
    
*--------------------MYSTERY EVENT SUBROUTINE-----------------------------
MYSTERY_EVENT:    
    MOVE.B      COUNTER, D1
    ADD.B       #1, COUNTER
    
    AND.B       #3, D1              ; SHOULD GIVE 25% CHANCE
    CMP.B       #1, D1          
    BEQ         MYSTERY_INGREDIENT
    
    BRA         CAT_EVENT

*--------------------MYSTERY INGREDIENT SUBROUTINE-------------------------
MYSTERY_INGREDIENT:
    LEA         MYSTERY_EVENT_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15 
    
    MOVE.B      #4, D0
    TRAP        #15  

    CMP.B       #1, D1
    BEQ         MYSTERY_ADD
    
    BRA         MYSTERY_IGNORE
    
*--------------------MYSTERY_ADD SUBROUTINE--------------------------------  
MYSTERY_ADD:
    MOVE.B      COUNTER, D1
    ADD.B       #1, COUNTER

    AND.B       #1, D1
    CMP.B       #1, D1 

    BEQ         MYSTERY_BONUS   ; BRANCH TO BONUS POINTS
    
    BRA         MYSTERY_PENALTY ; OTHERWISE BRANCH TO PENALTY
    
*--------------------MYSTERY GOOD SUBROUTINE-------------------------------
MYSTERY_BONUS:   
    LEA         MYSTERY_BONUS_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    ADD.B       #15, D3
    ADD.B       #15, D4 

    BRA         CAT_EVENT   

*--------------------MYSTERY PENALTY SUBROUTINE--------------------------------
MYSTERY_PENALTY:
    
    LEA         MYSTERY_PENALTY_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    SUB.B       #10, D3
    SUB.B       #10, D4 

    BRA         CAT_EVENT    

*--------------------MYSTERY IGNORE SUBROUTINE-----------------------------
MYSTERY_IGNORE:   
    LEA         MYSTERY_IGNORE_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15    
    
    BSR         PRESS_KEY    
    BSR         CLEAR_SCREEN
    
    BRA         CAT_EVENT
    
*--------------------CAT EVENT SUBROUTINE----------------------------------
CAT_EVENT:   
    MOVE.B      COUNTER, D1
    ADD.B       #1, COUNTER
    
    AND.B       #1, D1          ; 50/50 CHANCE
    CMP.B       #0, D1
    
    BEQ         CAT_ATTACKS
    BNE         CAT_SAFE
    
*--------------------CAT ATTACKS SUBROUTINE--------------------------------
CAT_ATTACKS:    
    LEA         CAT_ATTACKS_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    SUB.B       #10, D3         ; DEDUCT 10 FLAVOUR
    SUB.B       #5, D4          ; DEDUCT 5 FRESHNESS
    
    BRA         FINAL_COUNT        ; OTHERWISE CAT DOESN'T DO ANYTHING

*--------------------CAT SAFE SUBROUTINE--------------------------------    
CAT_SAFE:    
    LEA         CAT_SAFE_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15 
    
    BRA         FINAL_COUNT       ; OTHERWISE CAT DOESN'T DO ANYTHING

    
*--------------------FINAL COUNT SUBROUTINE--------------------------------   
FINAL_COUNT:
    BSR         CLEAR_SCREEN
    
    LEA         ENDING, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY
    BSR         CLEAR_SCREEN
    
    MOVE.B      D3, D6
    ADD.B       D4, D6
    
    CMP.B       #PERFECT_BOWL, D6
    BHI         PERFECT_ENDING
    
    CMP.B       #DECENT_BOWL, D6
    BHI         DECENT_ENDING
    
    BRA         BAD_ENDING
    
*--------------------FINAL COUNT SUBROUTINE--------------------------------- 
PERFECT_ENDING:
    BSR         CLEAR_SCREEN
    
    LEA         PERFECT_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    MOVE.B      #11, D0
    MOVE.W      #$1B1E, D1
    TRAP        #15
    
    LEA         PRESS_KEY_MSG, A1
    MOVE.B      #14, D0
    TRAP        #15
    
    MOVE.B      #5, D0
    TRAP        #15
    
    SIMHALT
    
*--------------------FINAL COUNT SUBROUTINE--------------------------------- 
DECENT_ENDING:
    BSR         CLEAR_SCREEN
    
    LEA         DECENT_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    BSR         PRESS_KEY
    
    MOVE.B      #5, D0              ; WAIT FOR USER TO PRESS KEY
    TRAP        #15    
    
    BRA         GAME_LOOP

*--------------------FINAL COUNT SUBROUTINE---------------------------------  
BAD_ENDING:   
    BSR         CLEAR_SCREEN
    
    LEA         BAD_MSG, A1
    MOVE.B      #13, D0
    TRAP        #15
    
    MOVE.B      #11, D0
    MOVE.W      #$1B1E, D1
    TRAP        #15
    
    LEA         PRESS_KEY_MSG, A1
    MOVE.B      #14, D0                 ; TASK 14 - NO LINE FEED
    TRAP        #15
    
    MOVE.B      #5, D0
    TRAP        #15
    
    SIMHALT

ASK_NAME:       DC.B        'Welcome stranger, please state your name'
                DC.B        $0D, $0A, 0

NAME:           DS.W        30                                ; DEFINE STORAGE TO A MAX OF 30

COUNTER:        DC.B        0                                   ;RANDOM EVENT COUNTER

WELCOME_MSG:    DC.B        'Greetings ',0 

PRESS_KEY_MSG:  DC.B        'PRESS ANY KEY TO CONTINUE',0 
                            
INTRODUCTION:   DC.B        $0D, $0A
                DC.B        '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><'
                DC.B        $0D, $0A
                DC.B        $0D, $0A
                DC.B        'BREAKING NEWS: YOU HAVE BEEN KIDNAPPED BY A COSMIC ENTITY!'
                DC.B        $0D, $0A
                DC.B        'THE GOOD NEWS: HE HAS NOT EATEN YOU'
                DC.B        $0D, $0A
                DC.B        'THE BAD NEWS: HE IS HUNGRY AND YOU ARE THE CHEF'
                DC.B        $0D, $0A
                DC.B        'COOK WELL, AND YOU MAY LIVE TO SEE ANOTHER DAY'
                DC.B        $0D, $0A 
                DC.B        'COOK BADLY...WELL, IT WAS NICE KNOWING YOU'
                DC.B        $0D, $0A
                DC.B        '(THE CAT IS WATCHING. THE CAT IS ALWAYS WATCHING)'
                DC.B        $0D, $0A
                DC.B        $0D, $0A, 0

LARDER_MSG:         DC.B    '                     <><><><><><><><><><><><><><><><><><><>  ' 
                    DC.B    $0D,$0A
                    DC.B    '                        TRIAL ONE - RICE TO THE OCCASION      '
                    DC.B    $0D,$0A    
                    DC.B    '                     <><><><><><><><><><><><><><><><><><><>  '
                    DC.B    $0D,$0A  
                    DC.B    $0D,$0A 
                    DC.B    'WHAT GRAIN WILL YOU COOK?'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A
                    DC.B    'RICE (1) OR RAMEN NOODLES (2)'
                    DC.B    $0D, $0A, 0
                
RICE_MSG:           DC.B    $0D, $0A
                    DC.B    'AH, RICE. A CLASSIC! SIMPLE, ELEGANT, SOME MIGHT SAY BRAVE'
                    DC.B    $0D, $0A
                    DC.B    'THE COSMIC ENTITY NODS APPROVINGLY (PROBABLY?)'
                    DC.B    $0D, $0A
                    DC.B    '+ 10 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A, 0

NOODLES_MSG:        DC.B    $0D, $0A
                    DC.B    'RAMEN NOODLES! A BOLD CHOICE FOR A KIDNAPPED CHEF'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITYS EYEBROWS RAISE APPROXIMATELY 3 INCHES'
                    DC.B    $0D, $0A
                    DC.B    '+ 15 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A, 0
                
FAIL_MSG:           DC.B    'INVALID CHOICE'
                    DC.B    $0D, $0A,0

RICE_SALMON_MSG:    DC.B    $0D, $0A
                    DC.B    'RICE AND SALMON? LOOK AT YOU BEING ALL FANCY!'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY LEANS FORWARD WITH SUSPICIOUS INTEREST'
                    DC.B    $0D, $0A
                    DC.B    'FLAVOUR POINTS +15, + 10 FRESHNESS POINTS'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0
                    
RICE_EGG_MSG:       DC.B    $0D, $0A
                    DC.B    'RICE AND EGG. A HUMBLE CHOICE (TOO HUMBLE PERHAPS?)'
                    DC.B    $0D, $0A
                    DC.B    'NOT INSPIRED. NOT TERRIBLE EITHER'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY TILTS HIS HEAD, SURVEYING'
                    DC.B    $0D, $0A
                    DC.B    '"INTERESTING." HE SAYS, IN A TONE THAT SUGGESTS IT IS ANYTHING BUT'
                    DC.B    $0D, $0A
                    DC.B    '+5 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0

FRIDGE_MSG:         DC.B    '                  <><><><><><><><><><><><><><><><><><><><><><>  '
                    DC.B    $0D,$0A
                    DC.B    '                     TRIAL TWO - EGG-CELLENT CHOICES AWAIT'
                    DC.B    $0D,$0A
                    DC.B    '                  <><><><><><><><><><><><><><><><><><><><><><>  '
                    DC.B    $0D,$0A
                    DC.B    $0D, $0A
                    DC.B    'YOU NEED A PROTEIN!'
                    DC.B    $0D, $0A
                    DC.B    'SALMON (1) OR EGG (2)'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0
                    
NOODLES_SALMON_MSG: DC.B    $0D, $0A
                    DC.B    'NOODLES AND SALMON... THE ENTITY SQUINTS'
                    DC.B    $0D, $0A
                    DC.B    'ONE OF HIS SEVENTEEN EYES TWITCHES SLIGHTLY'
                    DC.B    $0D, $0A
                    DC.B    '-5 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                    DC.B    $0D, $0A, 0
                    
NOODLES_EGG_MSG:    DC.B    $0D, $0A
                    DC.B    'RAMEN AND EGG IS A SACRED COMBINATION, KNOWN ACROSS COUNTLESS DIMENSIONS!'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITYS SEVENTEEN EYES LIGHT UP WITH GLEE'
                    DC.B    $0D, $0A
                    DC.B    '+5 FLAVOUR POINTS, +10 FRESHNESS'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0
    
SPICE_MSG:          DC.B    '                   <><><><><><><><><><><><><><><><><><><><><><><>    '
                    DC.B    $0D,$0A
                    DC.B    '                     TRIAL THREE ~ SOY YOU THINK YOU CAN COOK  '
                    DC.B    $0D,$0A
                    DC.B    '                   <><><><><><><><><><><><><><><><><><><><><><><>    '
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A
                    DC.B    'SOY SAUCE (1) OR WASABI(2)'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0  
    
SOY_SAUCE_MSG:      DC.B    $0D, $0A
                    DC.B    'SOY SAUCE IS ALWAYS A GOOD CHOICE'
                    DC.B    $0D, $0A
                    DC.B    '+ 10 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0                

WASABI_BONUS_MSG:   DC.B    $0D, $0A
                    DC.B    'FORTUNE FAVOURS THE BOLD, AND YOU ARE VERY BOLD' 
                    DC.B    $0D, $0A
                    DC.B    'OR POTENTIALLY RECKLESS. THE ENTITY IS UNSURE'
                    DC.B    $0D, $0A
                    DC.B    '+ 15 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0
                    
WASABI_MSG:         DC.B    $0D, $0A
                    DC.B    'A BOLD CHOICE, BUT A GOOD ONE'
                    DC.B    $0D, $0A
                    DC.B    '+ 5 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0                    
                    
                    
WASABI_PENALTY_MSG: DC.B    $0D, $0A
                    DC.B    'THE WASABI HAS DECLARED WAR ON THE SALMON'    
                    DC.B    $0D, $0A
                    DC.B    'THE SALMON IS LOSING'
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY WATCHES THE CHAOS UNFOLD'
                    DC.B    $0D, $0A
                    DC.B    '- 10 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                    DC.B    $0D, $0A                    
                    DC.B    $0D, $0A, 0  

SOY_BONUS_MSG:      DC.B    $0D, $0A
                    DC.B    'A PERFECT PAIRING. CIVILISED. REFINED. ALMOST CERTAINLY CORRECT'
                    DC.B    $0D, $0A
                    DC.B    'IT MAKES A SOUND THAT COULD BE CONSIDERED AGREEABLE'
                    DC.B    $0D, $0A
                    DC.B    '+ 20 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                    DC.B    $0D, $0A, 0 

CAT_ATTACKS_MSG:    DC.B    $0D, $0A
                    DC.B    'CAT-ASTROPHE STRIKES'
                    DC.B    $0D, $0A
                    DC.B    'THE CAT HAS KNOCKED THE MEAL OFF THE COUNTER'
                    DC.B    $0D, $0A
                    DC.B    'HE MAKES EYE CONTACT WITH YOU AS HE DOES IT'
                    DC.B    $0D, $0A
                    DC.B    'HE DOES NOT BREAK EYE CONTACT'
                    DC.B    $0D, $0A, 0

CAT_SAFE_MSG:       DC.B    $0D, $0A
                    DC.B    'THE CAT SNIFFS THE MEAL WITH GREAT SUSPICION'
                    DC.B    $0D, $0A
                    DC.B    'TODAY, YOU HAVE BEEN FOUND ACCEPTABLE.' 
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A, 0
                    
MYSTERY_EVENT_MSG:  DC.B    $0D, $0A
                    DC.B    'A MYSTERIOUS INGREDIENT HAS APPEARED ON YOUR COUNTER'
                    DC.B    $0D, $0A 
                    DC.B    'IT GLOWS WITH COSMIC ENERGY'
                    DC.B    $0D, $0A 
                    DC.B    'ADD IT TO YOUR DISH? YES (1) OR NO (2)'
                    DC.B    $0D, $0A 
                    DC.B    $0D, $0A, 0

MYSTERY_BONUS_MSG:  DC.B    $0D, $0A 
                    DC.B    'WHATEVER THAT WAS, IT WORKED'
                    DC.B    $0D, $0A 
                    DC.B    '+15 FLAVOUR, + 15 FRESHNESS'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A, 0 

MYSTERY_PENALTY_MSG:    DC.B    $0D, $0A
                        DC.B    'THE DISH LETS OUT A SMALL POP'
                        DC.B    $0D, $0A
                        DC.B    'THE DISH SMELLS DIFFERENT NOW'
                        DC.B    $0D, $0A
                        DC.B    'NOT BETTER. JUST DIFFERENT'
                        DC.B    $0D, $0A
                        DC.B    '-10 FLAVOUR, -10 FRESHNESS'
                        DC.B    $0D, $0A, 0
                        
MYSTERY_IGNORE_MSG:     DC.B    $0D, $0A
                        DC.B    'A WISE CHOICE'
                        DC.B    $0D, $0A
                        DC.B    'OR A COWARDLY ONE'
                        DC.B    $0D, $0A
                        DC.B    'THE UNIVERSE WILL NEVER KNOW'
                        DC.B    $0D, $0A
                        DC.B    'NEITHER WILL YOU'
                        DC.B    $0D, $0A
                        DC.B    $0D, $0A, 0
                 
                    
ENDING:             DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
                    DC.B    $0D, $0A  
                    DC.B    $0D, $0A  
                    DC.B    'THE ENTITY LIFTS THE BOWL SLOWLY'
                    DC.B    $0D, $0A  
                    DC.B    'HE EXAMINES IT FROM EVERY ANGLE WITH HIS SEVENTEEN EYES'
                    DC.B    $0D, $0A           
                    DC.B    'THE CAT HOLDS ITS BREATH'
                    DC.B    $0D, $0A   
                    DC.B    'AS DO YOU'
                    DC.B    $0D, $0A
                    DC.B    'EVEN THE UNIVERSE HOLDS ITS BREATH'
                    DC.B    $0D, $0A
                    DC.B    'HE TAKES A BITE'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A  
                    DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
                    DC.B    $0D, $0A, 0            
                    
                    
PERFECT_MSG:        DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY SETS DOWN HIS MEAL WITH A CLANG' 
                    DC.B    $0D, $0A
                    DC.B    'A SINGLE TEAR ROLLS DOWN HIS (COSMIC) FACE'
                    DC.B    $0D, $0A
                    DC.B    '"IN FOUR THOUSAND YEARS," HE WHISPERS "THIS IS MY FAVOURITE MEAL..."'
                    DC.B    $0D, $0A
                    DC.B    'HE COMPOSES HIMSELF'
                    DC.B    $0D, $0A
                    DC.B    '"YOU MAY CALL ME GERALD"'
                    DC.B    $0D, $0A
                    DC.B    '"NOW LEAVE, BEFORE I CHANGE MY MIND!"'
                    DC.B    $0D, $0A
                    DC.B    'HE SOBS AS HE DESCENDS INTO THE DEPTHS FROM WHENCE HE CAME'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A                    
                    DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
                    DC.B    $0D, $0A, 0 
                    

DECENT_MSG:         DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY POKES THE BOWL'
                    DC.B    $0D, $0A 
                    DC.B    'HE TAKES ONE BITE. THEN ANOTHER'
                    DC.B    $0D, $0A 
                    DC.B    '"YOU HAVE POTENTIAL," HE SAYS, BUT POTENTIAL IS NOT ENOUGH'
                    DC.B    $0D, $0A
                    DC.B    '"I WILL RETURN TOMORROW. I HOPE YOU WILL DO BETTER"'
                    DC.B    $0D, $0A
                    DC.B    'THE CAT FINISHES THE MEAL. THE CAT ENJOYS IT'
                    DC.B    $0D, $0A 
                    DC.B    $0D, $0A                 
                    DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>',0     

BAD_MSG:            DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A
                    DC.B    'THE ENTITY STARES AT THE BOWL FOR A VERY LONG TIME'
                    DC.B    $0D, $0A
                    DC.B    'THE CAT BACKS AWAY SLOWLY'
                    DC.B    $0D, $0A 
                    DC.B    'EVEN THE CAT KNOWS'
                    DC.B    $0D, $0A
                    DC.B    '"I HAVE CONSUMED GALAXIES," THE ENTITY SAYS QUIETLY'
                    DC.B    $0D, $0A
                    DC.B    '"AND THIS IS SOMEHOW WORSE"'
                    DC.B    $0D, $0A
                    DC.B    'YOUR UNIVERSE COLLAPSES. THE CAT SURVIVES'
                    DC.B    $0D, $0A
                    DC.B    'THE CAT ALWAYS SURVIVES'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A                   
                    DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
                    DC.B    $0D, $0A, 0    

NEW_GAME_MSG:       DC.B    $0D, $0A
                    DC.B    'A NEW DAY DAWNS...'
                    DC.B    $0D, $0A
                    DC.B    $0D, $0A
                    DC.B    'TRY AGAIN. HOPE FOR BETTER TIMES'
                    DC.B    $0D, $0A, 0                                  
                
    
    END         START                ; last line of source








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
