import json

text = ["https,microsoft,com","https,test,com",'{"tld": "net", "domain": "minecraft", "protocol": "https"}']



def parse(text):
    x = {}
    for i in text:
        if '{' in i:
            # print(i)
            jsonBuffer = json.loads(i)
            # print(jsonBuffer)
            tld = jsonBuffer['tld']
            linkformat = f"{jsonBuffer['protocol']}://{jsonBuffer['domain']}.{jsonBuffer['tld']}"
            if tld in x:
                x[tld].append(linkformat)
            else: 
                x.update({tld: [linkformat]})
        else:
            splitstring = i.split(',')
            tld = splitstring[2]
            linkformat = f"{splitstring[0]}://{splitstring[1]}.{splitstring[2]}"
            if tld in x:
                x[tld].append(linkformat)
            else:
                x.update({splitstring[2]:[linkformat]})
    res = json.dumps(x, indent=2)
    return res
print(parse(text))

