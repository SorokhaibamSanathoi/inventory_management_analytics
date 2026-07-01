import pandas as pd

#creating a function to inspect data all at once without writing code again and agian 

def Inspect_data(df):
    print("First five rows")    #This check the first five rows of the csv file
    print(df.head())

    print("\nData Info")      #This returns the info of the csv file
    print(df.info())

    print("\nMissing Data")    #This check how many rows are missing in each column 
    print(df.isnull().sum())

    print("\nDuplicates Rows")   #This check how many duplicated rows are there in each column 
    print(df.duplicated().sum())

    print("\nData Types")     #This returns what are the current data types if each of the column 
    print(df.dtypes)

    print("\nData Shape")     #This returns how many rows and column are there in the dataset
    print(df.shape)



#loading all my datasets

Sites = pd.read_csv("data//raw_csv files//sites.csv")
Daily = pd.read_csv("data//raw_csv files//daily_distribution.csv")
Items = pd.read_csv("data//raw_csv files//items.csv")
Restock = pd.read_csv("data//raw_csv files//site_stock_restocks.csv")
Client = pd.read_csv("data//raw_csv files//clients.csv")

Inspect_data(Daily)
