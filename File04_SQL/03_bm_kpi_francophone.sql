-- Vue principale : Performance francophone
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_francophone_performance` AS
SELECT 
  g.Country,
  COUNT(DISTINCT f.InvoiceNo) as Orders,
  COUNT(DISTINCT f.CustomerID) as Customers,
  SUM(f.TotalAmount) as Revenue,
  SUM(f.TotalAmount) / COUNT(DISTINCT f.InvoiceNo) as AOV,
  SUM(f.TotalAmount) / COUNT(DISTINCT f.CustomerID) as RevenuePerCustomer
FROM `uk-retail-europe.clean.online_retail` f
JOIN `uk-retail-europe.mart.dim_geography` g ON f.Country = g.Country
WHERE g.Region = 'Francophone'
  AND f.IsReturn = FALSE
  AND f.IsB2B = FALSE
GROUP BY g.Country;

-- Vue : Revenue mensuel francophone
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_revenue_monthly_francophone` AS
SELECT 
  YearMonth,
  PARSE_DATE("%Y-%m", YearMonth) as YearMonthDate,
  Country,
  Revenue,
  Orders,
  UniqueCustomers,
  AOV
FROM `uk-retail-europe.mart.v_revenue_monthly`
WHERE Country IN ('France', 'Belgium', 'Switzerland');

-- Vue : Top 3 produits par pays francophone
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_top3_products_francophone` AS
WITH RankedProducts AS (
  SELECT 
    Country,
    Description,
    Revenue,
    ROW_NUMBER() OVER (PARTITION BY Country ORDER BY Revenue DESC) as rn
  FROM `uk-retail-europe.mart.v_top_products_by_country`
  WHERE Country IN ('France', 'Belgium', 'Switzerland')
)
SELECT Country, Description, Revenue
FROM RankedProducts
WHERE rn <= 3;
