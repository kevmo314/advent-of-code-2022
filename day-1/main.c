#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dothestuff(long int args[2250], int count, long int out[3]);

int main()
{
    // allocate a static int array that is the same size as the args array
    long int intargs[2250];
    long int outbuf[3];
    char *buffer;
    size_t bufsize = 32;
    size_t characters;
    // create an array of char pointers
    char **args = malloc(2249 * sizeof(char *));
    int i = 0;

    buffer = (char *)malloc(bufsize * sizeof(char));

    for (int j = 0; j < 2249; j++)
    {
        characters = getline(&buffer, &bufsize, stdin);
        args[i] = malloc(characters * sizeof(char));
        // memcpy from the buffer into args[i]
        memcpy(args[i], buffer, characters + 1);
        i++;
    }

    // print out each of the lines
    for (int j = 0; j < 2249; j++)
    {
        intargs[j] = atoi(args[j]);
    }

    dothestuff(intargs, 2250, outbuf);
    printf("answer: %ld %ld %ld\n", outbuf[0], outbuf[1], outbuf[2]);

    return 0;
}
