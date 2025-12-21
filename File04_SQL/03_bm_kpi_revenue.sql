-- ================================================
-- KPI REVENUE - Métriques revenus et croissance
-- ================================================

-- Vue 1: Revenue mensuel par pays
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_revenue_monthly` AS
SELECT 
  YearMonth,
  Country,
  Region,
  SUM(TotalAmount) AS Revenue,
  COUNT(DISTINCT InvoiceNo) AS Orders,
  COUNT(DISTINCT CustomerID) AS UniqueCustomers,
  SUM(TotalAmount) / COUNT(DISTINCT InvoiceNo) AS AOV
FROM `uk-retail-europe.mart.fact_orders` f
LEFT JOIN `uk-retail-europe.mart.dim_geography` g ON f.Country = g.Country
WHERE IsReturn = FALSE AND IsB2B = FALSE
GROUP BY YearMonth, Country, Region;

-- Vue 2: Croissance MoM (Month over Month)
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_revenue_growth` AS
SELECT 
  YearMonth,
  Revenue,
  LAG(Revenue) OVER (ORDER BY YearMonth) AS PrevMonthRevenue,
  ROUND((Revenue - LAG(Revenue) OVER (ORDER BY YearMonth)) / LAG(Revenue) OVER (ORDER BY YearMonth) * 100, 2) AS GrowthPct
FROM (
  SELECT YearMonth, SUM(TotalAmount) AS Revenue
  FROM `uk-retail-europe.mart.fact_orders`
  WHERE IsReturn = FALSE
  GROUP BY YearMonth
);
