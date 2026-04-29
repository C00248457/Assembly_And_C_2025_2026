Conversion of a 68k assembly project to x86 64 bit. The user enters two numbers, the program adds them and then displays the total. This is repeated twice more.

TRAP #15 was used in 68k which hands number directly to a register. sys_read in x86 gives raw text so string_to_int was written to convert it. Parameters pass in rdi and rsi instead of D1 and D2. The running sum is stored in memory instead of a register as it needs to exist across all function calls.

The 68k file had no input validation. string_to_int rejects numbers over 99999. register_adder checks the overflow flag after addition and resets to 0 when triggered. push and pop are used to keep the stack balanced