# use get_float from cs50
from cs50 import get_float

# put counter to 0
counter = 0

while True:
    owe = get_float("Change: ")
    if owe > 0:
        break

# convert into cents
change = round(int(owe * 100))

# sort coins and increase counter
while change > 0:
    # coins over 25
    if change >= 25:
        change -= 25
        counter += 1
        
    # coins over 10
    elif change >= 10:
        change -= 10
        counter += 1
        
    # coins over 5
    elif change >= 5:
        change -= 5
        counter += 1
        
    # 1 cents
    else:
        change -= 1
        counter += 1
        
print(counter)
        