# Day 47: Python and pandas foundations

import pandas as pd

customers = {
    "name": ["Nia", "Omar", "Priya", "Leo"],
    "channel": ["Organic", "Paid Search", "Referral", "Organic"],
    "purchases": [2, 0, 1, 0],
    "revenue": [200, 0, 120, 0]
}

df = pd.DataFrame(customers)

print(df)
print(df["revenue"].sum())
print(df["purchases"].sum())


# purchases greater than zero
purchasing_customers = df[df["purchases"] > 0]
print(purchasing_customers)


# The number of purchasing customers, rather than their names?
total_purchasing_customers = len(purchasing_customers)

print(total_purchasing_customers)


# What percentage of our registered customers have made at least one purchase?

registered_customers = df["name"]
total_reg_customers = len(registered_customers)
purchaser_rate_pct = (total_purchasing_customers / total_reg_customers) * 100
print(purchaser_rate_pct)