-- =============================================================================
-- WEEKLY AT RISK CUSTOMERS EXPORT
-- =============================================================================
-- Purpose: Export "At Risk" RFM segment customers for marketing reactivation
-- Used by: Make.com Scenario 3 (Weekly Google Sheets Export)
-- Schedule: Every Monday 08:00 UTC
-- Output: Top 50 At Risk customers sorted by spend (highest value first)
-- =============================================================================

SELECT 
  r.CustomerID,
  c.Country,
  r.Recency as DaysSinceLastPurchase,
  r.Frequency as TotalOrders,
  ROUND(r.Monetary, 2) as TotalSpend,
  'At Risk' as Segment,
  CASE 
    WHEN r.Monetary >= 500 THEN '10% voucher'
    WHEN r.Frequency >= 3 THEN 'Free shipping offer'
    ELSE 'Welcome bundle'
  END as RecommendedAction
FROM `uk-retail-europe.mart.v_rfm_scores` r
JOIN `uk-retail-europe.mart.dim_customers` c ON r.CustomerID = c.CustomerID
WHERE r.R_Score <= 2  -- Low recency (haven't purchased recently)
  AND r.F_Score >= 2  -- Moderate/high frequency (were active customers)
ORDER BY r.Monetary DESC
LIMIT 50;

-- Business Logic:
-- At Risk = Customers who purchased frequently in the past but haven't recently
-- Criteria: Low Recency (R ≤ 2) + Moderate Frequency (F ≥ 2)
-- Action: Targeted reactivation based on customer value
