#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dothestuff(char[2500], char[2500], int count);
int dothestuff2(char[2500], char[2500], int count);

int main()
{
    // allocate a static int array that is the same size as the args array
    char x[2500];
    char y[2500];
    char *buffer;
    size_t bufsize = 32;
    size_t characters;
    // create an array of char pointers
    char **args = malloc(2249 * sizeof(char *));
    int i = 0;

    buffer = (char *)malloc(bufsize * sizeof(char));

    for (int j = 0; j < 2500; j++)
    {
        characters = getline(&buffer, &bufsize, stdin);
        x[j] = buffer[0];
        y[j] = buffer[2];
    }

    // printf("answer: %d\n", dothestuff(x, y, 2500));
    printf("answer: %d\n", dothestuff2(x, y, 2500));

    return 0;
}
