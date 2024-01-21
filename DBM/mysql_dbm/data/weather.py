import time, random, os, mysql.connector

while True:

  temperature = round(random.uniform(70,90),0)
  humidity = round(random.uniform(30,40),0)
  pressure = round(random.uniform(800,1100),0)
 
  mysql_user = os.getenv("MYSQL_USER") 
  mysql_pw = os.getenv("MYSQL_PW") 
  weather_db= 'weather_database'
  
  params = {
    'user': mysql_user, 
    'password': mysql_pw,
    'database': weather_db
}

  cnx = mysql.connector.connect(**params)
  cursor = cnx.cursor()
  add_weather = ("INSERT INTO weather_table " "(temp,humidity,pressure) " "VALUES ( %(temp)s, %(humi)s, %(psi)s)")
  
  weather_data = {
    'temp' : temperature,
    'humi' : humidity,
    'psi' : pressure
  }
  
  cursor.execute(add_weather, weather_data)
  weather_id = cursor.lastrowid
  
  cnx.commit()
  cursor.close()
  cnx.close()

  print(temperature, humidity, pressure)

  time.sleep(.5)