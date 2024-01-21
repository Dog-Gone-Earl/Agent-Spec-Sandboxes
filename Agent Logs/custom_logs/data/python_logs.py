import math,random,time

def list_gen():

  companies  = ["Mandy's Movers","Cody's Cleaners","MI6","Logans Logistics"]
  company_name = random.randint(0,3)
  items = ["Van","Truck","SUV"]
  purchase_item = random.randint(0,2)
  purchase_price = random.randrange(10000, 50000, 1000)
  purhcase_amount = random.randint(1,25)

  entry={"Company" :companies[company_name], "Item": items[purchase_item], "Price": purchase_price, "Amount": purhcase_amount} 
  log_data = open("/etc/datadog-agent/python_logs/data.log", "a")
  log_data.write("\n"+str(entry))
  print(entry)
while True:
  list_gen()
  time.sleep(1)

