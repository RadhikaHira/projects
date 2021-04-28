# **Casino Blackjack Game**

### Video Demo:
#### [Youtube video of my project](https://youtu.be/7co87GYKaJI)

### Description:
##### For my final project, I had decide to make a 2d casino game which I like playing on my phone, blackjack. This game is recommended for people who want to kill time or learn basic ways of blackjack (without coins though).The game I had made is simple, once it starts the player (you) gets 2 cards, which is totalled.You will see only **one** of the card the dealer has while the other is faced down(hidden), and according to your total you decide if you want to get another card (hit) or stay with the ones you have (stand). If you click hit then you will get another card which then adds to your total, and if you click stand then you will see all of the cards the dealer has as wel as the totals, and choices (to hit or stand) which then would decide if you win or not. If you (or the dealer) go over 21, then the dealer (or you) win. If your total is 21 or higher than the dealer, then you win, otherwise you lose if the dealer is higher.

### Project file
##### The final file will contain 2 files (main.lua and conf.lua), and a folder that contains images. Once the files are done, you put them in a compressed (zipped) folder with the main.lua file above the others. After you put them in the folder you rename it to what you would like the project to be and change the .zip to .love. It will then change the image of the compressed file into a diamond with a heart in it with the name underneath, and when clicked the game will open.

### Files
##### To create this project, I had used Lua with Love. Since this was a new language for me, I had to first learn the syntax, the commands and how the formatting is. Before anything, you need to download the software [Love](https://love2d.org/) this will help in creating and viewing the final file that ends in .love that opens the 2d game. After it is downloaded, you can create the .lua files simply on notepad++.

### Main.lua
##### This file contains everthing from the color of the buttons, cards and background, displaying the cards and buttons, and getting the buttons and cards to function as it should. These are in function or use commands that are under Love, so it would be love.(whatever is needed). In the file we first start with the **load** function, which loads the display when the game is opened. In this, it loads the name of the images from the image folder into an array, creates a functions for random cards, a function for totals (including to see if the ace should be 11 or 1), the location of where the "play again", "hit", "stand" button should be and its size, the function to know when the mouse goes on them, and then the startover function stating what should happen and be displayed when the play again button is pressed. After the load function, I had created a function, **mousereleased**. This would state what would happen when the mouse clicks the butons and the response recieved would be.  After that, comes the function that does most of the work, the **draw** function. This huge function basically draws and colors the cards, buttons, and writing. It also contains the function on what to print if someone won or not.

### Conf.lua
##### This file is a configuration file and does not contain much code. It has the dimensions of the page that will pop up for the game, as well as the game name at the top bar.

### Image folder
##### This is a folder that contains all the images that the card will need. It has every picture like, numbers, images of the jack, queen, king and ace, a black card, a hidden card, and the symbols for the diamond, heart, club and spade.
