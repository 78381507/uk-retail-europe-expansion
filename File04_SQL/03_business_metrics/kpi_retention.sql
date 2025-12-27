-- ================================================
-- KPI RETENTION - Cohort analysis et churn
-- ================================================

-- Vue 1: Cohort retention (par mois d'acquisition)
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_cohort_retention` AS
WITH FirstPurchase AS (
  SELECT 
    CustomerID,
    MIN(DATE_TRUNC(InvoiceDate, MONTH)) AS CohortMonth
  FROM `uk-retail-europe.mart.fact_orders`
  WHERE CustomerID IS NOT NULL AND IsReturn = FALSE
  GROUP BY CustomerID
),
UserActivity AS (
  SELECT 
    f.CustomerID,
    fp.CohortMonth,
    DATE_TRUNC(f.InvoiceDate, MONTH) AS ActivityMonth,
    DATE_DIFF(DATE_TRUNC(f.InvoiceDate, MONTH), fp.CohortMonth, MONTH) AS MonthNumber
  FROM `uk-retail-europe.mart.fact_orders` f
  JOIN FirstPurchase fp ON f.CustomerID = fp.CustomerID
  WHERE f.IsReturn = FALSE
)
SELECT 
  CohortMonth,
  MonthNumber,
  COUNT(DISTINCT CustomerID) AS ActiveCustomers
FROM UserActivity
GROUP BY CohortMonth, MonthNumber
ORDER BY CohortMonth, MonthNumber;

-- Vue 2: Churn mensuel
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_monthly_churn` AS
SELECT 
  YearMonth,
  COUNT(DISTINCT CustomerID) AS ActiveCustomers,
  LAG(COUNT(DISTINCT CustomerID)) OVER (ORDER BY YearMonth) - COUNT(DISTINCT CustomerID) AS ChurnedCustomers
FROM `uk-retail-europe.mart.fact_orders`
WHERE CustomerID IS NOT NULL AND IsReturn = FALSE
GROUP BY YearMonth;
