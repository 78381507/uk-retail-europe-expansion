# Data - UK Online Retail Dataset

## Source

- **Dataset**: Online Retail (UCI Machine Learning Repository)
- **ID**: 352
- **DOI**: 10.24432/C5BW33
- **License**: Creative Commons Attribution 4.0 International (CC BY 4.0)

---

## Description

Transactions from a UK-based online retailer selling giftware across Europe.

- **Period**: Dec 1, 2010 - Dec 9, 2011 (12 months)
- **Raw rows**: 541,909 transactions
- **Cleaned rows**: 539,392 transactions
- **Countries**: 38 countries including France (8,491 tx), Belgium (2,069 tx), Switzerland (1,877 tx)

---

## Folder Structure

### `/raw/`

Contains the original Excel file `Online Retail.xlsx` downloaded from UCI Machine Learning Repository.

**Do not modify this file.**

### `/processed/`

(Empty - cleaned data stored in BigQuery `clean.online_retail` table)

---

## Schema

| Column | Type | Description |
|--------|------|-------------|
| InvoiceNo | STRING | Invoice number (starts with 'C' if cancellation) |
| StockCode | STRING | Product code |
| Description | STRING | Product name |
| Quantity | INTEGER | Quantity (negative = return) |
| InvoiceDate | TIMESTAMP | Transaction date/time |
| UnitPrice | FLOAT | Unit price (£) |
| CustomerID | FLOAT | Customer ID (NULL = B2B transaction) |
| Country | STRING | Customer country |

---

## BigQuery Import

See Google Colab notebook used for import: `assets/import_colab_screenshots/`

**Import steps:**
1. Load Excel file into Pandas DataFrame
2. Apply data quality rules (see below)
3. Upload to BigQuery `raw.online_retail` table
4. Create cleaned view `clean.online_retail` with quality flags

---

## Data Quality Issues Identified

**Issue 1: Missing CustomerID**
- **Count:** 135,080 rows (25%)
- **Root cause:** B2B transactions (bulk orders without individual customer tracking)
- **Treatment:** Flagged `IsB2B = TRUE`, excluded from consumer analytics

**Issue 2: Negative Quantities**
- **Count:** 10,624 rows
- **Root cause:** Product returns/cancellations
- **Treatment:** Flagged `IsReturn = TRUE`, excluded from revenue calculations

**Issue 3: Invalid Prices**
- **Count:** 2,517 rows
- **Root cause:** Data entry errors (price = 0 or negative)
- **Treatment:** Removed from dataset

**Issue 4: Missing Descriptions**
- **Count:** 1,454 rows
- **Root cause:** Incomplete product catalog
- **Treatment:** Replaced with "Unknown Product"

---

## Data Quality Flags (Added Columns)

| Flag | Logic | Used For |
|------|-------|----------|
| IsReturn | `InvoiceNo LIKE 'C%' OR Quantity < 0` | Exclude returns from revenue |
| IsB2B | `CustomerID IS NULL` | Exclude B2B from consumer analytics |

---

## Usage Notes

**For revenue calculations:**
- Always filter: `WHERE IsReturn = FALSE AND IsB2B = FALSE`
- This ensures clean consumer transaction data only

**For customer analytics:**
- Always filter: `WHERE CustomerID IS NOT NULL AND IsReturn = FALSE AND IsB2B = FALSE`

**Geographic analysis:**
- 38 countries present, but UK dominates (>80% of revenue)
- Francophone focus: France, Belgium, Switzerland

---

## Citation
```
Chen, D. (2015). Online Retail [Dataset]. 
UCI Machine Learning Repository. 
https://doi.org/10.24432/C5BW33
```

---

## License

This dataset is licensed under **Creative Commons Attribution 4.0 International (CC BY 4.0)**.

You are free to:
- **Share** - Copy and redistribute the material
- **Adapt** - Remix, transform, and build upon the material

Under the following terms:
- **Attribution** - You must give appropriate credit and link to the license

Full license: https://creativecommons.org/licenses/by/4.0/

---

## Dataset Statistics

**Period Coverage:** 12 months (Dec 2010 - Dec 2011)

**Transaction Volume:**
- Total transactions: 541,909
- Valid transactions: 539,392 (99.5%)
- Returns: 10,624 (2.0%)
- B2B transactions: 135,080 (25%)

**Geographic Distribution (Top 5):**
1. United Kingdom: 495,478 (91.4%)
2. Germany: 9,495 (1.8%)
3. France: 8,491 (1.6%)
4. EIRE (Ireland): 8,196 (1.5%)
5. Spain: 2,533 (0.5%)

**Product Catalog:**
- Unique products: 4,070
- Most popular product: "WHITE HANGING HEART T-LIGHT HOLDER"

**Customer Base:**
- Identified customers: 4,372
- B2B transactions (no CustomerID): 25% of volume
