import time


class date:

    def __init__(self,name):
        self.name = name
        self.feelings = "neutral"
    def drink(self,type,size):
        self.type = type
        self.size = size
    def setMoney(self,money):
        self.money = money
    def getMoney(self):
        return self.money
    def spendMoney(self,spent):
        self.money = (self.money - spent)
    def setFeelings(self,feelings):
        self.feelings = feelings
    def setMeal(self,meal):
        self.meal = meal
    def setEnjoyment(self,enjoyment):
        self.enjoy = enjoyment
name = input("What is your name? ")
player1 = date(name)
name = input("Who are you going on a date with today? ")
player2 = date(name)
cash = int(input("Before we start, how much money do you have? "))
player1.setMoney(cash)
print("Welcome to your date ",player1.name," today you will be having a date with ", player2.name,".")
time.sleep(2)
print("Your date first begins at a starbucks because its early and who doesnt need their coffee?")
print("")
print("")
print("")
print("Welcome to starbucks what would you like today?")
starby = {"small": 5, "medium": 6, "large": 7, "extra large": 8}
type = input("Caramel Machiatto, Latte, Frappe, Americano, Expresso")
print("Okay Sure! Now what size would you like?")
size = input("Small: 5$, Medium: 6$, Large: 7$, Extra Large: 8$ ")
player1.drink(type,size)
# if size.lower() == "small":
#     player1.spendMoney(5)
# if size.lower() == "medium":
#     player1.spendMoney(6)
# if size.lower() == "large":
#     player1.spendMoney(7)
# if size.lower() == "extra large":
#     player1.spendMoney(8)
# else:
#     print("Sorry but we dont have that size")
#     exit
player1.spendMoney(starby[size.lower()])
print("Thank you for coming to starbucks!")
time.sleep(2)
print("You now have ",player1.getMoney(), " left over.")
print("The next part of your date was a beautiful walk in the botanical gardens")
time.sleep(0.5)
print("The flowers are in full bloom and the views and scent are amazing")
time.sleep(0.5)
print("You look over to your date and they look just as stunning as when the day began")
time.sleep(0.5)
print("Youve been walking all day and the sun is dimming. The lights around the garden begin to turn on..")
print("You look at ",player2.name, " and they look back at you.. Eyes completely locked..")
time.sleep(0.5)
print("You feel the time is right.. You begin to lean in..")
time.sleep(2)
print("\n\n\n *gurgle*\n *rumble*\n")
print("Uh-oh, guess its time for dinner instead.")
time.sleep(2)
print("Welcome to Sparks Steakhouse! What can we get you tonight?")
sparks = {"steak fromage": 52, "xl lamb chops": 80, "filet mignon": 63}
meal = input("Steak Fromage: 52$, XL Lamb Chops: 80$, Filet Mignon: 63$")
player1.setMeal(meal)
# if meal.lower() == "steak fromage":
#     player1.spendMoney(52)
# if meal.lower() == "xl lamb chops":
#     player1.spendMoney(80)
# if meal.lower() == "filet mignon":
#     player1.spendMoney(63)
# else:
#     print("Sorry we dont have that.")
#     exit
player1.spendMoney(sparks[meal])
print("Thank you for eating at Sparks! Have a nice day! :)")
time.sleep(2)
print("You now have",player1.money, "dollars left.")
enjoyment = int(input("Rate your date on a scale of 1-5"))
player1.setEnjoyment(enjoyment)
time.sleep(3)
if (player1.type == "latte") or (player1.type == "americano") or (player1.type == "expresso") :
    player1.setFeelings("happy")


print("Congratulations! You completed your date.")
spentMoney = starby[size.lower()] + sparks[meal.lower()]
print("This is how your date went: ")
print("Drink: ", player1.type, player1.size, "$",starby[size.lower()])
print("Dinner: ", player1.meal, "$", sparks[meal.lower()])
print("You spent: $", spentMoney)

if player1.feelings == "happy":
    print("Congrats you got a text back!")
else:
    print("Sorry but you didn't get a text back")
exit