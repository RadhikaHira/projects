#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    //go through each column
    for (int i = 0; i < height; i++)
    {
        //go through the rows in each column
        for (int j = 0; j < width; j++)
        {
            //get colour values
            float r = image[i][j].rgbtRed;
            float b = image[i][j].rgbtBlue;
            float g = image[i][j].rgbtGreen;

            //calculate average values and round value
            int average = round((r + b + g) / 3);

            //set average calculated as new value for all
            image[i][j].rgbtRed = image[i][j].rgbtBlue = image[i][j].rgbtGreen = average;
        }
    }
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    //go through each column
    for (int i = 0; i < height; i++)
    {
        //go through the rows in each column
        for (int j = 0; j < width; j++)
        {
            //get colour values
            float r = image[i][j].rgbtRed;
            float b = image[i][j].rgbtBlue;
            float g = image[i][j].rgbtGreen;

            //sepia values
            int sepia_r = round(0.393 * r + 0.769 * g + 0.189 * b);
            int sepia_b = round(0.272 * r + 0.534 * g + 0.131 * b);
            int sepia_g = round(0.349 * r + 0.686 * g + 0.168 * b);

            //for sepia red
            if (sepia_r > 255)
            {
                image[i][j].rgbtRed = 255;
            }
            else
            {
                image[i][j].rgbtRed = sepia_r;
            }

            //for sepia blue
            if (sepia_b > 255)
            {
                image[i][j].rgbtBlue = 255;
            }
            else
            {
                image[i][j].rgbtBlue = sepia_b;
            }

            //for sepia green
            if (sepia_g > 255)
            {
                image[i][j].rgbtGreen = 255;
            }
            else
            {
                image[i][j].rgbtGreen = sepia_g;
            }
        }
    }

}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{

    //go through each column
    for (int i = 0; i < height; i++)
    {
        //go through the rows in each column to find middle point
        for (int j = 0; j < (width / 2); j++)
        {
            //make temporary variable in the struct
            RGBTRIPLE temp = image[i][j];

            //switch right half with left (horizontal)
            image[i][j] = image[i][width - (j + 1)];
            image[i][width - (j + 1)] = temp;
        }
    }
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    //make temporary
    RGBTRIPLE copy[height][width];
    double red, blue, green;
    int stat;
    int blurry = 3;

    //go through each column
    for (int i = 0; i < height; i++)
    {
        //go through the rows in each column
        for (int j = 0; j < width; j++)
        {
            red = blue = green = stat = 0;
            for (int r = i - ((blurry - 1) / 2); r <= i + ((blurry - 1) / 2); r++)
            {
                for (int c = j - ((blurry - 1) / 2); c <= j + ((blurry - 1) / 2); c++)
                {
                    if ((r >= 0 && r < height) && (c >= 0 && c < width))
                    {
                        red = red + image[r][c].rgbtRed;
                        blue = blue + image[r][c].rgbtBlue;
                        green = green + image[r][c].rgbtGreen;
                        stat++;
                    }
                }
            }
            if (stat != 0)
            {
                blue = round(blue / (double) stat);
                red = round(red / (double) stat);
                green = round(green / (double) stat);
                copy[i][j].rgbtRed = red;
                copy[i][j].rgbtBlue = blue;
                copy[i][j].rgbtGreen = green;
            }

        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = copy[i][j];
        }
    }
}
