import pandas as pd

# Day 54: Building a monthly calendar in pandas

months = pd.date_range(
    start="2026-01-01",
    end="2026-04-01",
    freq="MS"
)

print(months)


calendar_df = pd.DataFrame({"month_start": months})

print(calendar_df)


revenue_data = {
    "month_start": ["2026-01-01", "2026-02-01", "2026-04-01"],
    "revenue": [10000, 12000, 15000]
}

revenue_df = pd.DataFrame(revenue_data)

print(revenue_df)

# Convert revenue dates from text to datetime
revenue_df["month_start"] = pd.to_datetime(
    revenue_df["month_start"]
)

print(revenue_df.dtypes)

#merge both data
complete_report = calendar_df.merge(
    revenue_df,
    on="month_start",
    how="left"
)

print(complete_report)

#check for misisng data
complete_report["revenue_missing"] = complete_report["revenue"].isna()

print(complete_report)


# Count months with missing revenue
missing_month_count = complete_report["revenue_missing"].sum()

print("Missing months:", missing_month_count)