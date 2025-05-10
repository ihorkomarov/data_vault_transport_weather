import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine

# .env-Datei einlesen

load_dotenv('db.env')

# Umgebungsvariablen POSTGRES_USER
POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")

base_path = "data/raw/hvv_gtfs/"

# GTFS-Dateien einlesen
stops_df = pd.read_csv(base_path+"/stops.txt", usecols=["stop_id", "stop_name", "stop_lat", "stop_lon"])
routes_df = pd.read_csv(base_path+"/routes.txt", usecols=["route_id", "route_short_name", "route_long_name", "route_type"])


# Dateien einlesen
trips_df = pd.read_csv(base_path + "trips.txt")
stop_times_df = pd.read_csv(base_path + "stop_times.txt")
calendar_df = pd.read_csv(base_path + "calendar.txt")

# Verbindung zur PostgreSQL DB
engine = create_engine(f"postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}@localhost:5432/postgres")



# Tabellen schreiben
stops_df.to_sql("raw_stops", engine, if_exists="replace", index=False)
routes_df.to_sql("raw_routes", engine, if_exists="replace", index=False)
trips_df.to_sql("raw_trips", engine, if_exists="replace", index=False)
stop_times_df.to_sql("raw_stop_times", engine, if_exists="replace", index=False)
calendar_df.to_sql("raw_calendar", engine, if_exists="replace", index=False)

# Datenbankverbindung schließen
engine.dispose()


print("Done")
