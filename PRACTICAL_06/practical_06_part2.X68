*-----------------------------------------------------------
* Title      : Practical 6 Part 1
* Written by : Rachel O Shea
* Date       : 25/02/2026
* Description: Utilise conditional branches and control stuctures
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
*--------------------------0--------------------------------
    ; Move trap task to D0
    MOVE.B  #0, D0
    ; Load message to register before trap call
    LEA MESSAGE, A1
    ; Specify length of string
    MOVE.W  #16, D1
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------1-------------------------------
    ; Move trap task to D0
    MOVE.B  #1, D0
    ; Load message to register before trap call
    LEA MESSAGE_1, A1
    ; Specify length of string
    MOVE.W  #16, D1
    ; Interrupt and task task
    TRAP    #15
    
*--------------------------2-------------------------------
    ; Move trap task to D0
    MOVE.B #2, D0
    ; Load INPUT address to A1
    LEA INPUT_2, A1
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------3-------------------------------
    ; Move trap task to D0
    MOVE.B  #3, D0
    ; Move number to be displayed into D1
    MOVE.L  #7, D1
    ; Interrupt and trap task
    TRAP    #15

*--------------------------4-------------------------------
    ; Move trap task to D0
    MOVE.B  #4, D0
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------5-------------------------------
    ; Move trap task to D0
    MOVE.B  #5, D0
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------6-------------------------------
    ; Move trap task to D0
    MOVE.B  #6, D0
    ; Interrupt and trap task
    TRAP    #15    
    
*--------------------------7-------------------------------
    ; Move trap task to D0
    MOVE.B  #7, D0
    ; Interrupt and trap task
    TRAP    #15   
    ; Compare number to 1
    CMP.B   #1, D1
    ; If equal, branch to yes subroutine
    BEQ     YES
    
    ; If not equal, automatically branches to no subroutine
    
NO: ; Key is not pending
    SIMHALT             ; halt simulator
           
YES:    ; Move trap task to D0
        MOVE.B #5, D0
        ; Interrupt and trap task
        TRAP #15
    SIMHALT             ; halt simulator
    
*--------------------------8-------------------------------
    ; Move trap task to D0
    MOVE.B  #8, D0
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------9-------------------------------
    ; Move trap task to D0
    MOVE.B  #9, D0
    ; Interrupt and trap task
    TRAP    #15
    
*-------------------------11-------------------------------
    ; Move trap task to D0
    MOVE.B  #11, D0
    ; Load column (high byte) and row (low byte) into D1, use hex to
    ; do this as it makes clear to processor which is high and which
    ; is low byte
    MOVE.W  #$1411, D1
    ; Interrupt and trap task
    TRAP    #15
    
    ; Testing by printing a message at that location
    
    ; Load message into address register A1
    LEA MESSAGE_11, A1
    ; Move trap task to D0
    MOVE.B  #13, D0
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------12------------------------------- 
    ; Move trap task to D0
    MOVE.B  #12, D0
    ; Turn echo off by loading zero value into D1
    MOVE.B  #0, D1
    ; Interrupt and trap task
    TRAP    #15  
    
    ; Test by allowing input
    MOVE.B  #2, D0
    LEA MESSAGE_12, A1
    TRAP    #15    
    
*--------------------------13-------------------------------
    ; Move trap task to D0
    MOVE.B  #13, D0
    ; Load message to address register 1
    LEA MESSAGE_13, A1
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------14-------------------------------
    ; Move trap task to D0
    MOVE.B  #14, D0
    ; Load message to address register 1
    LEA MESSAGE_14, A1
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------16-------------------------------
    ; Move trap task to D0
    MOVE.B  #16, D0
    ; Set a value to turn off the display at the input prompt
    ; i.e. won't see cursor prompting for input
    MOVE.B  #0, D1
    ; Interrupt and trap task
    TRAP    #15
    
    ; Move trap task to D0
    MOVE.B  #16, D0
    ; Set a value to not display line feed when enter pressed
    MOVE.B  #2, D1
    ; Interrupt and trap task
    TRAP    #15
    
   ; Test by allowing input
    MOVE.B  #2, D0
    LEA MESSAGE_16, A1
    TRAP    #15 
    
*--------------------------17-------------------------------
    ; Move trap task to D0
    MOVE.B  #17, D0
    ; Move a number to D1
    MOVE.B  #4, D1
    ; Move string into address register
    LEA MESSAGE_17, A1
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------18-------------------------------
    ; Move trap task to D0
    MOVE.B  #18, D0
    ; Move string into address register
    LEA MESSAGE_18, A1
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------19-------------------------------
    ; Move trap task to D0
    MOVE.B  #19, D0
    ; Load 4 key codes into D1.L (A, B, C, D)
    ; A=$61, B=$62, C=$63, D=$64
    MOVE.L  #$61626364, D1
    ; Interrupt and trap task
    TRAP    #15
    ; D1.L now contains $FF or $00 for each key
    
    ; Move trap task to D0
    MOVE.B  #19, D0
    ; Clear D1.L to use mode 2 (get last key pressed)
    MOVE.L  #$00000000, D1
    ; Interrupt and trap task
    TRAP    #15
    ; D1.B now contains scan code of last key pressed

*--------------------------20-------------------------------
    ; Move trap task to D0
    MOVE.B  #20, D0
    ; Move number to be displayed into D1
    MOVE.L  #30, D1
    ; Move number to display column width into D2
    MOVE.B  #10, D2
    ; Interrupt and trap task
    TRAP    #15
    
*--------------------------21-------------------------------
    ; Move trap task to D0
    MOVE.B  #21, D0
    ; Move colour number into D1
    MOVE.L  #$00903070, D1
    ; Move style type into D2
    MOVE.B  $3, D2
    ; Interrupt and trap task
    TRAP    #15  
    ; Load message into address register A1
    LEA MESSAGE_21, A1
    MOVE.B  #13, D0
    ; Interrupt and trap task
    TRAP    #15  

*--------------------------22------------------------------- 
    ; Move trap task to D0
    MOVE.B  #11, D0
    ; Column 10, row 5 into D1
    MOVE.W  #$0A05, D1      
    ; Interrupt and trap task
    TRAP    #15
    
    ; Load message into address register
    LEA     MESSAGE_22, A1
    ; Move trap task to D0
    MOVE.B  #13, D0
    ; Interrupt and trap task
    TRAP    #15
    
    ; Now read the character at row 5, column 10
    MOVE.B  #22, D0
    ; Row 5 in high 16, column 10 in low 16
    MOVE.L  #$00050000A, D1  
    TRAP    #15
    ; D1.B now contains ASCII code of character at that position     
    
    SIMHALT

MESSAGE:    DC.W 'Trap Task Test 0'
MESSAGE_1:  DC.W 'Trap Task Test 1'
INPUT_2:    DS.W 80     ; define storage to max of 80 as defined in spec
MESSAGE_11: DC.B 'Hello!',0 
MESSAGE_12: DS.B 80
MESSAGE_13: DC.W 'Trap Task Test 13',0
MESSAGE_14: DC.W 'Trap Task Test 14',0
MESSAGE_16: DS.B 80
MESSAGE_17: DC.B 'Trap Task Test 17',0
MESSAGE_18: DC.B 'Trap Task Test 18',0
MESSAGE_21: DC.B 'Trap Task Test 21',0
MESSAGE_22: DC.B 'Test',0

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
