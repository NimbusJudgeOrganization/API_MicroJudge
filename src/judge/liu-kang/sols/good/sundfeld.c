#include <stdio.h>
#include <math.h>

int main()
{
    long int t, golpes;

    scanf("%ld %ld", &t, &golpes);
    t = sqrt(t);
    if (t % 2 == 0)
        t /= 2;

    for (long int i = 0; i < golpes; ++i)
    {
        t = 2 * t - 1;
        printf("%ld\n", t * t);
    }
    return 0;
}
