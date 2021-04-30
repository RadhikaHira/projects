#include <stdio.h>
#include <cs50.h>
//Create Mario pyramid while asking the user for the height 

int main(void)
{
    //intitialize h for height
    int h;
    //make a do-while loop for getting a height value only between 1-8
    do
    {
        h = get_int("What is the pyramid height: ");
    }
    while (h < 1 || h > 8);
    
    //creating rows(x)
    for (int x = 0; x < h; x++)
    {
        //printing out spaces and #'s in these rows

        for (int space = (h - x); space >= 2; space--)
        {
            printf(" ");
               
        }
        //Create hashes for pyramid
        for (int hash = 1; hash <= x + 1; hash++)
        {
            printf("#");
        }
            
        printf("\n");
    }
}
