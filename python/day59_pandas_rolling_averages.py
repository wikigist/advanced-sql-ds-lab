# Day 59: Rolling revenue averages in pandas

import pandas as pd

revenue_data = {
    "month": ["January", "February", "March",
              "April", "May", "June"],
    "revenue": [None, 12000, 9000, 15000, 11000, 17000]
}

df = pd.DataFrame(revenue_data)

print(df)


df["three_month rolling_avg_revenue"] = (
    df["revenue"]
    .rolling(window=3, min_periods=3)
    .mean()
    .round(2)
)

print(df)

df["four_month_rolling_avg"] = ((df["revenue"].rolling(window=4, min_periods=3).mean().round(2)))

print(df)

