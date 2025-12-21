# Looker Studio Dashboards

## Dashboard 1: Executive Europe Overview

**Purpose**: High-level business performance overview for C-level executives

**Key Metrics**:
- Total Revenue: £9.77M
- Total Orders: 23.8K  
- Average Order Value: £411
- Identified Customers: 4.4K

**Key Insights**:
- UK dominates with 84% of revenue (£8.2M)
- France/Belgium represent ~3% - strong growth opportunity
- Q4 2011 peak (£1.46M in November) - clear seasonality for inventory planning
- Monthly revenue trend shows steady growth from Dec 2010 to Oct 2011

**Data Sources**: 
- `v_revenue_monthly` (BigQuery)
- `fact_orders` (BigQuery)

**Filters Applied**:
- Exclude returns (IsReturn = FALSE)
- Exclude B2B transactions (IsB2B = FALSE)

**Interactive Elements**:
- Geographic map with revenue distribution
- Horizontal bar chart ranking top countries
- Time series with monthly data labels

**Access**: [Live Dashboard Link](https://lookerstudio.google.com/your-link-here)

**Screenshot**:

![Executive Dashboard](../../assets/dashboard_screenshots/dashboard_1_executive.png)
