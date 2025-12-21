-- ================================================
-- KPI RFM - Segmentation clients
-- ================================================

-- Vue 1: Calcul scores RFM
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_rfm_scores` AS
WITH RFMData AS (
  SELECT 
    CustomerID,
    Country,
    DATE_DIFF(CURRENT_DATE(), MAX(DATE(InvoiceDate)), DAY) AS Recency,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    SUM(TotalAmount) AS Monetary
  FROM `uk-retail-europe.mart.fact_orders`
  WHERE CustomerID IS NOT NULL AND IsReturn = FALSE
  GROUP BY CustomerID, Country
),
RFMScores AS (
  SELECT 
    *,
    NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(5) OVER (ORDER BY Frequency) AS F_Score,
    NTILE(5) OVER (ORDER BY Monetary) AS M_Score
  FROM RFMData
)
SELECT 
  CustomerID,
  Country,
  Recency,
  Frequency,
  Monetary,
  R_Score,
  F_Score,
  M_Score,
  CONCAT(CAST(R_Score AS STRING), CAST(F_Score AS STRING), CAST(M_Score AS STRING)) AS RFM_Segment
FROM RFMScores;

-- Vue 2: Distribution segments RFM
CREATE OR REPLACE VIEW `uk-retail-europe.mart.v_rfm_distribution` AS
SELECT 
  CASE 
    WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4 THEN 'Champions'
    WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Loyal Customers'
    WHEN R_Score >= 4 THEN 'Recent Customers'
    WHEN F_Score >= 4 THEN 'Frequent Buyers'
    WHEN M_Score >= 4 THEN 'Big Spenders'
    WHEN R_Score <= 2 THEN 'At Risk'
    ELSE 'Regular'
  END AS Segment,
  COUNT(*) AS CustomerCount,
  SUM(Monetary) AS TotalRevenue
FROM `uk-retail-europe.mart.v_rfm_scores`
GROUP BY Segment;
