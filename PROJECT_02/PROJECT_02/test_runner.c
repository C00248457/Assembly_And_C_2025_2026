/*
 * Title       : Test Runner for x86_64 Assembly Port
 * Description : Tests the assembly functions
 */

#include <stdio.h>

/* Assembly function declarations */
extern long register_adder(long a, long b);
extern long add_to_sum(long value);
extern long get_sum(void);
extern void clear_sum(void);

int tests_passed = 0;
int tests_failed = 0;

void check(char *label, long actual, long expected)
{
    if (actual == expected)
    {
        printf("PASS - %s = %ld\n", label, actual);
        tests_passed++;
    }
    else
    {
        printf("FAIL - %s got %ld, expected %ld\n", label, actual, expected);
        tests_failed++;
    }
}

void test_register_adder(void)
{
    printf("\nTesting register_adder\n");
    check("register_adder(2, 3)",      register_adder(2, 3),      5);
    check("register_adder(0, 0)",      register_adder(0, 0),      0);
    check("register_adder(10, 20)",    register_adder(10, 20),    30);
    check("register_adder(-5, 5)",     register_adder(-5, 5),     0);
    check("register_adder(-3, -7)",    register_adder(-3, -7),    -10);
    check("register_adder(99999, 1)",  register_adder(99999, 1),  100000);
}

void test_running_sum(void)
{
    printf("\nTesting running sum\n");
    clear_sum();
    check("clear_sum gives 0",        get_sum(),   0);
    add_to_sum(10);
    check("add_to_sum(10) gives 10",  get_sum(),   10);
    add_to_sum(20);
    check("add_to_sum(20) gives 30",  get_sum(),   30);
    add_to_sum(5);
    check("add_to_sum(5) gives 35",   get_sum(),   35);
    clear_sum();
    check("clear_sum resets to 0",    get_sum(),   0);
}

void test_full_loop_simulation(void)
{
    printf("\nTesting full 3 iteration loop\n");

    long iter_sum;
    int loop_counter = 3;

    clear_sum();

    iter_sum = register_adder(10, 5);
    add_to_sum(iter_sum);
    printf("Iteration 1: 10 + 5 = %ld, running sum = %ld\n", iter_sum, get_sum());
    check("iteration 1 sum",           iter_sum,   15);
    check("running sum after iter 1",  get_sum(),  15);
    loop_counter--;

    iter_sum = register_adder(20, 10);
    add_to_sum(iter_sum);
    printf("Iteration 2: 20 + 10 = %ld, running sum = %ld\n", iter_sum, get_sum());
    check("iteration 2 sum",           iter_sum,   30);
    check("running sum after iter 2",  get_sum(),  45);
    loop_counter--;

    iter_sum = register_adder(100, 50);
    add_to_sum(iter_sum);
    printf("Iteration 3: 100 + 50 = %ld, running sum = %ld\n", iter_sum, get_sum());
    check("iteration 3 sum",           iter_sum,   150);
    check("running sum after iter 3",  get_sum(),  195);
    loop_counter--;

    check("loop counter reaches 0",    loop_counter, 0);
}

void test_negative_numbers(void)
{
    printf("\nTesting negative numbers\n");
    check("register_adder(-10, 5)",       register_adder(-10, 5),       -5);
    check("register_adder(-10, -5)",      register_adder(-10, -5),      -15);
    check("register_adder(-99999, 99999)", register_adder(-99999, 99999), 0);
}

void test_security_bounds(void)
{
    printf("\nTesting overflow detection\n");
    printf("The 68k version had no bounds checking causing overflow e.g. Final sum: -720957404\n");
    check("register_adder(99999, 99999)",    register_adder(99999, 99999),           199998);
    check("overflow resets to 0",            register_adder(9223372036854775807L, 1), 0);
}

int main(void)
{
    printf("Test Runner - x86_64 Assembly Port\n");

    test_register_adder();
    test_running_sum();
    test_full_loop_simulation();
    test_negative_numbers();
    test_security_bounds();

    printf("\n%d passed, %d failed\n", tests_passed, tests_failed);

    return tests_failed;
}