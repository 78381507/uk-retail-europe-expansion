# Looker Studio Dashboards

## Dashboard 1: Executive Overview

**Purpose**: High-level business performance overview for C-level executives

**Key Metrics**:
- Total Revenue: £9.77M
- Total Orders: 23.8K  
- Average Order Value: £411
- Identified Customers: 4.4K

**Key Insights**:
- UK dominates with 84% of revenue (£8.23M)
- France represents ~2% (£200K) - strong growth headroom vs UK baseline
- Q4 2011 peak (£1.46M in November) - clear seasonality for inventory planning
- Monthly revenue shows steady growth from Dec 2010 to Oct 2011, then seasonal spike

**Data Sources**: 
- `v_revenue_monthly` (BigQuery)
- `fact_orders` (BigQuery)

**Filters Applied**:
- Exclude returns (IsReturn = FALSE)
- Exclude B2B transactions (IsB2B = FALSE)

**Interactive Elements**:
- Geographic map with revenue distribution
- Horizontal bar chart ranking countries by revenue
- Monthly time series with data labels

**Screenshot**:

![Executive Overview Dashboard](../../assets/dashboard_screenshots/dashboard_1_executive_overview.png)
