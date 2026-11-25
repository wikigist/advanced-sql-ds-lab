import pandas as pd

revenue_data = {
    "month": ["January", "February", "March", "April"],
    "revenue": [10000, 12000, 0, 15000]
}

df = pd.DataFrame(revenue_data)

print(df)

df["previous_revenue"] = df["revenue"].shift(1)

print(df)

df["revenue_change"] = df["revenue"] - df["previous_revenue"] 

print(df)

df["mom_growth_pct"] = (df["revenue_change"] / df["previous_revenue"].replace(0, float("nan"))) * 100

print(df)

df["mom_growth_pct"] = df["mom_growth_pct"].round(2)
print(df)