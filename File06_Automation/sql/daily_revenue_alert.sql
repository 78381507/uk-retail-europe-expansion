-- =============================================================================
-- DAILY REVENUE ALERT - France Market
-- =============================================================================
-- Purpose: Compare yesterday's France revenue vs same weekday baseline (4 weeks)
-- Used by: Make.com Scenario 1 (Daily Slack Alert)
-- Alert threshold: ±15% variance AND revenue ≥ £1,000
-- =============================================================================

WITH Yesterday AS (
  SELECT 
    'France' as Country,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) as ReportDate,
    SUM(TotalAmount) as Revenue,
    COUNT(DISTINCT InvoiceNo) as Orders,
    SUM(TotalAmount) / COUNT(DISTINCT InvoiceNo) as AOV
  FROM `uk-retail-europe.clean.online_retail`
  WHERE Country = 'France'
    AND DATE(InvoiceDate) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
    AND IsReturn = FALSE
    AND IsB2B = FALSE
),
Baseline AS (
  SELECT 
    AVG(DailyRevenue) as BaselineRevenue
  FROM (
    SELECT 
      DATE(InvoiceDate) as Date,
      SUM(TotalAmount) as DailyRevenue
    FROM `uk-retail-europe.clean.online_retail`
    WHERE Country = 'France'
      -- Same weekday (Mon, Tue, etc.) over last 4 weeks
      AND EXTRACT(DAYOFWEEK FROM InvoiceDate) = EXTRACT(DAYOFWEEK FROM DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))
      AND DATE(InvoiceDate) BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 28 DAY) AND DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
      AND IsReturn = FALSE
      AND IsB2B = FALSE
    GROUP BY Date
  )
)
SELECT 
  y.Country,
  y.ReportDate,
  y.Revenue as Revenue_Yesterday,
  b.BaselineRevenue as Baseline_SameWeekday,
  ROUND((y.Revenue - b.BaselineRevenue) / b.BaselineRevenue * 100, 1) as Variance_Pct,
  y.Orders,
  ROUND(y.AOV, 2) as AOV
FROM Yesterday y, Baseline b;
