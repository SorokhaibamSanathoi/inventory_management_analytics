"""
Exploratory Data Analysis (EDA)

Project:
Inventory Management Analytics

Objective:
Answer key business questions using Pandas to understand
inventory consumption patterns before performing advanced
analysis in SQL and creating dashboards in Power BI.
"""

import pandas as pd

# =====================================================
# Load Cleaned Datasets
# =====================================================

Daily_usage = pd.read_csv("data/cleaned_data/daily_usage.csv")
Items = pd.read_csv("data/cleaned_data/items.csv")
Restock = pd.read_csv("data/cleaned_data/restock.csv")

# =====================================================
# Business Question 1:
# Which inventory item has the highest total consumption?
# =====================================================

# item_consumption = Daily_usage.groupby("item_id")["qty_drawn"].sum().reset_index()
# item_consumption.columns = ["item_id", "total_qty_drawn"]

# # Attach item details to make the output easier to understand.
# item_consumption = item_consumption.merge(
#     Items[["item_id", "item_name", "unit"]],
#     on="item_id"
# )

# item_consumption = item_consumption.sort_values(
#     "total_qty_drawn",
#     ascending=False
# )

# print(item_consumption)


# =====================================================
# Business Question 2:
# Which site has the highest total inventory consumption?
# =====================================================

# total_item_consumed = Daily_usage.groupby("site_id")["qty_drawn"].sum().reset_index()
# total_item_consumed.columns = ["site_id", "total_qty_drawn"]

# print(total_item_consumed.sort_values("total_qty_drawn", ascending=False))


# =====================================================
# Business Question 3:
# Which month records the highest inventory consumption?
# =====================================================

# # Extract the month from the transaction date for monthly analysis.
# Daily_usage["date"] = pd.to_datetime(Daily_usage["date"])
# Daily_usage["month"] = Daily_usage["date"].dt.month_name()

# monthly_consumption = Daily_usage.groupby("month")["qty_drawn"].sum().reset_index()
# monthly_consumption.columns = ["month", "total_qty_drawn"]

# print(monthly_consumption.sort_values("total_qty_drawn", ascending=False))


# =====================================================
# Business Question 4:
# Which site requires the highest number of emergency restocks?
# =====================================================

# total_emergency_restock = Restock[Restock["restock_type"] == "emergency"].groupby("site_id")["restock_type"].count().reset_index()
# total_emergency_restock.columns = ["site_id","emergency_restock"]
# print(total_emergency_restock.sort_values("emergency_restock",ascending=False))


# =====================================================
# Business Question 5:
# which items triggered these emergency restocks?
# =====================================================

emergency_restock = (
    Restock[Restock["restock_type"] == "emergency"]
    .groupby("item_id")["restock_type"]
    .count().
    reset_index()
)
emergency_restock = emergency_restock.merge(
    Items[["item_id","item_name"]],
    on = "item_id"
)
emergency_restock.columns = ["item_id","emergency_count","item_name"]
print(emergency_restock)

# =====================================================

# =====================================================