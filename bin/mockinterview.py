
# User Input
query = input("Please enter a letter")

# Dictionary
bank = {'a': 1, 'b': 2,'c' : 3, 'd': 4}

# Exception Handler
try:
    # Test 
    print("You entered: " + query + ". This converts to: " + str(bank[query]) + ".")
except:
    # Exception
    print("Input must be letter between a-d.")
    exit(1)

  




