# Data Models - Star Schema

Architecture dimensionnelle créée le [date]:

## Tables Dimension
- **dim_geography** : 38 pays (focus Francophone: France, Belgique, Suisse)
- **dim_customers** : 4,379 clients uniques
- **dim_products** : 4,177 produits distincts

## Table de Faits
- **fact_orders** : 539,392 transactions (Dec 2010 - Sept 2011)

## Colonnes clés
- IsReturn: Flag retours/annulations
- IsB2B: Flag transactions sans CustomerID
- YearMonth: Agrégation temporelle
