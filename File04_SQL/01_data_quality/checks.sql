-- ================================================
-- DATA QUALITY CHECKS - Online Retail Dataset
-- ================================================
-- Objectif: Identifier les problèmes dans raw.online_retail

-- CHECK 1: Lignes avec valeurs nulles
SELECT 
  'Missing InvoiceNo' AS check_name,
  COUNT(*) AS count_issues
FROM `uk-retail-europe.raw.online_retail`
WHERE InvoiceNo IS NULL

UNION ALL

SELECT 
  'Missing CustomerID' AS check_name,
  COUNT(*) AS count_issues
FROM `uk-retail-europe.raw.online_retail`
WHERE CustomerID IS NULL

UNION ALL

SELECT 
  'Missing Description' AS check_name,
  COUNT(*) AS count_issues
FROM `uk-retail-europe.raw.online_retail`
WHERE Description IS NULL OR TRIM(Description) = '';

-- CHECK 2: Quantités négatives (retours/annulations)
SELECT 
  'Negative Quantity' AS check_name,
  COUNT(*) AS count_issues
FROM `uk-retail-europe.raw.online_retail`
WHERE Quantity < 0;

-- CHECK 3: Prix unitaires invalides
SELECT 
  'Invalid UnitPrice' AS check_name,
  COUNT(*) AS count_issues
FROM `uk-retail-europe.raw.online_retail`
WHERE UnitPrice <= 0;
