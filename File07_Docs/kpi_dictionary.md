# KPI Dictionary - UK Retail Europe

**Purpose:** Comprehensive definitions of all metrics used across dashboards, SQL views, and automation workflows.

**Last Updated:** December 2025

---

## Revenue Metrics

### **Total Revenue**
- **Definition:** Sum of all non-return, non-B2B transaction amounts
- **Formula:** `SUM(TotalAmount) WHERE IsReturn = FALSE AND IsB2B = FALSE`
- **Currency:** GBP (£)
- **Source:** `clean.online_retail.TotalAmount`
- **Used in:** Dashboard 1, Dashboard 2, Automation Scenario 1

### **Average Order Value (AOV)**
- **Definition:** Average revenue per order
- **Formula:** `SUM(TotalAmount) / COUNT(DISTINCT InvoiceNo)`
- **Currency:** GBP (£)
- **Source:** Calculated from `clean.online_retail`
- **Used in:** Dashboard 1, Dashboard 2, Dashboard 3

### **Revenue Per Customer**
- **Definition:** Total revenue divided by unique customer count
- **Formula:** `SUM(TotalAmount) / COUNT(DISTINCT CustomerID)`
- **Currency:** GBP (£)
- **Excludes:** Null CustomerIDs, returns, B2B transactions
- **Used in:** Dashboard 2 (Francophone), Dashboard 3 (RFM)

---

## Order Metrics

### **Total Orders**
- **Definition:** Count of distinct non-return invoices
- **Formula:** `COUNT(DISTINCT InvoiceNo) WHERE IsReturn = FALSE`
- **Source:** `clean.online_retail.InvoiceNo`
- **Used in:** Dashboard 1, All KPI views

### **Repeat Purchase Rate**
- **Definition:** Percentage of orders from customers with ≥2 orders
- **Formula:** `SUM(Orders WHERE CustomerOrders > 1) / SUM(All Orders)`
- **Format:** Ratio (0.9194 = 91.94% when formatted as Percent in Looker)
- **Used in:** Dashboard 3 (Retention Analysis)

---

## Customer Metrics

### **Identified Customers**
- **Definition:** Count of distinct non-null CustomerIDs
- **Formula:** `COUNT(DISTINCT CustomerID) WHERE CustomerID IS NOT NULL`
- **Source:** `clean.online_retail.CustomerID`
- **Used in:** Dashboard 1, Dashboard 2

### **Retention Rate (≥2 orders)**
- **Definition:** Percentage of customers who made at least 2 purchases
- **Formula:** `COUNT(CustomerID WHERE TotalOrders ≥ 2) / COUNT(CustomerID)`
- **Calculation Level:** Customer-level aggregation first, then percentage
- **Format:** Ratio (0.6558 = 65.58% when formatted as Percent)
- **Used in:** Dashboard 3, `v_retention_kpi`

### **Churn Rate (monthly avg)**
- **Definition:** Monthly average percentage of customers who stop purchasing
- **Formula:** `ChurnedCustomers / ActiveCustomers` (from `v_monthly_churn_fixed`)
- **Logic:** Customers active in month N but not in month N+1
- **Format:** Ratio (0.6304 = 63.04% when formatted as Percent)
- **Used in:** Dashboard 3, Automation alerts

### **Average Customer Lifetime**
- **Definition:** Average duration (in months) between first and last purchase
- **Formula:** `AVG(DATE_DIFF(LastPurchaseDate, FirstPurchaseDate, DAY)) / 30`
- **Unit:** Months
- **Excludes:** Single-purchase customers (lifetime = 0)
- **Used in:** Dashboard 3 (`v_retention_kpi`)

---

## RFM Metrics

### **Recency (R)**
- **Definition:** Days since last purchase (relative to dataset end date)
- **Formula:** `DATE_DIFF('2011-12-09', MAX(InvoiceDate), DAY)`
- **Range:** Positive integer (higher = more recent is WORSE in RFM scoring)
- **Score:** 1-5 (5 = most recent, 1 = least recent) via `NTILE(5)`
- **Used in:** `v_rfm_scores`, Dashboard 3

### **Frequency (F)**
- **Definition:** Total number of distinct orders per customer
- **Formula:** `COUNT(DISTINCT InvoiceNo)`
- **Range:** 1 to N (higher = better)
- **Score:** 1-5 (5 = most frequent) via `NTILE(5)`
- **Used in:** `v_rfm_scores`, Dashboard 3

### **Monetary (M)**
- **Definition:** Total spend per customer
- **Formula:** `SUM(TotalAmount)`
- **Currency:** GBP (£)
- **Range:** Positive decimal (higher = better)
- **Score:** 1-5 (5 = highest spend) via `NTILE(5)`
- **Used in:** `v_rfm_scores`, Dashboard 3

### **RFM Segment**
- **Definition:** Customer segment based on R/F/M scores
- **Examples:**
  - **Champions:** R ≥ 4, F ≥ 4, M ≥ 4
  - **At Risk:** R ≤ 2, F ≥ 2 (purchased often in past, not recently)
  - **Loyal Customers:** High F, moderate R/M
- **Calculation:** Rule-based logic in `v_rfm_distribution`
- **Used in:** Dashboard 3, Automation Scenario 3

---

## Geographic Metrics

### **Francophone Share**
- **Definition:** Percentage of total revenue from France, Belgium, Switzerland
- **Formula:** `SUM(Revenue WHERE Country IN ('France','Belgium','Switzerland')) / SUM(Total Revenue)`
- **Format:** Ratio (0.0314 = 3.14% when formatted as Percent)
- **Used in:** Dashboard 2

### **Country Revenue**
- **Definition:** Total revenue aggregated by country
- **Formula:** `SUM(TotalAmount) GROUP BY Country`
- **Excludes:** Returns, B2B transactions
- **Used in:** Dashboard 1, Dashboard 2

---

## Cohort Metrics

### **Cohort Month**
- **Definition:** Month of customer's first purchase
- **Format:** YYYY-MM (e.g., "2010-12")
- **Source:** `MIN(DATE(InvoiceDate)) GROUP BY CustomerID`
- **Used in:** `v_cohort_retention`, Dashboard 3

### **Month Number**
- **Definition:** Months elapsed since cohort's first purchase (0-indexed)
- **Range:** 0 to 11 (dataset covers 12 months)
- **Example:** Cohort "2010-12" at Month 3 = March 2011
- **Used in:** `v_cohort_retention`, Dashboard 3 cohort chart

### **Active Customers (Cohort)**
- **Definition:** Count of customers from cohort who made purchases in given month
- **Formula:** `COUNT(DISTINCT CustomerID WHERE InvoiceDate IN MonthN)`
- **Used in:** Dashboard 3 cohort retention chart

---

## Anomaly Detection Metrics

### **7-Day Average Revenue**
- **Definition:** Rolling 7-day average of daily revenue
- **Formula:** `AVG(Daily Revenue) OVER (ORDER BY Date ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING)`
- **Used in:** Automation Scenario 1 (daily alert)

### **Percentage Change**
- **Definition:** Variance between current value and baseline
- **Formula:** `((Current - Baseline) / Baseline) * 100`
- **Format:** Percentage with sign (e.g., +15.3%, -8.2%)
- **Alert Threshold:** ±15%
- **Used in:** Automation Scenario 1

### **is_alert Flag**
- **Definition:** Boolean indicator for anomaly detection
- **Logic:** `TRUE IF ABS(pct_change) >= 15 AND revenue >= 1000`
- **Used in:** Automation Scenario 1 (filter condition)

---

## Data Quality Flags

### **IsReturn**
- **Definition:** Boolean flag indicating canceled/returned transaction
- **Logic:** `InvoiceNo LIKE 'C%'`
- **Values:** TRUE (return), FALSE (valid sale)
- **Used in:** All revenue calculations (excluded when TRUE)

### **IsB2B**
- **Definition:** Boolean flag for business-to-business transactions
- **Logic:** `(Quantity * UnitPrice) > 5000 OR Quantity > 100`
- **Values:** TRUE (B2B), FALSE (B2C)
- **Used in:** Consumer analytics (excluded when TRUE)

---

## Recommended Actions (Automation)

### **At Risk - Recommended Action**
- **Definition:** Suggested reactivation offer based on customer profile
- **Logic:**
  - IF `Monetary >= 500` → "10% voucher"
  - ELSE IF `Frequency >= 3` → "Free shipping offer"
  - ELSE → "Welcome bundle"
- **Used in:** Automation Scenario 2 (Google Sheets export)

---

## Notes on Formatting

### **Looker Studio Percent Format**
- **Critical:** Looker's "Percent" format automatically multiplies by 100
- **Rule:** SQL queries must return RATIOS (0.65), not percentages (65)
- **Example:** Retention Rate SQL = `0.6558`, Looker displays `65.58%`

### **Currency Format**
- **Standard:** GBP (£) with comma separators
- **Compact Mode:** Used in KPI cards (£9.77M instead of £9,770,000)
- **Decimals:** 0 for whole numbers, 2 for unit prices/AOV

---

## Validation & Sources

**All metrics validated against:**
- Source data: Kaggle UCI Online Retail Dataset (Dec 2010 - Nov 2011)
- BigQuery views in `uk-retail-europe.mart` schema
- Cross-validation between dashboards (e.g., KPI totals match table sums)

**Known Limitations:**
- Dataset ends Nov 2011 → Churn calculations limited to available timeframe
- No margin/cost data → Revenue only, no profitability metrics
- UK-centric → Limited international coverage

---

## Change Log

**2025-12-26:**
- Initial KPI dictionary created
- Documented all Dashboard 1-3 metrics
- Added RFM segment definitions
- Included automation alert thresholds
