print("Welcome to my first python program!")
print("This one specifically is a small quiz just to test my basics.")
print("I hope you enjoy <3")
score = 0 
answer = input("Would you like to play? Yes or no? ")
if (answer.lower() != "yes"):
    quit()
else:
    print("Yay! You want to play. Lets start with an easy one.")

answer = input("Is this the first question? ")
if answer.lower() == "no":
    print("Haha, correct! How perceptive.")
    score += 1
else:
    print("WRONG!! Ok but seriously, the first one was if you'd like to play!!")

answer = input("Are squares rectangles? ")
if answer.lower() == "yes":
    print("Correct!")
    score += 1
else:
    print("Incorrect! All squares are rectangles but not all rectangles are squares.")

answer = str(input("What is 9 + 10? "))
if answer.lower() == "19":
    print("Correct!")
    score += 1
else:
    print("Incorrect!")
    
answer = input("How many continents are there?")
if str(answer.lower()) == "7":
    print("Correct!")
    score += 1
else:
    print("Incorrect!")

print("Congratz! You have gotten "+ str(score) +" correct answers.")
print("That's "+ str(score/4*100) + "%")