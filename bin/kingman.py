

water = 10
soda = 20
beer = 50
total = 0

print("how much money do you have?")
money=int(input())

def order(total):
    print("What do you want to drink?")
    # global total
    global drink
    drink = input()
    if drink == "water":
        total += water
    elif drink == "soda":
        total += soda
    elif drink == "beer":
        total += beer
    else:
        print("No drink?")
    return total
order(total)

def king(total):
    # global total
    global money
    if total > money:
        print("You don't have enough money") 
        total=0      
    else:
        print("One", drink, "Coming right up!")
        exit()
    return total

king(total)

#print(money)
#print(total)
#print(drink)
print("get money from ATM")
atm=int(input())
money= money + atm
#print(money)
#print(total)

order()
king()