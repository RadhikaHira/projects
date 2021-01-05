# bring get_string from s50
from cs50 import get_string

# get user input text
text = get_string("Text: ")

# create a length for the text
length = len(text)

# counters
letters = words = sentences = i = 0

while i < length:
    # check letters in text
    if text[i].isalpha():
        letters += 1
    
    # check words in text
    if (i == 0 and text[i] != " ") or (i != length and text[i] == " " and text[i + 1] != " "):
        words += 1
    
    # check sentences in text
    if text[i] == "." or text[i] == "?" or text[i] == "!":
        sentences += 1
    
    # increase i 
    i += 1

# use the Coleman-Liau formula
l = (letters / words) * 100
s = (sentences / words) * 100
grade = round(0.0588 * l - 0.296 * s - 15.8)

# printing out grades
if grade < 1:
    print("Before Grade 1")
elif grade >= 16:
    print("Grade 16+")
else:
    print("Grade ", grade)