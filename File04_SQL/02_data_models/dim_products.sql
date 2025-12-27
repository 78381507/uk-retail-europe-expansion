-- Table dimension products
CREATE OR REPLACE TABLE `uk-retail-europe.mart.dim_products` AS
SELECT 
  StockCode,
  Description,
  AVG(UnitPrice) AS AvgPrice,
  COUNT(DISTINCT InvoiceNo) AS TimesOrdered
FROM `uk-retail-europe.clean.online_retail`
WHERE StockCode IS NOT NULL
GROUP BY StockCode, Description;
