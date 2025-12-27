-- Table dimension customers
CREATE OR REPLACE TABLE `uk-retail-europe.mart.dim_customers` AS
SELECT 
  CustomerID,
  Country,
  MIN(InvoiceDate) AS FirstPurchaseDate,
  MAX(InvoiceDate) AS LastPurchaseDate,
  COUNT(DISTINCT InvoiceNo) AS TotalOrders,
  SUM(TotalAmount) AS TotalRevenue
FROM `uk-retail-europe.clean.online_retail`
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID, Country;
