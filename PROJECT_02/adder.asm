; Title        : Parameter Passing Example - x86_64 Port
; Original     : Philip Bourke (68000 version, March-25-2025)
; Ported by    : Rachel
; Description  : Demonstrates passing parameters using registers
;                and the stack, performing arithmetic operations,
;                and running a loop to keep a running sum.
;                Security fixes applied:
;                  - Input validation added (bounds checking)
;                  - Overflow protection via bounded input range
;                  - Stack alignment maintained per System V ABI

; GLOBALS - exported so main.c and test_runner.c can call functions
global run_program
global register_adder
global string_to_int
global print_number
global add_to_sum
global get_sum
global clear_sum

; Use RIP-relative addressing by default (required for PIE / position-independent code)
default rel

; DATA SECTION
section .data
    msg_prompt_one  db "Enter first number: ", 0
    msg_prompt_two  db "Enter second number: ", 0
    msg_result      db "The sum is: ", 0
    msg_final       db "Final sum is: ", 0
    msg_newline     db 10
    msg_too_large   db "Number too large! Max is 99999", 10, 0
    msg_overflow    db "Overflow detected! Result reset to 0", 10, 0

; BSS SECTION - uninitialised variables
section .bss
    user_input  resb 20             ; Buffer for raw keyboard input
    buffer      resb 20             ; Buffer for number to string conversion
    running_sum resq 1              ; Running sum (64-bit)

; TEXT SECTION
section .text

; run_program
; Purpose : Main loop - equivalent to 68k START / GAME_LOOP
;           Called from main.c to start the program
;           Initialises running sum and loop counter, runs 3 iterations
run_program:
    push rbp
    mov  rbp, rsp

    mov  qword [running_sum], 0     ; Clear running sum - equivalent to CLR.L D3
    mov  r15, 3                     ; Loop counter = 3 - equivalent to MOVE.W #3, D4

game_loop:
    ; Display first prompt - equivalent to 68k LEA PROMPT / TRAP #15
    mov  rdi, msg_prompt_one
    call print_string

    ; Read first number one byte at a time to avoid pipe buffering issues
    lea  rdi, [user_input]
    call read_line

    ; Convert string to integer - store first number in r12
    lea  rsi, [user_input]
    call string_to_int
    mov  r12, rax                   ; r12 = first number

    ; Display second prompt
    mov  rdi, msg_prompt_two
    call print_string

    ; Read second number
    lea  rdi, [user_input]
    call read_line

    ; Convert string to integer - store second number in r13
    lea  rsi, [user_input]
    call string_to_int
    mov  r13, rax                   ; r13 = second number

    ; Call register_adder - equivalent to 68k BSR REGISTER_ADDER
    mov  rdi, r12                   ; param 1 = first number
    mov  rsi, r13                   ; param 2 = second number
    call register_adder
    mov  r14, rax                   ; r14 = iteration result

    ; Add result to running sum - equivalent to 68k ADD.L D1, D3
    add  qword [running_sum], r14

    ; Display result string - equivalent to 68k LEA RESULT / TRAP #15
    mov  rdi, msg_result
    call print_string

    ; Print the iteration sum
    mov  rdi, r14
    call print_number

    ; Print newline - equivalent to 68k BSR NEW_LINE
    mov  rax, 1
    mov  rdi, 1
    lea  rsi, [msg_newline]
    mov  rdx, 1
    syscall

    ; Decrement loop counter - equivalent to 68k SUBQ.W #1, D4 / BNE GAME_LOOP
    dec  r15
    jnz  game_loop

    ; Display final sum - equivalent to 68k LEA FINAL_RESULT / TRAP #15
    mov  rdi, msg_final
    call print_string

    mov  rdi, [running_sum]
    call print_number

    ; Print newline
    mov  rax, 1
    mov  rdi, 1
    lea  rsi, [msg_newline]
    mov  rdx, 1
    syscall

    pop  rbp
    ret                             ; Return to main.c

; read_line
; Purpose : Reads one line of input one byte at a time until newline or max 19 chars
;           Reading byte by byte avoids pipe buffering consuming more than one line
; Input   : rdi = address of buffer to read into
; Output  : buffer filled, null terminated
read_line:
    push rbp
    mov  rbp, rsp
    push rbx
    push r9

    mov  rbx, rdi                   ; buffer pointer
    xor  r9,  r9                    ; byte counter

.byte_loop:
    mov  rax, 0                     ; syscall: sys_read
    mov  rdi, 0                     ; stdin
    mov  rsi, rbx                   ; current buffer position
    mov  rdx, 1                     ; read exactly 1 byte
    syscall

    cmp  rax, 0                     ; EOF check
    je   .done

    mov  al, [rbx]                  ; load byte we just read
    cmp  al, 10                     ; newline?
    je   .done

    inc  rbx                        ; advance buffer
    inc  r9                         ; increment count
    cmp  r9, 19                     ; max length check
    jl   .byte_loop

.done:
    mov  byte [rbx], 0              ; null terminate

    pop  r9
    pop  rbx
    pop  rbp
    ret

; print_string
; Purpose : Prints a null-terminated string
; Input   : rdi = address of string
; Output  : none
print_string:
    push rbp
    mov  rbp, rsp
    push rbx
    push rcx

    mov  rbx, rdi                   ; save string address
    xor  rcx, rcx                   ; length counter = 0

.count_loop:
    cmp  byte [rbx + rcx], 0        ; check for null terminator
    je   .print
    inc  rcx
    jmp  .count_loop

.print:
    mov  rax, 1                     ; syscall: sys_write
    mov  rdi, 1                     ; stdout
    mov  rsi, rbx                   ; string address
    mov  rdx, rcx                   ; length
    syscall

    pop  rcx
    pop  rbx
    pop  rbp
    ret

; register_adder
; Purpose : Adds two numbers passed as parameters
;           Equivalent to 68k REGISTER_ADDER subroutine (ADD.L D2, D1)
; Input   : rdi = first number, rsi = second number
; Output  : rax = result, or 0 if overflow detected
register_adder:
    push rbp
    mov  rbp, rsp
    sub  rsp, 8                     ; align stack to 16 bytes

    mov  rax, rdi                   ; first number into rax
    add  rax, rsi                   ; add second number - equivalent to ADD.L D2, D1
    jo   .overflow                  ; jump if overflow flag set

    add  rsp, 8
    pop  rbp
    ret

.overflow:
    mov  rdi, msg_overflow
    call print_string

    add  rsp, 8
    xor  rax, rax                   ; return 0
    pop  rbp
    ret

; string_to_int
; Purpose : Converts a string of digits to an integer, handles negatives
;           Security fix - rejects numbers larger than 99999
; Input   : rsi = address of string
; Output  : rax = integer value
string_to_int:
    push rbp
    mov  rbp, rsp
    push rbx
    push r9

    xor  rax, rax                   ; result = 0
    xor  r9,  r9                    ; r9 = negative flag (0 = positive)

    ; Check for negative sign
    cmp  byte [rsi], '-'
    jne  .next_digit
    mov  r9, 1                      ; set negative flag
    inc  rsi                        ; skip the '-' character

.next_digit:
    movzx rbx, byte [rsi]           ; load next character
    cmp  rbx, 10                    ; newline?
    je   .done
    cmp  rbx, 0                     ; null terminator?
    je   .done

    ; Bounds check - reject numbers over 99999
    cmp  rax, 99999
    jg   .too_large

    sub  rbx, '0'                   ; convert ASCII digit to integer
    imul rax, 10                    ; shift result left one decimal place
    add  rax, rbx                   ; add new digit
    inc  rsi
    jmp  .next_digit

.too_large:
    mov  rdi, msg_too_large
    call print_string

    ; Re-read input
    lea  rdi, [user_input]
    call read_line

    xor  rax, rax
    pop  r9
    pop  rbx
    pop  rbp
    ret

.done:
    test r9, r9
    jz   .positive
    neg  rax

.positive:
    pop  r9
    pop  rbx
    pop  rbp
    ret

; print_number
; Purpose : Converts an integer to string and prints it, handles negatives
; Input   : rdi = integer to print
; Output  : none
print_number:
    push rbp
    mov  rbp, rsp
    push rbx
    push r9

    xor  r9,  r9                    ; negative flag
    mov  rax, rdi                   ; number to convert
    lea  rsi, [buffer + 19]         ; start at end of buffer
    mov  byte [rsi], 0              ; null terminator
    mov  rbx, 10                    ; divisor

    test rax, rax
    jns  .convert
    mov  r9, 1                      ; set negative flag
    neg  rax                        ; make positive for extraction

.convert:
    xor  rdx, rdx                   ; clear for division
    div  rbx                        ; rax = quotient, rdx = remainder
    add  rdx, '0'                   ; remainder to ASCII
    dec  rsi
    mov  [rsi], dl                  ; store digit
    test rax, rax
    jnz  .convert

    test r9, r9
    jz   .print
    dec  rsi
    mov  byte [rsi], '-'

.print:
    lea  rdx, [buffer + 19]
    sub  rdx, rsi                   ; length = end - current position
    mov  rax, 1                     ; syscall: sys_write
    mov  rdi, 1                     ; stdout
    syscall

    pop  r9
    pop  rbx
    pop  rbp
    ret

; add_to_sum
; Purpose : Adds a value to the global running sum
;           Equivalent to 68k: ADD.L D1, D3
; Input   : rdi = value to add
; Output  : rax = new running sum
add_to_sum:
    push rbp
    mov  rbp, rsp

    add  qword [running_sum], rdi
    mov  rax, [running_sum]

    pop  rbp
    ret

; get_sum
; Purpose : Returns the current running sum
; Input   : none
; Output  : rax = current running sum
get_sum:
    push rbp
    mov  rbp, rsp

    mov  rax, [running_sum]

    pop  rbp
    ret

; clear_sum
; Purpose : Resets the running sum to zero
;           Equivalent to 68k: CLR.L D3
; Input   : none
; Output  : none
clear_sum:
    push rbp
    mov  rbp, rsp

    mov  qword [running_sum], 0

    pop  rbp
    ret

; Mark stack as non-executable (suppresses linker warning)
section .note.GNU-stack noalloc noexec nowrite progbits