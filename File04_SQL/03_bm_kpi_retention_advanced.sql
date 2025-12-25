-- =============================================================================
-- RETENTION ANALYSIS - ADVANCED KPI VIEWS
-- =============================================================================
-- Created for Dashboard 3: Retention Analysis
-- Purpose: Deep-dive customer retention, churn, cohort analysis, and RFM segments
-- =============================================================================

-- Vue 1: KPI Retention globaux
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_retention_kpi` AS
WITH CustomerBehavior AS (
  SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) as TotalOrders,
    MIN(DATE(InvoiceDate)) as FirstPurchase,
    MAX(DATE(InvoiceDate)) as LastPurchase,
    DATE_DIFF(MAX(DATE(InvoiceDate)), MIN(DATE(InvoiceDate)), DAY) as LifetimeDays
  FROM `uk-retail-europe.clean.online_retail`
  WHERE IsReturn = FALSE AND IsB2B = FALSE AND CustomerID IS NOT NULL
  GROUP BY CustomerID
),
LatestChurn AS (
  SELECT ChurnRate
  FROM `uk-retail-europe.mart.v_monthly_churn_fixed`
  WHERE YearMonth = (SELECT MAX(YearMonth) FROM `uk-retail-europe.mart.v_monthly_churn_fixed`)
)
SELECT
  -- Retention Rate (customers with ≥2 orders)
  SUM(CASE WHEN TotalOrders > 1 THEN 1 ELSE 0 END) / COUNT(*) as RetentionRate,
  
  -- Avg Customer Lifetime (months)
  AVG(LifetimeDays) / 30 as AvgLifetimeMonths,
  
  -- Repeat Purchase Rate (% orders from repeat customers)
  SUM(CASE WHEN TotalOrders > 1 THEN TotalOrders ELSE 0 END) / SUM(TotalOrders) as RepeatPurchaseRate,
  
  -- Churn Rate (monthly average)
  (SELECT ChurnRate FROM LatestChurn) as ChurnRate
FROM CustomerBehavior;

-- Vue 2: Monthly Churn corrigé
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_monthly_churn_fixed` AS
WITH MonthlyActive AS (
  SELECT 
    FORMAT_TIMESTAMP('%Y-%m', InvoiceDate) as YearMonth,
    CustomerID
  FROM `uk-retail-europe.clean.online_retail`
  WHERE IsReturn = FALSE AND IsB2B = FALSE AND CustomerID IS NOT NULL
  GROUP BY YearMonth, CustomerID
),
MonthlyStats AS (
  SELECT 
    YearMonth,
    COUNT(DISTINCT CustomerID) as ActiveCustomers,
    LAG(COUNT(DISTINCT CustomerID)) OVER (ORDER BY YearMonth) as PreviousActive
  FROM MonthlyActive
  GROUP BY YearMonth
)
SELECT 
  YearMonth,
  ActiveCustomers,
  GREATEST(0, COALESCE(PreviousActive - ActiveCustomers, 0)) as ChurnedCustomers,
  CASE 
    WHEN PreviousActive > 0 THEN GREATEST(0, COALESCE(PreviousActive - ActiveCustomers, 0)) / PreviousActive
    ELSE 0
  END as ChurnRate
FROM MonthlyStats
ORDER BY YearMonth;

-- Vue 3: Lost Revenue (At Risk + Lost segments)
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_lost_revenue` AS
WITH AtRiskLost AS (
  SELECT 
    CustomerCount,
    TotalRevenue
  FROM `uk-retail-europe.mart.v_rfm_distribution`
  WHERE Segment IN ('At Risk', 'Lost')
)
SELECT
  SUM(CustomerCount) as AtRiskLostCustomers,
  SUM(TotalRevenue) as AtRiskLostRevenue,
  SUM(TotalRevenue) / SUM(CustomerCount) as AvgRevenuePerCustomer
FROM AtRiskLost;

-- Vue 4: Champions Products (Top 10)
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_champions_products` AS
WITH ChampionCustomers AS (
  SELECT CustomerID
  FROM `uk-retail-europe.mart.v_rfm_scores`
  WHERE R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4
)
SELECT 
  f.Description,
  COUNT(DISTINCT f.InvoiceNo) as Orders,
  SUM(f.TotalAmount) as Revenue
FROM `uk-retail-europe.clean.online_retail` f
JOIN ChampionCustomers c ON f.CustomerID = c.CustomerID
WHERE f.IsReturn = FALSE 
  AND f.IsB2B = FALSE
  AND f.Description NOT LIKE '%POSTAGE%'
GROUP BY f.Description
ORDER BY Revenue DESC
LIMIT 10;
