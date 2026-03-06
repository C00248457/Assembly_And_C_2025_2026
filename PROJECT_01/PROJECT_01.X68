*-----------------------------------------------------------
* Title      : The Grains of Fate
* Written by : Rachel O Shea - C00248457
* Date       : 21/02/2026 - 05/03/2026
* Description: 'Rice' to the occasion as a tiny chef 
; responsible for feeding the ancient cosmic entity
; that has kidnapped you
*-----------------------------------------------------------
    ORG    $1000

BAD_BOWL        EQU 30              ; BAD SCORE THRESHOLD
DECENT_BOWL     EQU 50              ; DECENT SCORE THRESHOLD
PERFECT_BOWL    EQU 70              ; PERFECT SCORE THRESHOLD

START:  

    CLR         D3                  ; CLEAR REGISTER D3 SO NO LEFTOVER VALUES
    CLR         D4                  ; CLEAR REGISTER D4 SO NO LEFTOVER VALUES
    
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    LEA         ASK_NAME, A1        ; LOAD ASK NAME MESSAGE INTO A1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
                        
    MOVE.B      #2, D0              ; TRAP TASK 2 - READ STRING INTO BUFFER AT A1, LENGTH RETURNED IN D1
    LEA         NAME, A1            ; LOAD NAME BUFFER INTO A1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #23, D0             ; TRAP TASK 23 - GET TIME ELAPSED SINCE MIDNIGHT IN MILLISECONDS
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    MOVE.B      D1, COUNTER         ; INITIALISE COUNTER WITH TIME VALUE FOR RANDOMNESS
    
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    BSR         WELCOME             ; BRANCH TO WELCOME SUBROUTINE 
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    BRA         LARDER              ; BRANCH ALWAYS TO LARDER SUBROUTINE

GAME_LOOP:
    CLR         D3                  ; CLEAR REGISTER D3 TO REMOVE LEFTOVER VALUES
    CLR         D4                  ; CLEAR REGISTER D4 TO REMOVE LEFTOVER VALUES
    
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    LEA         NEW_GAME_MSG, A1    ; LOAD NEW GAME MESSAGE INTO A1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    BRA         LARDER              ; BRANCH ALWAYS TO LARDER SUBROUTINE
    
*--------------------WELCOME SUBROUTINE---------------------- 
WELCOME:
    MOVE.B      #11, D0             ; TRAP TASK 11 - SET CURSOR POSITION
    MOVE.W      #$2001, D1          ; HIGH BYTE = COLUMN 32, LOW BYTE = ROW 1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    LEA         WELCOME_MSG, A1     ; LOAD WELCOME MESSAGE INTO A1
    MOVE.B      #14, D0             ; TRAP TASK 14 - DISPLAY STRING WITHOUT CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
                                           
    LEA         NAME, A1            ; LOAD NAME BUFFER INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    LEA         INTRODUCTION, A1    ; LOAD INTRODUCTION MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
  
    RTS                             ; RETURN FROM SUBROUTINE
    
*--------------------LARDER SUBROUTINE----------------------
LARDER:
    LEA         LARDER_MSG, A1      ; LOAD LARDER MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #4, D0              ; TRAP TASK 4 - READ INTEGER INPUT INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    CMP         #1, D1              ; COMPARE CHOICE TO 1
    BEQ         RICE                ; BRANCH TO RICE IF EQUAL
    
    CMP         #2, D1              ; COMPARE CHOICE TO 2
    BEQ         NOODLES             ; BRANCH TO NOODLES IF EQUAL
  
    BRA         LARDER_FAIL_PATH    ; BRANCH ALWAYS TO FAIL PATH FOR OTHER INPUTS
    
*--------------------RICE SUBROUTINE------------------------
RICE:  
    ADD.B       #10, D3             ; ADD RICE FLAVOUR POINTS TO D3
    ADD.B       #10, D4             ; ADD RICE FRESHNESS POINTS TO D4
    
    LEA         RICE_MSG, A1        ; LOAD RICE MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    LEA         FRIDGE_MSG, A1      ; LOAD FRIDGE MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
RICE_INPUT:    
    MOVE.B      #4, D0              ; TRAP TASK 4 - READ INTEGER INPUT INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    CMP         #1, D1              ; COMPARE CHOICE TO 1
    BEQ         RICE_SALMON         ; BRANCH TO RICE SALMON IF EQUAL
    
    CMP         #2, D1              ; COMPARE CHOICE TO 2
    BEQ         RICE_EGG            ; BRANCH TO RICE EGG IF EQUAL
    
    BRA         RICE_FRIDGE_FAIL    ; BRANCH ALWAYS TO FAIL PATH FOR OTHER INPUTS

*--------------------NOODLES SUBROUTINE----------------------
NOODLES:
    ADD.B       #15, D3             ; ADD NOODLE FLAVOUR POINTS TO D3
    ADD.B       #15, D4             ; ADD NOODLE FRESHNESS POINTS TO D4
    
    LEA         NOODLES_MSG, A1     ; LOAD NOODLES MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    LEA         FRIDGE_MSG, A1      ; LOAD FRIDGE MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
NOODLES_INPUT:
    MOVE.B      #4, D0              ; TRAP TASK 4 - READ INTEGER INPUT INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    CMP         #1, D1              ; COMPARE CHOICE TO 1
    BEQ         NOODLES_SALMON      ; BRANCH TO NOODLES SALMON IF EQUAL
    
    CMP         #2, D1              ; COMPARE CHOICE TO 2
    BEQ         NOODLES_EGG         ; BRANCH TO NOODLES EGG IF EQUAL
    
    BRA         NOODLES_FRIDGE_FAIL ; BRANCH ALWAYS TO FAIL PATH FOR OTHER INPUTS
    
*--------------------RICE SALMON SUBROUTINE--------------------- 
RICE_SALMON:
    ADD.B       #15, D3             ; ADD SALMON FLAVOUR POINTS TO D3
    ADD.B       #10, D4             ; ADD SALMON FRESHNESS POINTS TO D4
    
    LEA         RICE_SALMON_MSG, A1 ; LOAD RICE SALMON MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    MOVE.B      #1, D5              ; STORE COMBO ID 1 (RICE/SALMON) IN D5 FOR SPICE SCORING

    BRA         SPICE               ; BRANCH ALWAYS TO SPICE SUBROUTINE

*--------------------RICE EGG SUBROUTINE---------------------------
RICE_EGG:
    ADD.B       #5, D3              ; ADD EGG FLAVOUR POINTS TO D3
    ADD.B       #10, D4             ; ADD EGG FRESHNESS POINTS TO D4
    
    LEA         RICE_EGG_MSG, A1    ; LOAD RICE EGG MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    MOVE.B      #2, D5              ; STORE COMBO ID 2 (RICE/EGG) IN D5 FOR SPICE SCORING
    
    BRA         SPICE               ; BRANCH ALWAYS TO SPICE SUBROUTINE
    
*--------------------NOODLES SALMON SUBROUTINE--------------------- 
NOODLES_SALMON:   
    SUB.B       #5, D3              ; DEDUCT SALMON FLAVOUR POINTS FROM D3
    ADD.B       #5, D4              ; ADD SALMON FRESHNESS POINTS TO D4
    
    LEA         NOODLES_SALMON_MSG, A1  ; LOAD NOODLES SALMON MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    MOVE.B      #3, D5              ; STORE COMBO ID 3 (NOODLES/SALMON) IN D5 FOR SPICE SCORING
    
    BRA         SPICE               ; BRANCH ALWAYS TO SPICE SUBROUTINE
    
*--------------------NOODLES EGG SUBROUTINE--------------------------
NOODLES_EGG:
    ADD.B       #5, D3              ; ADD EGG FLAVOUR POINTS TO D3
    ADD.B       #10, D4             ; ADD EGG FRESHNESS POINTS TO D4
    
    LEA         NOODLES_EGG_MSG, A1 ; LOAD NOODLES EGG MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    MOVE.B      #4, D5              ; STORE COMBO ID 4 (NOODLES/EGG) IN D5 FOR SPICE SCORING
    
    BRA         SPICE               ; BRANCH ALWAYS TO SPICE SUBROUTINE
    
*--------------------SPICE SUBROUTINE--------------------------------
SPICE:
    LEA         SPICE_MSG, A1       ; LOAD SPICE MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
SPICE_INPUT:   
    MOVE.B      #4, D0              ; TRAP TASK 4 - READ INTEGER INPUT INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    CMP.B       #1, D1              ; COMPARE CHOICE TO 1
    BEQ         SOY_SAUCE           ; BRANCH TO SOY SAUCE IF EQUAL
    
    CMP.B       #2, D1              ; COMPARE CHOICE TO 2
    BEQ         WASABI              ; BRANCH TO WASABI IF EQUAL

    BRA         SPICE_FAIL_PATH     ; BRANCH ALWAYS TO FAIL PATH FOR OTHER INPUTS
    
*--------------------SOY SAUCE SUBROUTINE------------------------------
SOY_SAUCE:       
    CMP.B       #1, D5              ; CHECK IF COMBO IS RICE/SALMON (1)
    BEQ         SOY_BONUS           ; BRANCH TO SOY BONUS IF EQUAL
    
    CMP.B       #4, D5              ; CHECK IF COMBO IS NOODLES/EGG (4)
    BEQ         SOY_BONUS           ; BRANCH TO SOY BONUS IF EQUAL
    
    LEA         SOY_SAUCE_MSG, A1   ; LOAD SOY SAUCE MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    ADD.B       #10, D3             ; ADD SOY SAUCE FLAVOUR POINTS TO D3
    ADD.B       #5, D4              ; ADD SOY SAUCE FRESHNESS POINTS TO D4
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
        
    BRA         MYSTERY_EVENT       ; BRANCH ALWAYS TO MYSTERY EVENT SUBROUTINE
    
*--------------------SOY BONUS SUBROUTINE------------------------------
SOY_BONUS:    
    LEA         SOY_BONUS_MSG, A1   ; LOAD SOY BONUS MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    ADD.B       #20, D3             ; ADD SOY BONUS FLAVOUR POINTS TO D3
    ADD.B       #5, D4              ; ADD SOY BONUS FRESHNESS POINTS TO D4

    BRA         MYSTERY_EVENT       ; BRANCH ALWAYS TO MYSTERY EVENT SUBROUTINE
    
*--------------------WASABI SUBROUTINE---------------------------------    
WASABI:
    CMP.B       #2, D5              ; CHECK IF COMBO IS RICE/EGG (2)
    BEQ         WASABI_BONUS        ; BRANCH TO WASABI BONUS IF EQUAL
    
    CMP.B       #4, D5              ; CHECK IF COMBO IS NOODLES/EGG (4)
    BEQ         WASABI_BONUS        ; BRANCH TO WASABI BONUS IF EQUAL
    
    CMP.B       #1, D5              ; CHECK IF COMBO IS RICE/SALMON (1)
    BEQ         WASABI_PENALTY      ; BRANCH TO WASABI PENALTY IF EQUAL
    
    LEA         WASABI_MSG, A1      ; LOAD WASABI MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    ADD.B       #10, D3             ; ADD WASABI FLAVOUR POINTS TO D3
    ADD.B       #15, D4             ; ADD WASABI FRESHNESS POINTS TO D4
    
    BRA         MYSTERY_EVENT       ; BRANCH ALWAYS TO MYSTERY EVENT SUBROUTINE
    
*--------------------WASABI BONUS SUBROUTINE--------------------------
WASABI_BONUS:
    LEA         WASABI_BONUS_MSG, A1 ; LOAD WASABI BONUS MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    ADD.B       #15, D3             ; ADD WASABI BONUS FLAVOUR POINTS TO D3
    ADD.B       #10, D4             ; ADD WASABI BONUS FRESHNESS POINTS TO D4

    BRA         MYSTERY_EVENT       ; BRANCH ALWAYS TO MYSTERY EVENT SUBROUTINE

*--------------------WASABI PENALTY SUBROUTINE------------------------
WASABI_PENALTY:    
    LEA         WASABI_PENALTY_MSG, A1 ; LOAD WASABI PENALTY MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    SUB.B       #10, D3             ; DEDUCT WASABI PENALTY FLAVOUR POINTS FROM D3
    ADD.B       #5, D4              ; ADD WASABI PENALTY FRESHNESS POINTS TO D4

    BRA         MYSTERY_EVENT       ; BRANCH ALWAYS TO MYSTERY EVENT SUBROUTINE
    
*-------------------- LARDER FAIL_PATH SUBROUTINE---------------------
LARDER_FAIL_PATH:
    LEA         FAIL_MSG, A1        ; LOAD FAIL MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    BRA         LARDER              ; BRANCH ALWAYS BACK TO LARDER FOR RE-INPUT
    
*-------------------- RICE FRIDGE FAIL_PATH SUBROUTINE---------------------
RICE_FRIDGE_FAIL:
    LEA         FAIL_MSG, A1        ; LOAD FAIL MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    BRA         RICE_INPUT          ; BRANCH ALWAYS BACK TO RICE INPUT FOR RE-INPUT
    
*-------------------- NOODLES FRIDGE FAIL_PATH SUBROUTINE-------------------
NOODLES_FRIDGE_FAIL:
    LEA         FAIL_MSG, A1        ; LOAD FAIL MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    BRA         NOODLES_INPUT       ; BRANCH ALWAYS BACK TO NOODLES INPUT FOR RE-INPUT
    
*-------------------- SPICE FAIL_PATH SUBROUTINE---------------------------
SPICE_FAIL_PATH:
    LEA         FAIL_MSG, A1        ; LOAD FAIL MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    BRA         SPICE_INPUT         ; BRANCH ALWAYS BACK TO SPICE INPUT FOR RE-INPUT
    
*---------------------CLEAR SCREEN SUBROUTINE------------------------------
CLEAR_SCREEN:
    MOVE.B      #11, D0             ; TRAP TASK 11 - SET CURSOR POSITION
    MOVE.W      #$FF00, D1          ; $FF IN HIGH BYTE CLEARS THE SCREEN
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #11, D0             ; TRAP TASK 11 - SET CURSOR POSITION
    MOVE.W      #$0000, D1          ; RESET CURSOR TO TOP LEFT (COLUMN 0, ROW 0)
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    RTS                             ; RETURN FROM SUBROUTINE

    
*---------------------PRESS KEY SUBROUTINE------------------------------    
PRESS_KEY:
    ADD.B       #1, COUNTER         ; INCREMENT COUNTER TO VARY RANDOM OUTCOMES
    
    MOVE.B      #11, D0             ; TRAP TASK 11 - SET CURSOR POSITION
    MOVE.W      #$1B1E, D1          ; COLUMN 27 ($1B), ROW 30 ($1E) - SECOND TO LAST ROW
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    LEA         PRESS_KEY_MSG, A1   ; LOAD PRESS KEY MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #5, D0              ; TRAP TASK 5 - READ SINGLE KEYPRESS INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    RTS                             ; RETURN FROM SUBROUTINE
    
*--------------------MYSTERY EVENT SUBROUTINE-----------------------------
MYSTERY_EVENT:    
    MOVE.B      COUNTER, D1         ; LOAD CURRENT COUNTER VALUE INTO D1
    ADD.B       #1, COUNTER         ; INCREMENT COUNTER FOR NEXT RANDOM CHECK
    
    AND.B       #3, D1              ; MASK TO LOWEST 2 BITS - GIVES 25% CHANCE (0,1,2 OR 3)
    CMP.B       #1, D1              ; COMPARE RESULT TO 1
    BEQ         MYSTERY_INGREDIENT  ; BRANCH TO MYSTERY INGREDIENT IF EQUAL
    
    BRA         CAT_EVENT           ; BRANCH ALWAYS TO CAT EVENT IF NO MYSTERY

*--------------------MYSTERY INGREDIENT SUBROUTINE-------------------------
MYSTERY_INGREDIENT:
    LEA         MYSTERY_EVENT_MSG, A1 ; LOAD MYSTERY EVENT MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #4, D0              ; TRAP TASK 4 - READ INTEGER INPUT INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK

    CMP.B       #1, D1              ; COMPARE CHOICE TO 1
    BEQ         MYSTERY_ADD         ; BRANCH TO MYSTERY ADD IF PLAYER CHOOSES YES
    
    CMP.B       #2, D1              ; COMPARE CHOICE TO 2
    BEQ         MYSTERY_IGNORE      ; BRANCH TO MYSTERY IGNORE IF PLAYER CHOOSES NO
    
    LEA         FAIL_MSG, A1        ; LOAD FAIL MESSAGE INTO A1 FOR INVALID INPUT
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    BRA         MYSTERY_INGREDIENT  ; BRANCH ALWAYS BACK FOR RE-INPUT
    
*--------------------MYSTERY ADD SUBROUTINE--------------------------------  
MYSTERY_ADD:
    ADD.B       #1, COUNTER         ; EXTRA INCREMENT TO SHIFT COUNTER VALUE FOR TRUE 50/50
    MOVE.B      COUNTER, D1         ; LOAD COUNTER VALUE INTO D1
    ADD.B       #1, COUNTER         ; INCREMENT COUNTER FOR NEXT RANDOM CHECK

    AND.B       #1, D1              ; ISOLATE THE LOWEST BIT - GIVES 50/50 CHANCE (0 OR 1)
    CMP.B       #1, D1              ; COMPARE RESULT TO 1

    BEQ         MYSTERY_BONUS       ; BRANCH TO BONUS IF EQUAL
    BRA         MYSTERY_PENALTY     ; BRANCH ALWAYS TO PENALTY OTHERWISE
    
*--------------------MYSTERY BONUS SUBROUTINE-------------------------------
MYSTERY_BONUS:   
    LEA         MYSTERY_BONUS_MSG, A1 ; LOAD MYSTERY BONUS MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    ADD.B       #15, D3             ; ADD MYSTERY BONUS FLAVOUR POINTS TO D3
    ADD.B       #15, D4             ; ADD MYSTERY BONUS FRESHNESS POINTS TO D4

    BRA         CAT_EVENT           ; BRANCH ALWAYS TO CAT EVENT SUBROUTINE

*--------------------MYSTERY PENALTY SUBROUTINE--------------------------------
MYSTERY_PENALTY:
    LEA         MYSTERY_PENALTY_MSG, A1 ; LOAD MYSTERY PENALTY MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    SUB.B       #10, D3             ; DEDUCT MYSTERY PENALTY FLAVOUR POINTS FROM D3
    SUB.B       #10, D4             ; DEDUCT MYSTERY PENALTY FRESHNESS POINTS FROM D4

    BRA         CAT_EVENT           ; BRANCH ALWAYS TO CAT EVENT SUBROUTINE

*--------------------MYSTERY IGNORE SUBROUTINE-----------------------------
MYSTERY_IGNORE:   
    LEA         MYSTERY_IGNORE_MSG, A1 ; LOAD MYSTERY IGNORE MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    BRA         CAT_EVENT           ; BRANCH ALWAYS TO CAT EVENT SUBROUTINE
    
*--------------------CAT EVENT SUBROUTINE----------------------------------
CAT_EVENT:   
    MOVE.B      COUNTER, D1         ; LOAD CURRENT COUNTER VALUE INTO D1
    ADD.B       #1, COUNTER         ; INCREMENT COUNTER FOR NEXT RANDOM CHECK
    
    LSR.B       #1, D1              ; SHIFT BITS RIGHT BY 1 TO ACCESS DIFFERENT BIT PATTERN
    AND.B       #1, D1              ; ISOLATE THE LOWEST BIT - GIVES 50/50 CHANCE (0 OR 1)
    CMP.B       #0, D1              ; COMPARE RESULT TO 0
    
    BEQ         CAT_ATTACKS         ; BRANCH TO CAT ATTACKS IF EQUAL
    BNE         CAT_SAFE            ; BRANCH TO CAT SAFE OTHERWISE
    
*--------------------CAT ATTACKS SUBROUTINE--------------------------------
CAT_ATTACKS:    
    LEA         CAT_ATTACKS_MSG, A1 ; LOAD CAT ATTACKS MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    SUB.B       #10, D3             ; DEDUCT CAT ATTACK FLAVOUR POINTS FROM D3
    SUB.B       #5, D4              ; DEDUCT CAT ATTACK FRESHNESS POINTS FROM D4
    
    BRA         FINAL_COUNT         ; BRANCH ALWAYS TO FINAL COUNT SUBROUTINE

*--------------------CAT SAFE SUBROUTINE--------------------------------    
CAT_SAFE:    
    LEA         CAT_SAFE_MSG, A1    ; LOAD CAT SAFE MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    BRA         FINAL_COUNT         ; BRANCH ALWAYS TO FINAL COUNT SUBROUTINE

    
*--------------------FINAL COUNT SUBROUTINE--------------------------------   
FINAL_COUNT:
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    LEA         ENDING, A1          ; LOAD ENDING MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BSR         PRESS_KEY           ; BRANCH TO PRESS KEY SUBROUTINE
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    MOVE.B      D3, D6              ; COPY FLAVOUR SCORE TO D6 FOR FINAL CALCULATION
    ADD.B       D4, D6              ; ADD FRESHNESS SCORE TO D6 FOR TOTAL SCORE
    
    CMP.B       #PERFECT_BOWL, D6   ; COMPARE TOTAL SCORE AGAINST PERFECT THRESHOLD
    BHI         PERFECT_ENDING      ; BRANCH IF HIGHER - UNSIGNED COMPARISON
    
    CMP.B       #DECENT_BOWL, D6    ; COMPARE TOTAL SCORE AGAINST DECENT THRESHOLD
    BHI         DECENT_ENDING       ; BRANCH IF HIGHER - UNSIGNED COMPARISON
    
    BRA         BAD_ENDING          ; BRANCH ALWAYS TO BAD ENDING IF BELOW DECENT THRESHOLD
    
*--------------------PERFECT ENDING SUBROUTINE--------------------------------- 
PERFECT_ENDING:
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    LEA         PERFECT_MSG, A1     ; LOAD PERFECT ENDING MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #11, D0             ; TRAP TASK 11 - SET CURSOR POSITION
    MOVE.W      #$1B1E, D1          ; COLUMN 27 ($1B), ROW 30 ($1E) - SECOND TO LAST ROW
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    LEA         PRESS_KEY_MSG, A1   ; LOAD PRESS KEY MESSAGE INTO A1
    MOVE.B      #14, D0             ; TRAP TASK 14 - DISPLAY STRING WITHOUT CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #5, D0              ; TRAP TASK 5 - READ SINGLE KEYPRESS INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    SIMHALT                         ; HALT SIMULATOR
    
*--------------------DECENT ENDING SUBROUTINE--------------------------------- 
DECENT_ENDING:
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    LEA         DECENT_MSG, A1      ; LOAD DECENT ENDING MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #5, D0              ; TRAP TASK 5 - READ SINGLE KEYPRESS INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    BRA         GAME_LOOP           ; BRANCH ALWAYS BACK TO GAME LOOP FOR ANOTHER ATTEMPT

*--------------------BAD ENDING SUBROUTINE---------------------------------  
BAD_ENDING:   
    BSR         CLEAR_SCREEN        ; BRANCH TO CLEAR SCREEN SUBROUTINE
    
    LEA         BAD_MSG, A1         ; LOAD BAD ENDING MESSAGE INTO A1
    MOVE.B      #13, D0             ; TRAP TASK 13 - DISPLAY NULL TERMINATED STRING WITH CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #11, D0             ; TRAP TASK 11 - SET CURSOR POSITION
    MOVE.W      #$1B1E, D1          ; COLUMN 27 ($1B), ROW 30 ($1E) - SECOND TO LAST ROW
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    LEA         PRESS_KEY_MSG, A1   ; LOAD PRESS KEY MESSAGE INTO A1
    MOVE.B      #14, D0             ; TRAP TASK 14 - DISPLAY STRING WITHOUT CR/LF
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    MOVE.B      #5, D0              ; TRAP TASK 5 - READ SINGLE KEYPRESS INTO D1
    TRAP        #15                 ; INTERRUPT AND EXECUTE TRAP TASK
    
    SIMHALT                         ; HALT SIMULATOR
    
 ASK_NAME:           DC.B        'Welcome stranger, please state your name'
                        DC.B        $0D, $0A, 0

NAME:                   DS.W        30                                ; DEFINE STORAGE TO A MAX OF 30

COUNTER:                DC.B        0                                   ;RANDOM EVENT COUNTER

WELCOME_MSG:            DC.B        'Greetings ',0 

PRESS_KEY_MSG:          DC.B        'PRESS ANY KEY TO CONTINUE',0 
                            
INTRODUCTION:           DC.B        $0D, $0A
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

LARDER_MSG:             DC.B    '                     <><><><><><><><><><><><><><><><><><><>  ' 
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
                
RICE_MSG:               DC.B    $0D, $0A
                        DC.B    'AH, RICE. A CLASSIC! SIMPLE, ELEGANT, SOME MIGHT SAY BRAVE'
                        DC.B    $0D, $0A
                        DC.B    'THE COSMIC ENTITY NODS APPROVINGLY (PROBABLY?)'
                        DC.B    $0D, $0A
                        DC.B    '+ 10 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                        DC.B    $0D, $0A
                        DC.B    $0D, $0A, 0

NOODLES_MSG:            DC.B    $0D, $0A
                        DC.B    'RAMEN NOODLES! A BOLD CHOICE FOR A KIDNAPPED CHEF'
                        DC.B    $0D, $0A
                        DC.B    'THE ENTITYS EYEBROWS RAISE APPROXIMATELY 3 INCHES'
                        DC.B    $0D, $0A
                        DC.B    '+ 15 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                        DC.B    $0D, $0A
                        DC.B    $0D, $0A, 0
                
FAIL_MSG:               DC.B    'INVALID CHOICE'
                        DC.B    $0D, $0A,0

RICE_SALMON_MSG:        DC.B    $0D, $0A
                        DC.B    'RICE AND SALMON? LOOK AT YOU BEING ALL FANCY!'
                        DC.B    $0D, $0A
                        DC.B    'THE ENTITY LEANS FORWARD WITH SUSPICIOUS INTEREST'
                        DC.B    $0D, $0A
                        DC.B    'FLAVOUR POINTS +15, + 10 FRESHNESS POINTS'
                        DC.B    $0D, $0A                    
                        DC.B    $0D, $0A, 0
                    
RICE_EGG_MSG:           DC.B    $0D, $0A
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

FRIDGE_MSG:             DC.B    '                  <><><><><><><><><><><><><><><><><><><><><><>  '
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
                    
NOODLES_SALMON_MSG:     DC.B    $0D, $0A
                        DC.B    'NOODLES AND SALMON... THE ENTITY SQUINTS'
                        DC.B    $0D, $0A
                        DC.B    'ONE OF HIS SEVENTEEN EYES TWITCHES SLIGHTLY'
                        DC.B    $0D, $0A
                        DC.B    '-5 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                        DC.B    $0D, $0A, 0
                    
NOODLES_EGG_MSG:        DC.B    $0D, $0A
                        DC.B    'RAMEN AND EGG IS A SACRED COMBINATION, KNOWN ACROSS COUNTLESS DIMENSIONS!'
                        DC.B    $0D, $0A
                        DC.B    'THE ENTITYS SEVENTEEN EYES LIGHT UP WITH GLEE'
                        DC.B    $0D, $0A
                        DC.B    '+5 FLAVOUR POINTS, +10 FRESHNESS'
                        DC.B    $0D, $0A                    
                        DC.B    $0D, $0A, 0
    
SPICE_MSG:              DC.B    '                   <><><><><><><><><><><><><><><><><><><><><><><>    '
                        DC.B    $0D,$0A
                        DC.B    '                     TRIAL THREE ~ SOY YOU THINK YOU CAN COOK  '
                        DC.B    $0D,$0A
                        DC.B    '                   <><><><><><><><><><><><><><><><><><><><><><><>    '
                        DC.B    $0D, $0A
                        DC.B    $0D, $0A
                        DC.B    'SOY SAUCE (1) OR WASABI(2)'
                        DC.B    $0D, $0A                    
                        DC.B    $0D, $0A, 0  
    
SOY_SAUCE_MSG:          DC.B    $0D, $0A
                        DC.B    'SOY SAUCE IS ALWAYS A GOOD CHOICE'
                        DC.B    $0D, $0A
                        DC.B    '+ 10 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                        DC.B    $0D, $0A                    
                        DC.B    $0D, $0A, 0                

WASABI_BONUS_MSG:       DC.B    $0D, $0A
                        DC.B    'FORTUNE FAVOURS THE BOLD, AND YOU ARE VERY BOLD' 
                        DC.B    $0D, $0A
                        DC.B    'OR POTENTIALLY RECKLESS. THE ENTITY IS UNSURE'
                        DC.B    $0D, $0A
                        DC.B    '+ 15 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                        DC.B    $0D, $0A                    
                        DC.B    $0D, $0A, 0
                    
WASABI_MSG:             DC.B    $0D, $0A
                        DC.B    'A BOLD CHOICE, BUT A GOOD ONE'
                        DC.B    $0D, $0A
                        DC.B    '+ 5 FLAVOUR POINTS, + 10 FRESHNESS POINTS'
                        DC.B    $0D, $0A                    
                        DC.B    $0D, $0A, 0                    
                    
                    
WASABI_PENALTY_MSG:     DC.B    $0D, $0A
                        DC.B    'THE WASABI HAS DECLARED WAR ON THE SALMON'    
                        DC.B    $0D, $0A
                        DC.B    'THE SALMON IS LOSING'
                        DC.B    $0D, $0A
                        DC.B    'THE ENTITY WATCHES THE CHAOS UNFOLD'
                        DC.B    $0D, $0A
                        DC.B    '- 10 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                        DC.B    $0D, $0A                    
                        DC.B    $0D, $0A, 0  

SOY_BONUS_MSG:          DC.B    $0D, $0A
                        DC.B    'A PERFECT PAIRING. CIVILISED. REFINED. ALMOST CERTAINLY CORRECT'
                        DC.B    $0D, $0A
                        DC.B    'IT MAKES A SOUND THAT COULD BE CONSIDERED AGREEABLE'
                        DC.B    $0D, $0A
                        DC.B    '+ 20 FLAVOUR POINTS, + 5 FRESHNESS POINTS'
                        DC.B    $0D, $0A, 0 

CAT_ATTACKS_MSG:        DC.B    $0D, $0A
                        DC.B    'CAT-ASTROPHE STRIKES'
                        DC.B    $0D, $0A
                        DC.B    'THE CAT HAS KNOCKED THE MEAL OFF THE COUNTER'
                        DC.B    $0D, $0A
                        DC.B    'HE MAKES EYE CONTACT WITH YOU AS HE DOES IT'
                        DC.B    $0D, $0A
                        DC.B    'HE DOES NOT BREAK EYE CONTACT'
                        DC.B    $0D, $0A, 0

CAT_SAFE_MSG:           DC.B    $0D, $0A
                        DC.B    'THE CAT SNIFFS THE MEAL WITH GREAT SUSPICION'
                        DC.B    $0D, $0A
                        DC.B    'TODAY, YOU HAVE BEEN FOUND ACCEPTABLE.' 
                        DC.B    $0D, $0A
                        DC.B    $0D, $0A, 0
                    
MYSTERY_EVENT_MSG:      DC.B    $0D, $0A
                        DC.B    'A MYSTERIOUS INGREDIENT HAS APPEARED ON YOUR COUNTER'
                        DC.B    $0D, $0A 
                        DC.B    'IT GLOWS WITH COSMIC ENERGY'
                        DC.B    $0D, $0A 
                        DC.B    'ADD IT TO YOUR DISH? YES (1) OR NO (2)'
                        DC.B    $0D, $0A 
                        DC.B    $0D, $0A, 0

MYSTERY_BONUS_MSG:      DC.B    $0D, $0A 
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
                 
                    
ENDING:                 DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
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
                    
                    
PERFECT_MSG:            DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
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
                    

DECENT_MSG:             DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
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

BAD_MSG:                DC.B    '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>'
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

NEW_GAME_MSG:           DC.B    $0D, $0A
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
