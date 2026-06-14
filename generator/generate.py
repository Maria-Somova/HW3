import csv
import random
import os
import sys

NUM_ROWS = 50


COLUMNS = ["manicure_type", "price", "time", "master_level"]

def generate_row():
    service = random.randint(["coated", "extensions", "desing", "care"])

    if service == "coated":
        price = random.randint(2000, 3000)
        time = random.randint(90, 120)
    elif service == "extensions":
        price = random.randint(3000, 5000)
        time = random.randint(120, 180)
    elif service == "desing":
        price = random.randint(2500, 5000)
        time = random.randint(90, 180)
    else:
        price = random.randint(800, 1500)
        time = random.randint(30, 60)
    
    return {
        "manicure_type": service,
        "price": price,
        "time": time,
        "master_level": random.choice(["intern", "master", "top-master"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)
