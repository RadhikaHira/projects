#include <stdio.h>
#include <stdlib.h>

//open memory card and look at jpeg 

int main(int argc, char *argv[])
{
    
    //except only 1 command line argument for image
    if (argc != 2)
    {
        //remind user of correct usage
        printf("Usage: %s image \n", argv[0]);
        return 1;
    }
    //file doesnt exist
    FILE *input = fopen(argv[1], "r");
    if (input == NULL)
    {
        printf("Could not open %s \n", argv[1]);
        return 1;
    }
    
    //file for picture
    FILE *output = NULL;
    
    //creating buffer
    unsigned char buff[512];
    char file[8];
    
    //initialize and keep track of images in file
    int counter = 0;
    
    //initialize for image already found
    int found = 0;
    
    //read file
    while (fread(buff, 512, 1, input) == 1)
    {
        //sarting new jpeg 
        if (buff[0] == 0xff && buff[1] == 0xd8 && buff[2] == 0xff && (buff[3] & 0xf0) == 0xe0)
        {
            //new files
            //if image is already found
            if (found == 1)
            {
                fclose(output);
            }
            
            //createing/write new file for first jpeg
            else
            {
                found = 1;
            }
            
            sprintf(file, "%03i.jpg", counter);
            output = fopen(file, "w");
            counter++; 
        }
        //when new jpegs are found
        if (found == 1)
        {
            fwrite(&buff, 512, 1, output);
        }
            
    }
    //close files
    fclose(output);
    fclose(input);
    
    return 0;
}
