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

**Screenshot**:
![Retention Analysis Dashboard](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File08_Assets/dashboard_screenshot/dashboard_03_retention_analysis.png)

**SQL Views Created**:
- [kpi_retention_advanced.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_bm_kpi_retention_advanced.sql)
