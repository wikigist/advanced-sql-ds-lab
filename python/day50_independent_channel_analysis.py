import pandas as pd

# Day 50 — Independent acquisition channel analysis

customers = {
    "customer_id": [101, 102, 103, 104, 105, 106,
                    107, 108, 109, 110, 111, 112],

    "channel": [
        "Organic", "Paid Search", "Referral", "Organic",
        "Social", "Paid Search", "Organic", "Referral",
        "Social", "Paid Search", "Organic", "Referral"
    ],

    "purchases": [3, 0, 2, 0, 1, 1, 2, 0, 0, 2, 1, 1],

    "revenue": [240, 0, 180, 0, 45, 75, 130, 0, 0, 110, 60, 95]
}

df = pd.DataFrame(customers)

print(df)

df["has_purchased"] = df["purchases"] > 0

print(df)

# Total purchases by acquisition channel
channel_purchases = df.groupby("channel")["purchases"].sum()

print(channel_purchases)


# Number of purchasing customers by channel
channel_customers = df.groupby("channel")["has_purchased"].sum()

print(channel_customers)

print("Total rows:", len(df))
print("Unique customers:", df["customer_id"].nunique())

all_channel = df.groupby("channel").agg(
    purchasing_customers=("has_purchased", "sum"),
    total_purchases=("purchases", "sum"),
    total_revenue=("revenue", "sum"),
    total_customers=("customer_id", "size")
    )

print(all_channel)


# # Step 2: Calculate purchaser rate using the summary columns
all_channel["purchaser_rate_%"] = (
    all_channel["purchasing_customers"]
    / all_channel["total_customers"]
) * 100

print(all_channel)


# Step 3: Solve for revenue_per_customer
all_channel["revenue_per_customer"] = (all_channel["total_revenue"] / all_channel["total_customers"])
print(all_channel)