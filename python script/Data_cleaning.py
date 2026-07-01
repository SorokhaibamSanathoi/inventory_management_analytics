# Importing already loaded datafram from load_data.py file

from Load_data import Daily
from Load_data import Restock
from Load_data import Sites
from Load_data import Items
from Load_data import Client

import pandas as pd

#changing date column from string to date format

Daily["date"] = pd.to_datetime(Daily["date"])
Daily = Daily.drop_duplicates()
Daily["qty_drawn"] = Daily["qty_drawn"].fillna(0)
Daily["qty_drawn"] = Daily["qty_drawn"].astype(int)

# print(Daily.info())

#changing columns format for Restock dataframe 

Restock["date"] = pd.to_datetime(Restock["date"])
Restock["qty"] = Restock["qty"].astype(int)

# print(Restock.info())

#Setting outlier so that we can remove them while doing analysis

Daily["is_outlier"] = False

# define max realistic qty_drawn per item
item_max = {
    "ITM-01": 15,    # water jars — max ~9 on a big day, give some headroom
    "ITM-02": 5,     # coffee beans (kg) — max ~1.5kg, generous cap
    "ITM-03": 20,    # milk (litres) — max ~15L on a big day
    "ITM-04": 2,     # tea boxes — always 1, cap at 2 for safety
    "ITM-05": 2,
    "ITM-06": 2,
    "ITM-07": 2,
    "ITM-08": 2,
    "ITM-09": 2,     # sugar packet — always 1
    "ITM-10": 3,     # stirrer packets — max 1-2
}
for item_id , max_val in item_max.items():
    mask = (Daily["item_id"] == item_id) & (Daily["qty_drawn"] > max_val)
    outlier_count = mask.sum()
    if outlier_count > 0:
        print(f"{item_id}: {outlier_count} outliers found")
    Daily.loc[mask, "is_outlier"] = True

# exporting cleaned and ready to use csv files to the cleaned_data file for furthur analysis

Daily.to_csv("data/cleaned_data/daily_usage.csv", index= False)
Sites.to_csv("data/cleaned_data/sites.csv", index= False)
Client.to_csv("data/cleaned_data/client.csv", index= False)
Restock.to_csv("data/cleaned_data/restock.csv", index= False)
Items.to_csv("data/cleaned_data/items.csv", index= False)