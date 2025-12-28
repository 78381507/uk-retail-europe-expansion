# Looker Studio Dashboards

---

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

---

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
- [kpi_francophone.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_business_metrics/kpi_francophone.sql)

---

## Dashboard 3: Retention Analysis

**Purpose**: Deep-dive customer retention and churn analysis to identify at-risk segments and recovery opportunities

**Key Metrics**:
- Retention Rate (≥2 orders): 65.58%
- Avg Customer Lifetime: 4.4 months
- Churn Rate (monthly avg): 63.04%
- Repeat Orders Share: 91.94%

**Key Insights**:
- **Critical retention window**: First 90 days show 67% drop-off after month 3
- **At Risk segment**: 1,280 customers (29%) with £434K revenue → Recovery campaigns critical
- **Champions dominance**: 967 customers generate £5.78M (largest revenue segment)
- **Product strategy**: REGENCY CAKESTAND (£104K) = top Champion product → Test as welcome offer

**RFM Model**:
- R = Days since last purchase | F = Order count | M = Total spend
- Scores 1-5 (NTILE quintiles)
- Champions defined as R≥4, F≥4, M≥4

**Data Sources**:
- `v_retention_kpi` (BigQuery)
- `v_cohort_retention` (BigQuery)
- `v_monthly_churn_fixed` (BigQuery)
- `v_rfm_distribution` (BigQuery)
- `v_champions_products` (BigQuery)

**Visualizations**:
1. 4 KPI scorecards (Retention, Lifetime, Churn, Repeat Rate)
2. Customer Retention by Cohort (line chart, 12 cohorts)
3. RFM Customer Segments (horizontal bar chart, 7 segments)
4. Recovery Potential (horizontal bar chart by segment)
5. Top Products - Champion Customers (horizontal bar chart, top 10)

**Strategic Recommendations**:
1. Launch reactivation campaign targeting At Risk segment (1,280 customers)
2. Implement 90-day retention program (critical drop-off window)
3. Test REGENCY CAKESTAND as welcome bundle for new customers
4. Replicate Champion product mix in new customer onboarding

**SQL Views Created**:
- [kpi_retention_advanced.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_business_metrics/kpi_retention_advanced.sql)








