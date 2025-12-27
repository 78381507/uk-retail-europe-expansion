-- ================================================
-- KPI GEOGRAPHIC - Performance par pays
-- ================================================

-- Vue 1: Performance pays francophones
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_francophone_performance` AS
SELECT 
  f.Country,
  COUNT(DISTINCT InvoiceNo) AS Orders,
  COUNT(DISTINCT CustomerID) AS Customers,
  SUM(TotalAmount) AS Revenue,
  SUM(TotalAmount) / COUNT(DISTINCT InvoiceNo) AS AOV,
  SUM(TotalAmount) / COUNT(DISTINCT CustomerID) AS RevenuePerCustomer
FROM `uk-retail-europe.mart.fact_orders` f
JOIN `uk-retail-europe.mart.dim_geography` g ON f.Country = g.Country
WHERE g.Region = 'Francophone' AND f.IsReturn = FALSE
GROUP BY f.Country;

-- Vue 2: Top produits par pays
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_top_products_by_country` AS
WITH RankedProducts AS (
  SELECT 
    f.Country,
    p.StockCode,
    p.Description,
    SUM(f.Quantity) AS TotalQuantity,
    SUM(f.TotalAmount) AS Revenue,
    ROW_NUMBER() OVER (PARTITION BY f.Country ORDER BY SUM(f.TotalAmount) DESC) AS Rank
  FROM `uk-retail-europe.mart.fact_orders` f
  JOIN `uk-retail-europe.mart.dim_products` p ON f.StockCode = p.StockCode
  WHERE f.IsReturn = FALSE AND f.Country IN ('France', 'Belgium', 'Switzerland')
  GROUP BY f.Country, p.StockCode, p.Description
)
SELECT * FROM RankedProducts WHERE Rank <= 10;

-- Vue 3: Distribution revenue géographique
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_revenue_by_region` AS
SELECT 
  g.Region,
  COUNT(DISTINCT f.InvoiceNo) AS Orders,
  SUM(f.TotalAmount) AS Revenue,
  ROUND(SUM(f.TotalAmount) / (SELECT SUM(TotalAmount) FROM `uk-retail-europe.mart.fact_orders` WHERE IsReturn = FALSE) * 100, 2) AS RevenuePct
FROM `uk-retail-europe.mart.fact_orders` f
JOIN `uk-retail-europe.mart.dim_geography` g ON f.Country = g.Country
WHERE f.IsReturn = FALSE
GROUP BY g.Region;
