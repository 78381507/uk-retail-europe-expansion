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
- Monthly revenue shows steady growth from Dec 2010 to Nov 2011, then seasonal spike

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


## Dashboard 2: Francophone Expansion

**Purpose**: Deep-dive analysis of France, Belgium, and Switzerland markets to identify growth opportunities

**Key Metrics**:
- Total Francophone Revenue: £306.66K (3.14% of total)
- Francophone AOV: £570
- Identified Customers: 133

**Key Insights**:
- **Switzerland premium market**: 2x higher AOV (£1,106) vs France (£537) → Opportunity for premium product strategy
- **Belgium lifecycle excellence**: Highest revenue/customer (£1,647) → Model for France customer retention
- **Product localization needed**: France prefers décor items (RABBIT LIGHT £7.3K), Switzerland buys premium packaging (SNACK BOXES £1.3K)
- **Seasonal consistency**: All 3 countries show Q4 peak, aligned with UK pattern

**Data Sources**: 
- `v_francophone_performance` (BigQuery)
- `v_revenue_monthly_francophone` (BigQuery)
- `v_top3_products_francophone` (BigQuery)

**Visualizations**:
1. 4 KPI cards (Revenue, Share %, AOV, Customers)
2. Monthly revenue trend (3 country lines with color coding)
3. Top 3 products by country (9 products, color-coded by country)
4. Country comparison table (5 metrics across FR/BE/CH)

**Interactive Elements**:
- Country color coding: France (blue #0055A4), Switzerland (red #FF0000), Belgium (black #000000)
- Strategic insights highlighted in red/green for visibility

**SQL Views Created**:
- [kpi_francophone.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_bm_kpi_francophone.sql)
