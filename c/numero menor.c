#include <stdio.h>

int num;

int main()
{
    printf("Ingresa un numero menor a 60: ");
    scanf("%d",&num);

int res = num-60;

    if  (res < 0) printf("Es menor a 60 ");
    else        printf("Es mayor a 60");

    return 0;
}