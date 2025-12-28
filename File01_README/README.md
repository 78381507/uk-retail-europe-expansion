# UK Retail Europe - End-to-End Data Analytics Portfolio

**A comprehensive analytics project demonstrating data engineering, business intelligence, and automation capabilities.**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![BigQuery](https://img.shields.io/badge/BigQuery-enabled-blue)](https://cloud.google.com/bigquery)
[![Looker Studio](https://img.shields.io/badge/Looker-3%20Dashboards-green)](https://lookerstudio.google.com/)

---

## 📊 Project Overview

This portfolio showcases a complete data analytics workflow built on the **UCI Online Retail dataset** (540K+ transactions, 12 months of UK e-commerce data).

**Business Context:**
- UK-based online retailer selling giftware across Europe
- Challenge: High customer churn, untapped francophone markets, reactive operations
- Solution: 3-layer analytics stack (data foundation, dashboards, automation)

**Key Deliverables:**
1. **Data Infrastructure** - BigQuery data warehouse with dimensional modeling
2. **Business Intelligence** - 3 Looker Studio dashboards (Executive, Market Expansion, Retention)
3. **Automation** - Make.com workflows for daily alerts and weekly CRM exports

---

## 🎯 Business Impact

**Projected Annual Impact:**
- **£87K** recovered revenue (At-Risk customer reactivation)*
- **£307K** francophone market growth opportunity*
- **3.5 hours/week** operational time saved through automation

*Estimated based on 20% At-Risk reactivation rate and 2x francophone market growth

---

## 📁 Repository Structure
```
uk-retail-europe-expansion/
│
├── File01_README/                     
│   └── README.md
│ 
├── File02_BUSINESS_CASE/
│   └── Business_Case.md               # Business context, ROI analysis, stakeholder requirements
│
├── File03_data/
│   ├── raw/
│   │    └── Online Retail.xlsx         # Source data (UCI ML Repository) 
│   ├── README.md                      # Dataset documentation
│   ├── processed
│   └── schema.sql
│ 
├── File04_SQL/
│   ├── 01_data_quality/               # Data validation & cleaning queries
│   │   ├── checks.sql
│   │   └── cleaning.sql
│   ├── 02_data_models/                # Dimensional model (customers, products, geography)
│   │   ├── dim_customers.sql
│   │   ├── dim_geography.sql
│   │   ├── dim_products.sql
│   │   └── fact_orders.sql
│   └── 03_business_metrics/           # KPI views (revenue, retention, RFM, geographic)
│       ├── kpi_francophone.sql
│       ├── kpi_geographic.sql
│       ├── kpi_retention.sql
│       ├── kpi_retention_advanced.sql
│       ├── kpi_revenue.sql
│       └── kpi_rfm.sql
│
├── File05_Looker/
│   ├── README.md                      # Dashboard documentation
│   ├── dashboard_1_executive_overview.png
│   ├── dashboard_2_francophone_expansion.png
│   └── dashboard_3_retention_analysis.png
│
├── File06_Automation/
│   ├── README.md                      # Make.com workflow documentation
│   ├── screenshots/                   # Automation workflow screenshots
│   │   ├── 01_scenario_01_make_workflow_complete.png
│   │   ├── 02_scenario_01_make_filter_inspector.png
│   │   ├── 03_scenario_01_slack_config.png
│   │   ├── 04_scenario_01_slack_message_received.png
│   │   ├── 05_scenario_02_make_workflow.png
│   │   ├── 06_scenario_02_schedule.png
│   │   └── 07_scenario_02_google_sheets.png
│   └── sql/
│       ├── daily_revenue_alert.sql
│       └── weekly_at_risk_export.sql
│
├── File07_Docs/
│   ├── kpi_dictionary.md              # Comprehensive metric definitions
│   └── setup_guide.md                 # BigQuery & Looker setup instructions
│
└── File08_Assets/
    └── presentation.pdf               # PowerPoint (8 slides)
        └── UK_Retail_Portfolio_Presentation.pdf

```

---

## 🛠️ Technology Stack

**Data Infrastructure:**
- **Google BigQuery** - Cloud data warehouse
- **SQL** - Data modeling, transformations, business logic
- **Python** - Data cleaning & validation (Pandas, Google Colab)

**Business Intelligence:**
- **Looker Studio** (Google Data Studio) - Interactive dashboards
- **Data visualization** - Chart design, KPI scorecards

**Automation:**
- **Make.com** - Workflow automation platform
- **Slack** - Real-time alerts
- **Google Sheets** - CRM data exports

**Development:**
- **Git/GitHub** - Version control, documentation
- **Markdown** - Technical documentation

---

## 📊 Dashboards

### **Dashboard 1: Executive Overview**
**Purpose:** Daily business health monitoring for C-level stakeholders

**Key Metrics:**
- Total Revenue: £9.77M
- Total Orders: 22,190
- Average Order Value: £411
- Identified Customers: 4,372

**Key Insights:**
- UK dominates with 84% of revenue (£8.23M)
- Q4 peak: £1.46M in November 2011
- Clear seasonality pattern for inventory planning

**Screenshot:**  
![Executive Overview](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File05_Looker/dashboard_1_executive_overview.png)

---

### **Dashboard 2: Francophone Expansion**
**Purpose:** Market opportunity analysis for France, Belgium, Switzerland

**Key Metrics:**
- Francophone Revenue Share: 3.14%
- France Orders: 1,384
- Belgium Revenue/Customer: £1,647
- Switzerland AOV: £1,106

**Key Insights:**
- Switzerland AOV 2x higher than France → Premium product strategy
- Belgium customer lifecycle model (£1,647/customer) replicable
- France represents volume opportunity (1,384 orders)

**Screenshot:**  
![Francophone Expansion](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File05_Looker/dashboard_2_francophone_expansion.png)

---

### **Dashboard 3: Retention Analysis**
**Purpose:** Reduce churn and identify at-risk customer segments

**Key Metrics:**
- Retention Rate (≥2 orders): 65.58%
- Avg Customer Lifetime: 4.4 months
- Churn Rate (monthly avg): 63.04%
- Repeat Orders Share: 91.94%

**Key Insights:**
- 1,280 At-Risk customers (29% of base) → £434K recovery opportunity
- Champions (967 customers) generate £5.78M (59% of revenue)
- Critical retention window: First 90 days (67% drop-off after month 3)

**RFM Model:**
- R = Days since last purchase | F = Order count | M = Total spend
- Scores 1-5 (NTILE quintiles)
- Champions defined as R≥4, F≥4, M≥4

**Screenshot:**  
![Retention Analysis](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File05_Looker/dashboard_3_retention_analysis.png)

---

## ⚡ Automation Workflows

### **Scenario 1: Daily Revenue Alert (Slack)**
**Trigger:** Daily at 09:00 UTC  
**Logic:** Compare France revenue vs 7-day average, alert if ±15% variance  
**Output:** Slack message with date, revenue, baseline, percentage change  
**Business Impact:** Real-time anomaly detection, <5 min response time

**Documentation:** [automation/README.md](https://github.com/78381507/uk-retail-europe-expansion/tree/main/File06_Automation/README)

---

### **Scenario 2: Weekly At-Risk Export (Google Sheets)**
**Trigger:** Every Monday 08:00 UTC  
**Logic:** Export top 50 At-Risk customers (R≤2, F≥2) with recommended actions  
**Output:** Google Sheets with CustomerID, Country, Spend, Recommended Action  
**Business Impact:** Marketing team has ready-to-use reactivation list

**Recommended Actions:**
- High spend (≥£500) → 10% voucher
- Frequent buyers (≥3 orders) → Free shipping offer
- Others → Welcome bundle (top Champion product)

**Documentation:** [automation/README.md](https://github.com/78381507/uk-retail-europe-expansion/tree/main/File06_Automation/README)

---

## 📖 Key Documentation

### **Business Case**
Comprehensive business context, ROI analysis, stakeholder requirements, and project timeline.

[Read Business Case →](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File02_BUSINESS_CASE/Business_Case.md)

---

### **KPI Dictionary**
Complete definitions of all metrics used across dashboards, SQL views, and automation workflows. Essential for understanding calculation methodologies and avoiding ambiguity.

**Includes:**
- Revenue metrics (Total Revenue, AOV, Revenue/Customer)
- Order metrics (Total Orders, Repeat Purchase Rate)
- Customer metrics (Retention Rate, Churn Rate, Avg Lifetime)
- RFM metrics (Recency, Frequency, Monetary + Segment definitions)
- Anomaly detection metrics (7-day avg, percentage change)

[Read KPI Dictionary →](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File07_Docs/kpi_dictionary.md)

---

### **SQL Documentation**

**Data Quality Layer:**
- [Data validation queries](https://github.com/78381507/uk-retail-europe-expansion/tree/main/File04_SQL/01_data_quality)
- IsReturn, IsB2B flagging logic
- Invalid record removal (negative prices, missing descriptions)

**Dimensional Model:**
- [dim_customers.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/02_data_models/dim_customers.sql)
- [dim_geography.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/02_data_models/dim_geography.sql)
- [dim_products.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/02_data_models/dim_products.sql)
- [fact_orders.sql](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/02_data_models/fact_orders.sql)

**Business Metrics:**
- [Francophone KPIs](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_business_metrics/kpi_francophone.sql)
- [Geographic KPIs](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_business_metrics/kpi_geographic.sql)
- [Retention KPIs](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_business_metrics/kpi_retention.sql)
- [Retention Advanced KPIs](https://github.com/78381507/uk-retail-europe-expansion/blob/main/File04_SQL/03_business_metrics/kpi_retention_advanced.sql)
- [Revenue KPIs](SQL/03_business_metrics/kpi_revenue.sql)
- [RFM Segmentation](SQL/03_business_metrics/kpi_rfm.sql)

---

## 🚀 Quick Start

### **Option 1: Explore Dashboards**
1. View dashboard screenshots in [looker/dashboards/](looker/dashboards/)
2. Read insights in [Dashboard Documentation](looker/dashboards/README.md)

### **Option 2: Review SQL Logic**
1. Start with [KPI Dictionary](File07_Docs/kpi_dictionary.md) for metric definitions
2. Explore dimensional model in [sql/02_data_models/](sql/02_data_models/)
3. Review business metrics in [sql/03_business_metrics/](sql/03_business_metrics/)

### **Option 3: Understand Automation**
1. Read [Automation README](automation/README.md)
2. View workflow screenshots in [automation/screenshots/](automation/screenshots/)
3. Review SQL queries in [automation/sql/](automation/sql/)

### **Option 4: Business Context**
1. Read [Business Case](File02_BUSINESS_CASE/Business_Case.md)
2. Review [Dataset Documentation](File03_DATA/README.md)

---

## 📊 Data Source

**Dataset:** Online Retail (UCI Machine Learning Repository)  
**ID:** 352  
**DOI:** 10.24432/C5BW33  
**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

**Citation:**
```
Chen, D. (2015). Online Retail [Dataset]. 
UCI Machine Learning Repository. 
https://doi.org/10.24432/C5BW33
```

**Period:** Dec 1, 2010 - Dec 9, 2011 (12 months)  
**Transactions:** 541,909 raw → 539,392 cleaned  
**Countries:** 38 (UK, France, Belgium, Switzerland, Germany, etc.)

[Full Dataset Documentation →](File03_DATA/README.md)

---

## 🎓 Skills Demonstrated

**Technical:**
- SQL (data modeling, window functions, CTEs, aggregations)
- BigQuery (cloud data warehouse, query optimization)
- Data cleaning & validation (Python/Pandas)
- Business intelligence (dashboard design, KPI definition)
- Workflow automation (Make.com, API integrations)
- Version control (Git/GitHub)

**Business:**
- Stakeholder analysis (CEO, CMO, Operations)
- ROI calculation & business case development
- Metric definition & KPI framework design
- Data storytelling & insight communication
- Problem framing (churn, market expansion, operational efficiency)

**Analytical:**
- Cohort analysis
- RFM segmentation
- Anomaly detection
- Market opportunity sizing
- Customer lifetime value analysis

---

## 👤 Contact

**François Tilkin**  
Data Analyst | Analytics & Automation

**LinkedIn:** [linkedin.com/in/francois-tilkin](https://linkedin.com/in/francois-tilkin)  
**GitHub:** [github.com/78381507](https://github.com/78381507)  
**Email:** tilkinanalytics@gmail.com

---

## 📄 License

**Code & Documentation:** MIT License  
**Dataset:** Creative Commons Attribution 4.0 International (CC BY 4.0)

See [UCI ML Repository](https://archive.ics.uci.edu/dataset/352/online+retail) for dataset license details.

---

## 🙏 Acknowledgments

- **UCI Machine Learning Repository** for the Online Retail dataset
- **Anthropic Claude** for technical assistance and code review
- **Google Cloud Platform** for BigQuery infrastructure
- **Make.com** for workflow automation platform

---

**Last Updated:** December 2025  
**Status:** Portfolio Complete ✅
