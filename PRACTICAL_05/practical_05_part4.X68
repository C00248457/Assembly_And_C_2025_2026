*-----------------------------------------------------------
* Title      :  Practical 05 Task 4
* Written by :  Rachel O Shea
* Date       :  11/02/2026
* Description:  Utilise conditional branches and control structures
*-----------------------------------------------------------
    ORG    $1000
    
; D0 used for trap codes, an counting enemies
; D1 used for players health
; D2 used for enemy position
; D3 used for enemy count
; A0 used for counting enemies
; A1 used for progress messages
; A2 used for player_x
; A3 used for enemy_positions

DAMAGE  EQU 19              ; damage when collisions occur

START:                      
    LEA PLAYER_X, A2        ; player will move along x axis
    LEA ENEMY_POSITIONS, A3 ; enemy positions or spawn points
    BRA GAME_LOOP
    
GAME_LOOP:
    BSR COUNT_ENEMIES       ; size of the enemy_positions array
    MOVE.B  D0, D4          ; reset enemy count at beginning of loop
    
    LEA MSG_GAMELOOP, A1    ; load and draw gameloop message
    BSR DRAW    
    
    BSR UPDATE              ; call update
    BRA GAME_LOOP           ; call game_loop
    
UPDATE:

    MOVE.B  PLAYER_HEALTH, D1   ; move player health into D1
    
    LEA MSG_HEALTH, A1          ; load and draw health message
    BSR DRAW
    
    MOVE.B  #3, D0              ; display signed number in D1.L in decimal to smallest field
    TRAP    #15                 
    
    LEA CRLF, A1                ; load and carriage return and line feed
    BSR DRAW
    
    CMP #0, D1                  ; check if health is 0
    BLE GAME_OVER               ; game over
    ADD.L   #1, (A2)            ; change position of player
    BSR COLLISION               ; check for collision with enemies
    
DRAW:
    MOVE.B  #13, D0
    TRAP    #15
    RTS
 
COLLISION:
    MOVE.B  #1, D5              ; loop through array
    LEA     ENEMY_POSITIONS, A3 ; load enemy_positions array
    
ITERATE:
    CMP     D5, D4              ; counter for enemy_positions
    ADD.B   #1, D5              ; subtract one
    BEQ     GAME_LOOP           ; if 0 goto GAME_LOOP
    BNE     CHECK_ENEMIES       ; if not check for enemy collisions
    RTS
    
CHECK_ENEMIES:
    MOVE.L  (A3)+, D2           ; move enemies position to D2
    MOVE.L  (A2), D3            ; move player position to D3
    
    CMP.L   D2, D3              ; compare player and enemy position
    BEQ     REDUCE_HEALTH       ; if equal reduce health
    BNE     ITERATE             ; iterate to next enemy
    
REDUCE_HEALTH:
    LEA     MSG_COLLISION, A1   ; load and draw collision message
    BSR     DRAW
    
    SUB.B   #DAMAGE, PLAYER_HEALTH
    
    LEA     MSG_DAMAGE, A1     ; load and draw damage message
    BSR     DRAW
    
    BRA     GAME_LOOP
    
GAME_OVER:
    LEA     MSG_GAMEOVER, A1
    BSR     DRAW
    
    SIMHALT          

COUNT_ENEMIES:
    MOVE.B  #0, D0              ; initialise counter to 0
    LEA     ENEMY_POSITIONS, A0 ; load the address of array into A0
   
COUNT_ENEMIES_LOOP:
    TST.L   (A0)+               ; test the byte at the address in A0 (Check if 0) and increment A0
    BEQ     END_COUNTING        ; if the byte is zero, it's the end of the array
    
    ADD.B   #1, D0              ; increment the counter
    BRA     COUNT_ENEMIES_LOOP  ; repeat the loop
    
END_COUNTING:
    RTS
    
PLAYER_X        DC.L    1
PLAYER_HEALTH   DC.B    100
MSG_HEALTH      DC.B    'Health : ', 0
MSG_GAMELOOP    DC.B    'Game Loop', 0
MSG_COLLISION   DC.B    'Collision', 0
MSG_GAMEOVER    DC.B    'Game over', 0
MSG_DAMAGE      DC.B    'Taking Damage', 0
CRLF            DC.B    $0D, $0A, 0
ENEMY_POSITIONS DC.L    20, 30, 40, 50, 60, 70, 80, 90, 200, 300, 500, 0 ; Terminate array with a 0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
