import json
import os
import requests
import pandas as pd
from sqlalchemy import create_engine
import datetime as dt
from dotenv import load_dotenv

load_dotenv('db.env')

# Umgebungsvariablen POSTGRES_USER
POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")

# PostgreSQL-Verbindung
engine = create_engine(f"postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}@localhost:5432/postgres")

# Daten abrufen

# read all file names from the directory
directory = "data/raw/weather"
files = os.listdir(directory)
files = [f for f in files if f.endswith('.json')]


# initialisiere leere dataframe
weather_list = []
for file in files:
    # Lade die JSON-Datei
    with open(os.path.join(directory, file), 'r') as f:
        data = json.load(f)

    for day in data["days"]:
        #convert day["datetime"] to date
        date =  dt.datetime.strptime(day["datetime"], "%Y-%m-%d").date()
        for hour in day["hours"]:
            #convert hour["datetime"] to time
            time = dt.datetime.strptime(hour["datetime"], "%H:%M:%S").time()
            weather_record = {
                "datetime": dt.datetime.combine(date,time),
                "temp": hour["temp"],
                "feelslike": hour["feelslike"],
                "humidity": hour["humidity"],
                "dew": hour["dew"],
                "precip": hour["precip"],
                "precipprob": hour["precipprob"],
                "snow": hour["snow"],
                "snowdepth": hour["snowdepth"],
                "preciptype": hour["preciptype"],
                "windgust": hour["windgust"],
                "windspeed": hour["windspeed"],
                "winddir": hour["winddir"],
                "pressure": hour["pressure"],
                "visibility": hour["visibility"],
                "cloudcover": hour["cloudcover"],
                "solarradiation": hour["solarradiation"],
                "solarenergy": hour["solarenergy"],
                "uvindex": hour["uvindex"],
                "conditions": hour["conditions"]
            }
            weather_list.append(weather_record)
            
weather_df = pd.DataFrame(data=weather_list)

weather_df.to_sql("raw_weather", engine, if_exists="replace", index=False)

print("Done")
