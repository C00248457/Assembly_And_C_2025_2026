*-----------------------------------------------------------
* Title      :  PraCtical 4
* Written by :  Rachel O Shea
* Date       :  04/02/2026
* Description:  Practical 4 Task 4
*-----------------------------------------------------------
    ORG    $1000
START:                  

    ; Load player health into Address Register 2
    LEA     PLAYER_HEALTH, A2
    
    ; Load boss health into A3
    LEA     BOSS_HEALTH, A4
    
    ; Load player health into A3
    LEA     PLAYER_POINTS, A3
       
    ; Load player position into data registers
    MOVE.B  PLAYER_POSITION, D1

    ; Load boss position into data registers
    MOVE.B  BOSS_POSITION, D2
    
    ; Branch into main gameplay
    BRA     MAIN_GAMEPLAY
    
MAIN_GAMEPLAY:
    ; Start the gameplay
    ; Move player
    AND.B   D1, D2
    ; Branch to taking damage
    BSR     TAKING_DAMAGE
    ; Branch to deal damage
    BSR    DEAL_DAMAGE
    ; End the game
    
    ; Branch to game over
    BRA     GAME_OVER
    
TAKING_DAMAGE:
    SUB.B   #20, (A1)       ; Boss attacks player
    RTS     
    
DEAL_DAMAGE:
    ; Player attacks Boss
    SUB.B   #10, (A3)
    BSR     GAIN_POINTS
    RTS
    
REGEN_HEALTH:
    ; Give the player some health back
    ADD.B   #50, (A1)
    RTS
    
GAIN_POINTS:
    ; Give the player points
    ADD.B   #100, (A2)
    RTS
    
GAME_OVER:
    ;End game and display a message
    LEA     GAME_OVER_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    
    MOVE.B  #11, D0
    TRAP    #15
    
    LEA     YOU_DIED_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
 
    
    SIMHALT             

PLAYER_HEALTH DC.B $64
PLAYER_POINTS DC.B $0
BOSS_HEALTH DC.B $64
BOSS_POSITION DC.B $22
PLAYER_POSITION DC.B $14

    END    START        


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
