import requests
import pandas as pd
import os
# This script uses openweather api. The documentation for this api can be found at https://openweathermap.org/current
# This script is interactive, meaning it will require user input.
# Please note that the output of this script will be deposited within your working directory.

# Ping API server to see if it is running.
code = os.system("ping -c 1 https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=")
if code == 0:
    os.system("clear")
    print("API Server is working")
else:
    print("API Server may be down.")
    # Error Code handling so this can be used with other scripts
    exit(1)

# My api Key
api_key = "d14f70c212219e0f02e4f506eee86aeb"
os.system("sleep 3s")
city = input("What city would you like to see the weather for?\n")

# Concat the url with the search term and key 
request = "https://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+api_key

# Get request to the API
response = requests.get(request)
# Status handler 
if response.status_code == 200:
    # Take output and format into json so we can use it
    bank = response.json()
    # Take specific info from the get request and assign it to variables so we can use them later.
    weather = bank["weather"][0]["main"]
    temperaturef = round(1.8*(bank["main"]["temp"]-273) + 32)
    temperaturefeels = round(1.8*(bank["main"]["feels_like"]-273) + 32)
    pressure = bank["main"]["pressure"]
    humidity = bank["main"]["humidity"]
    # Use the variables we assigned to create a dictionary 
    dic = {"Location": city,"Weather" : weather, "Temp(F°)" : temperaturef, "Feels like(F°)" : temperaturefeels, "Pressure(mb)" : pressure, "Humidity %": humidity}
    # Create a dataframe using the dictionary
    df = pd.DataFrame([dic])
    # Make "Location" the new index of the dataframe so we dont have an empty column
    df.set_index("Location",inplace=True)
    # Convert the dataframe into csv
    df.to_csv("./weathercsv.csv")
    print("CSV created in current working directory names weathercsv.csv")
    print("Have a nice day. :)")

# Error case: Prints code to screen.
else:
    print("Something went wrong. Error Code:",response.status_code)