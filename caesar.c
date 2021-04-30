#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc, string argv[])
{
    int i;

    //check to make sure the key is only non-negative number
    if (argc == 2 && isdigit(*argv[1]))
    {
        //convert string key to integers
        int key = atoi(argv[1]);

        //ask for plain text
        string plaintext = get_string("plaintext: ");

        //length of text
        int length = strlen(plaintext);

        //output cipher code
        printf("ciphertext: ");

        //go through text to cipher it
        for (i = 0; i < length; i++)
        {
            //check for lowercase letters
            if (plaintext[i] >= 'a' && plaintext[i] <= 'z')
            {
                //print lowercase letters
                printf("%c", (((plaintext[i] - 'a') + key) % 26) + 'a');
            }
            //check for uppercase letters
            else if (plaintext[i] >= 'A' && plaintext[i] <= 'Z')
            {
                //print uppercase letters
                printf("%c", (((plaintext[i] - 'A') + key)  % 26) + 'A');
            }
            else
            {
                printf("%c", plaintext[i]);
            }
        }
        printf("\n");
        return 0;
    }

    else
    {
        printf("Usage: %s key \n", argv[0]);
        return 1;
    }
}