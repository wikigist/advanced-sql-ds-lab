import pandas as pd

revenue_data = {
    "month": ["January", "February", "March", "April"],
    "revenue": [10000, 0, None, 15000]
}

df = pd.DataFrame(revenue_data)

print(df)


# Identify months with missing revenue
df["missing_data"] = df["revenue"].isna()

# Count missing months
missing_months = df["missing_data"].sum()

print(df)
print("Missing months:", missing_months)


# Show only rows with missing revenue
missing_rows = df[df["missing_data"]]

print(missing_rows)