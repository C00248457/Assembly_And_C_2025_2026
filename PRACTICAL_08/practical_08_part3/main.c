#include "stdio.h" // Standard IO header file

// Mainline
int main()
{
    int a;

    //Call to printf function a is substituted for %d
    printf("Value of a is %d\n",a);

    //Scope
    {
        a = 30;
        printf("Value of a is %d\n", a);
    }

    //Scope
    {
        a = 300;
        printf("Value of a is %d\n",a);
    }

    printf("Value of a is %d\n",a);
    return 0;
}