# Setup Guide - Import des données

## Prérequis
- Compte Google Cloud avec projet BigQuery créé
- Connexion Internet

## Étape 1 : Télécharger le dataset
Source : https://archive.ics.uci.edu/dataset/352/online+retail

## Étape 2 : Import via Google Colab

### Pourquoi Google Colab ?
- Évite les erreurs de parsing CSV (caractères spéciaux, encodage)
- Utilise la librairie officielle UCI (`ucimlrepo`)
- Gratuit, dans le navigateur, zéro installation locale

### Procédure

**1. Ouvrir Google Colab**
- https://colab.research.google.com/
- Nouveau notebook

**2. Installer les bibliothèques** (Cellule 1)
```python
!pip install ucimlrepo google-cloud-bigquery db-dtypes
```

**3. Authentification Google** (Cellule 2)
```python
from google.colab import auth
auth.authenticate_user()
print("✅ Authentification OK")
```

**4. Créer le dataset BigQuery** (Cellule 3)
```python
from google.cloud import bigquery

client = bigquery.Client(project='uk-retail-europe')
dataset_id = 'uk-retail-europe.raw'
dataset = bigquery.Dataset(dataset_id)
dataset.location = 'EU'
dataset = client.create_dataset(dataset, exists_ok=True)
print(f"✅ Dataset {dataset_id} créé")
```

**5. Import des données** (Cellule 4)
```python
from ucimlrepo import fetch_ucirepo

# Télécharge depuis UCI
online_retail = fetch_ucirepo(id=352)
df = online_retail.data.original

# Import dans BigQuery
table_id = 'uk-retail-europe.raw.online_retail'
job = client.load_table_from_dataframe(df, table_id)
job.result()

print(f"✅ Import terminé: {len(df)} lignes")
```

### Résultat attendu
- Table `raw.online_retail` créée
- 541,909 lignes importées
- Temps total : ~2-3 minutes

## Étape 3 : Vérification
Dans BigQuery :
```sql
SELECT COUNT(*) FROM `uk-retail-europe.raw.online_retail`;
-- Résultat attendu : 541,909
```

## Captures d'écran
Voir `/assets/colab_import_screenshots/`
