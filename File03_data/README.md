# Data - UK Online Retail Dataset

## Source
- **Dataset**: Online Retail (UCI Machine Learning Repository)
- **ID**: 352
- **DOI**: 10.24432/C5BW33
- **Licence**: Creative Commons Attribution 4.0 International (CC BY 4.0)

## Description
Transactions d'un retailer UK vendant des cadeaux en Europe.
- **Période**: 01/12/2010 - 09/09/2011 (9 mois)
- **Lignes brutes**: 541,909 transactions
- **Lignes nettoyées**: 539,392 transactions
- **Pays**: 38 pays dont France (8,491 tx), Belgique (2,069 tx), Suisse (1,877 tx)

## Structure des dossiers

### `/raw/`
Contient le fichier Excel original `Online Retail.xlsx` téléchargé depuis UCI.
**Ne pas modifier ce fichier.**

### `/processed/`
(Vide - les données nettoyées sont dans BigQuery `clean.online_retail`)

## Schema

| Colonne | Type | Description |
|---------|------|-------------|
| InvoiceNo | STRING | Numéro facture (commence par 'C' si annulation) |
| StockCode | STRING | Code produit |
| Description | STRING | Nom du produit |
| Quantity | INTEGER | Quantité (négatif = retour) |
| InvoiceDate | TIMESTAMP | Date/heure transaction |
| UnitPrice | FLOAT | Prix unitaire (£) |
| CustomerID | FLOAT | ID client (NULL = B2B) |
| Country | STRING | Pays client |

## Import dans BigQuery
Voir notebook Google Colab utilisé : `assets/import_colab_screenshots/`

## Data Quality Issues identifiés
- CustomerID manquants: 135,080 (25%) → Flaggés `IsB2B=TRUE`
- Quantités négatives: 10,624 → Flaggés `IsReturn=TRUE`
- Prix invalides: 2,517 → Supprimés
- Descriptions manquantes: 1,454 → Remplacées par "Unknown Product"

## Citation
```
Chen, D. (2015). Online Retail [Dataset]. 
UCI Machine Learning Repository. 
https://doi.org/10.24432/C5BW33
```
