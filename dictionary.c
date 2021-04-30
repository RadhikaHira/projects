// Implements a dictionary's functionality
#include <cs50.h>
#include <stdbool.h>
#include <stdio.h>
#include "dictionary.h"
#include <strings.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// Number of buckets in hash table
const unsigned int N = 26;

//positive hash value
unsigned int value;

//word count from has table
unsigned int counter;

// Hash table
node *table[N];

// Returns true if word is in dictionary else false
bool check(const char *word)
{
    // TODO
    //hashing word for value
    value = hash(word);
    
    //get the linked list
    node *point = table[value];
    
    //go through linked list
    while (point != NULL)
    {
        //check word matching
        if(strcasecmp(word, point->word) == 0)
        {
            return true;
        }
        //move to next node
        point = point->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO
    unsigned long h = 5381;
    int c;
    while ((c = toupper(*word++)))
    {
        h = ((h << 5) + h) + c;
    }
    return h % N;
}

// Loads dictionary into memory, returning true if successful else false
bool load(const char *dictionary)
{
    // TODO
    //open dictionary
    FILE *f = fopen(dictionary, "r");
    
    //file not opened then return false
    if (f == NULL)
    {
        return false;
    }
    
    //storing space for word
    char word[LENGTH + 1];
    //scan for strings notat the end of file
    while (fscanf(f, "%s", word)!= EOF)
    {
        //allocate memory
        node *n = malloc(sizeof(node));
        //if NULL, return false
        if (n == NULL)
        {
            return false;
        }
        
        //point to next node and word it
        strcpy(n->word, word);
        value = hash(word);
        n->next = table[value];
        table[value] = n;
        counter++;
        
    }
    fclose(f);
    
    return true;
}

// Returns number of words in dictionary if loaded else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    
    //check for words and return count 
    if (counter > 0)
    {
        return counter;
    }
    else
    {
        return 0;
    }
}

// Unloads dictionary from memory, returning true if successful else false
bool unload(void)
{
    // TODO
    for (int i = 0; i < N; i++)
    {
        node *point = table[i];
        
        while (point)
        {
            node *temp = point;
            
            point = point->next;
            
            free(temp);
        }
        
        if (i == (N - 1) && point == NULL)
        {
            return true;
        }
    }
    return false;
}
