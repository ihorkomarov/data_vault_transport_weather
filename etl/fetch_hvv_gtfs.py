import os
import requests
import zipfile

# ToDO: find a way to get the GTFS URL that works
GTFS_URL = "https://transfer.hamburg.de/daten/hvv/hvv_gtfs.zip"
DOWNLOAD_PATH = "data/raw/hvv_gtfs.zip"
EXTRACT_PATH = "data/raw/hvv_gtfs/"

os.makedirs(os.path.dirname(DOWNLOAD_PATH), exist_ok=True)

def download_gtfs():
    print("Downloading GTFS data...")
    response = requests.get(GTFS_URL)
    with open(DOWNLOAD_PATH, "wb") as f:
        f.write(response.content)
    print("Download complete.")

def extract_zip():
    print("Extracting GTFS zip...")
    with zipfile.ZipFile(DOWNLOAD_PATH, "r") as zip_ref:
        zip_ref.extractall(EXTRACT_PATH)
    print("Extraction complete.")

if __name__ == "__main__":
    #download_gtfs()
    extract_zip()
