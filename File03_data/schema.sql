-- Schema BigQuery - raw.online_retail
-- Source: UCI Machine Learning Repository (Dataset ID 352)
-- Import: Google Colab via ucimlrepo package
-- Date import: [ta date]

CREATE TABLE `uk-retail-europe.raw.online_retail` (
  InvoiceNo STRING,
  StockCode STRING,
  Description STRING,
  Quantity INT64,
  InvoiceDate STRING,
  UnitPrice FLOAT64,
  CustomerID FLOAT64,
  Country STRING
);

-- 541,909 lignes importées
