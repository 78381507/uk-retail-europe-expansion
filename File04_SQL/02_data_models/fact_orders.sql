-- Table de faits - orders
CREATE OR REPLACE TABLE `uk-retail-europe.mart.fact_orders` AS
SELECT 
  InvoiceNo,
  InvoiceDate,
  CustomerID,
  StockCode,
  Country,
  Quantity,
  UnitPrice,
  TotalAmount,
  IsReturn,
  IsB2B,
  EXTRACT(YEAR FROM InvoiceDate) AS Year,
  EXTRACT(MONTH FROM InvoiceDate) AS Month,
  FORMAT_TIMESTAMP('%Y-%m', InvoiceDate) AS YearMonth
FROM `uk-retail-europe.clean.online_retail`;
