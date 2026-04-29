/*
 * Title       : Parameter Passing Example - x86_64 Port
 * Description : Entry point - calls the assembly run_program function
 */

#include <stdio.h>

extern void run_program(void);

int main(void)
{
    run_program();
    return 0;
}