#include <cs50.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

//takes user's text
//evaluate reading level
//output what grade the sentence(s) would be in

//Other function
void getgrade(float l, float w, float s);

//Main function
int main(void)
{

    float l = 0;
    float w = 1;
    float s = 0;

    //input text and get length
    string text = get_string("Text: ");
    float letters = strlen(text);

    //ASCII codes  to check for upper and lower case letters in text
    for (int i = 0; i < letters; i++)
    {
        if ((text [i] >= 'a' && text[i] <= 'z') || (text[i] >= 'A' && text[i] <= 'Z'))
        {
            l++;
        }

    }
    printf("%i letter(s).\n", (int) l);

    //Loop to count for words by finding the spaces
    for (int i = 0; i < letters; i++)
    {
        if (text[i] == ' ')
        {
            w++;
        }
    }
    printf("%i word(s).\n", (int) w);

    //Loop to count for sentences
    //Searches for dots, question and exclamation marks
    for (int i = 0; i < letters; i++)
    {
        if (text[i] == '.' || text[i] == '!' || text[i] == '?')
        {
            s++;
        }

    }
    printf("%i sentence(s)\n", (int) s);

    //call function for grade
    getgrade(l, w, s);

}

void getgrade(float l, float w, float s)
{
    //calculate average for letters and sentence for 100 words
    float L = (l / w) * 100;
    float S = (s / w) * 100;

    //degin to output the US grade level for the text
    int grade = round(0.0588 * L - 0.296 * S - 15.8);

    //If grade greater than 16 or less than 1
    if (grade < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (grade >= 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", grade);
    }
}
