#include <cs50.h>
#include <stdio.h>
#include <math.h>

//Ask user for how much is owed
//Use largest coins for change
//Print number of coins needed

int number(int change);

int main(void)
{
    float owe;
    //int coins = 0;
    
    //Ask owe amount from the user and make sure it is not negative
    do
    {
        owe = get_float("How much change do I owe you?: ");
    }
    while (owe < 0);
    
    //If input is dollars, convert to cents
    int c = round(owe * 100);
    
    //keep track of coins used and remaining change
    c = number(c);
    
    //Print the number of coins needed for the 
    printf("%i coins needed\n", c);
}

int number(int change)
{
    //keep track of coins used and remaining change
    int coins = 0;
    
    while (change > 0)
    {
        if (change >= 25)
        {
            change = change - 25;
            coins++;
        }
        else if (change >= 10)
        {
            change = change - 10;
            coins++;
        }
        else if (change >= 5)
        {
            change = change - 5;
            coins++;
        }
        else
        {
            change = change - 1;
            coins = coins + 1;
        }
    }
    return coins;
}