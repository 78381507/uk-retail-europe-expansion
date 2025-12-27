-- Table dimension geography
CREATE OR REPLACE TABLE `uk-retail-europe.mart.dim_geography` AS
SELECT DISTINCT
  Country,
  CASE 
    WHEN Country IN ('France', 'Belgium', 'Switzerland') THEN 'Francophone'
    WHEN Country = 'United Kingdom' THEN 'UK'
    WHEN Country IN ('Germany', 'Spain', 'Italy', 'Netherlands', 'Portugal') THEN 'Europe West'
    ELSE 'Other'
  END AS Region
FROM `uk-retail-europe.clean.online_retail`
WHERE Country IS NOT NULL;
