# bring the get_int from cs50 file
from cs50 import get_int

# no do-while loop so other method
while True:
    h = get_int("Height: ")
    if h < 1 or h > 8:
        h = get_int("Height: ")
    if h >= 1 or h <= 8:
        break
    
# create pyramid
for i in range(h):
    # for spaces
    print((h - 1 - i) * " ", end="")
    # for boxes
    print((i + 1) * "#")
    