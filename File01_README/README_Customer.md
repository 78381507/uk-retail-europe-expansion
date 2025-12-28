# UK Retail Europe — Executive Project Overview

This repository presents an **end-to-end data analytics project** applied to a UK retail e-commerce dataset, with a strong focus on **business impact, decision support, and automation**.

The objective is to demonstrate how analytics can evolve from **raw data exploration** to **operational and automated business actions**.

---

## 🎯 Business Context

The business faces three major challenges:

- **High customer churn (~63% monthly)** with limited retention visibility  
- **Strong dependency on the UK market (~84% of revenue)**  
- **Under-exploited European (francophone) markets** despite high customer value  

While data exists, decisions were mostly **reactive and manual**.

---

## 🧠 Project Approach

The project follows a clear analytics lifecycle:

**Data → Insight → Action**

1. Centralize and model transactional data  
2. Build decision-oriented dashboards  
3. Translate insights into automated operational workflows  

This ensures analytics is not limited to reporting, but directly supports **business execution**.

---

## 🏗️ Project Structure & Navigation

This project is organized into clearly separated, reusable components:

### 📌 Business Framing
📂 **File02_BUSINESS_CASE**  
Business context, hypotheses, key questions, and success metrics  
➡️ `File02_BUSINESS_CASE/`

---

### 📌 Data & Preparation
📂 **File03_data**  
Dataset description, data quality checks, and preparation notes  
➡️ `File03_data/`

---

### 📌 SQL Analytics & Modeling
📂 **File04_SQL**  
All SQL logic used for:
- Revenue analysis  
- Retention & RFM segmentation  
- Automation logic (alerts & exports)  

➡️ `File04_SQL/`

---

### 📌 Business Intelligence (Dashboards)
📂 **File05_Looker**  
Three Looker Studio dashboards:
- Executive Revenue Overview  
- European Market Expansion  
- Customer Retention & Lifecycle  

➡️ `File05_Looker/`

---

### 📌 Automation & Operations
📂 **File06_Automation**  
Make.com workflows connecting analytics to business action:
- Daily revenue anomaly alert (BigQuery → Slack)
- Weekly “At Risk” customer export (BigQuery → Google Sheets)

➡️ `File06_Automation/`

---

### 📌 Supporting Documentation
📂 **File07_Docs**  
Methodological notes, assumptions, and design decisions  
➡️ `File07_Docs/`

---

### 📌 Executive Presentation
📂 **File08_Assets**  
Final PowerPoint slides and visual assets  
➡️ `File08_Assets/`

---

## 📊 Key Business Insights (Summary)

- **£9.77M total revenue**, with strong seasonality and Q4 peak  
- **Francophone markets represent ~3.1% of revenue** but show **high AOV potential**  
- **1,280 “At Risk” customers identified**, representing **£434K recoverable revenue**  

Retention-focused actions outperform short-term acquisition efforts.

---

## 🤖 Automation — From Insight to Action

### Scenario 1 — Daily Revenue Monitoring
- Daily revenue comparison vs 7-day average
- Automatic anomaly detection (±15%)
- Slack alert **only when action is required**

➡️ See: `File06_Automation/Scenario_01_Daily_Revenue_Alert`

---

### Scenario 2 — Weekly Retention Activation
- RFM-based identification of “At Risk” customers
- Weekly export of top 50 customers by value
- CRM-ready Google Sheets output with recommended actions

➡️ See: `File06_Automation/Scenario_02_At_Risk_Export`

---

## 🧰 Technology Stack

- **Google BigQuery** — Data warehouse & SQL analytics  
- **Looker Studio** — Business dashboards  
- **Make.com** — Workflow automation  
- **Slack** — Operational alerting  
- **Google Sheets** — CRM-ready exports  
- **SQL | Git | Data Modeling**

Built using **free or low-cost tools**, designed to scale.

---

## 📘 Full Documentation

For full explanations, assumptions, and detailed methodology, see:  
➡️ **`File01_README/README_FULL.md`**

---

## 👤 Contact

**François Tilkin**  
Data Analyst | Analytics & Automation

**LinkedIn:** [linkedin.com/in/francois-tilkin](https://www.linkedin.com/in/fran%C3%A7ois-tilkin-1667b138a/)  
**GitHub:** [github.com/78381507](https://github.com/78381507)  
**Email:** tilkinanalytics@gmail.com

---
