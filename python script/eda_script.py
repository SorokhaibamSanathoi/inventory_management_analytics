#EDA  which item has the highest consumtion rate 

# this return the list of item from highest consumtion to lowest
import pandas as pd
Daily_usage = pd.read_csv("data/cleaned_data/daily_usage.csv")
Items = pd.read_csv("data/cleaned_data/items.csv")

# # item_consumtion = Daily_usage.groupby("item_id")["qty_drawn"].sum()
# # print(item_consumtion.sort_values(ascending = False))


# #This group by item id and sum up the qty drawn to see which item is being consume the most
# item_consumption = Daily_usage.groupby("item_id")["qty_drawn"].sum().reset_index()
# item_consumption.columns = ["item_id","total_qty_drawn"]

# item_consumption = item_consumption.merge(Items[["item_id","item_name","unit"]],on="item_id")
# item_consumption = item_consumption.sort_values("total_qty_drawn",ascending = False)
# print(item_consumption)

#2nd eda which site consume the most items ?

total_item_consumed = (Daily_usage.groupby("site_id")["qty_drawn"].sum().reset_index())
total_item_consumed.columns = ["site_id","total_qty_drawn"]
print(total_item_consumed.sort_values("total_qty_drawn", ascending=False))
