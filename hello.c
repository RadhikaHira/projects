#include <stdio.h>
#include <cs50.h>

//main code
int main(void)
{
    //get name of the person, add it to variable name and print it
    string name = get_string("What is your name?\n");
    printf("Hello, %s!\n", name);
}