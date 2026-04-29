# x86_64 Assembly Port

Conversion of a 68000 assembly program to x86_64.
The program asks the user to enter two numbers three times, adds each pair, and displays a running total.

---

## Files

| File | Description |
|---|---|
| `adder.asm` | x86_64 assembly - all functions and main loop |
| `main.c` | Entry point - calls `run_program()` in assembly |
| `test_runner.c` | C test file using assert.h |
| `Makefile` | Build instructions |

---

## How to Build and Run

```bash
# Build
make

# Run
make run

# Run tests
make test

# Clean
make clean
```

---

## Significant Changes

| 68k | x86_64 |
|---|---|
| `TRAP #15` task 4 for input | `sys_read` + `string_to_int` to convert raw text to integer |
| `TRAP #15` task 3 for output | `sys_write` + `print_number` to convert integer back to text |
| Parameters in D1, D2 | Parameters in `rdi`, `rsi` (System V ABI) |
| Result in D1 | Result in `rax` |
| Running sum in D3 | Running sum in memory (`running_sum`) |
| Loop counter in D4 | Loop counter in `r15` |
| `BSR` / `RTS` | `call` / `ret` with `push rbp` / `pop rbp` |
| `SIMHALT` | `sys_exit` syscall |

---

## Security Fixes

The original 68k version had no input validation, allowing integer overflow (visible in the Sim68K output as `Final sum: -720957404`).

- **Input validation** - `string_to_int` rejects numbers over 99999
- **Overflow detection** - `register_adder` checks the overflow flag after addition and resets to 0 if triggered
- **Stack handling** - all functions use proper `push rbp` / `pop rbp` frame setup to prevent stack corruption
- **Safe I/O** - `read_line` reads one byte at a time to prevent over-reading input buffers

---

## Test Plan

| Test | What it checks |
|---|---|
| `test_register_adder` | Basic addition, zero, negatives, large values |
| `test_running_sum` | Accumulation across multiple adds, reset to zero |
| `test_full_loop_simulation` | Full 3-iteration loop matches expected running sum |
| `test_negative_numbers` | Negative inputs handled correctly |
| `test_security_bounds` | Overflow returns 0, max safe values work correctly |