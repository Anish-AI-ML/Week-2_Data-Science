"""Week 2 – Python for Data Analysis
Run: python week2_python_analysis.py SQL_Sales_Dataset_200_Rows.csv
Requires: pandas, numpy, openpyxl
"""
import sys
import pandas as pd

csv_path = sys.argv[1] if len(sys.argv) > 1 else "SQL_Sales_Dataset_200_Rows.csv"
df = pd.read_csv(csv_path, parse_dates=["order_date"])

# 1. Load CSV and display basic information
print("First five rows:\n", df.head())
print("\nShape:", df.shape)
print("\nInfo:")
df.info()

# 2. Handle missing values and duplicates
print("\nMissing values before cleaning:\n", df.isna().sum())
print("Duplicate rows before cleaning:", df.duplicated().sum())
df = df.drop_duplicates()
# Numeric missing values -> median; text missing values -> mode.
for col in df.select_dtypes(include="number").columns:
    df[col] = df[col].fillna(df[col].median())
for col in df.select_dtypes(include="object").columns:
    if df[col].isna().any():
        df[col] = df[col].fillna(df[col].mode().iloc[0])
print("Rows after cleaning:", len(df))
print("Missing values after cleaning:\n", df.isna().sum())

# 3. Group by category and calculate total revenue
category_revenue = df.groupby("category", as_index=False)["total_price"].sum()
category_revenue = category_revenue.sort_values("total_price", ascending=False)
print("\nRevenue by category:\n", category_revenue)

# 4. Sort by multiple columns (Region A–Z, then revenue high–low)
sorted_data = df.sort_values(
    by=["region", "total_price"],
    ascending=[True, False]
)
print("\nSorted data:\n", sorted_data.head(20))

# 5. Correlation matrix for numerical columns
correlation = df.select_dtypes(include="number").corr()
print("\nCorrelation matrix:\n", correlation)

# Save the processed outputs
with pd.ExcelWriter("Week2_Python_Outputs.xlsx") as writer:
    df.to_excel(writer, sheet_name="Clean Data", index=False)
    category_revenue.to_excel(writer, sheet_name="Category Revenue", index=False)
    sorted_data.to_excel(writer, sheet_name="Sorted Orders", index=False)
    correlation.to_excel(writer, sheet_name="Correlation Matrix")
