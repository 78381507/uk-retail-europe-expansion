# Business Case - UK Retail Europe Expansion

---

## Executive Summary

**Company:** UK-based online retail business specializing in giftware and home décor

**Challenge:** Declining customer retention (63% monthly churn) and untapped growth potential in francophone European markets (France, Belgium, Switzerland)

**Objective:** Build data infrastructure to enable:
1. **Operational monitoring** - Real-time revenue anomaly detection
2. **Market expansion** - Identify francophone growth opportunities
3. **Customer retention** - Systematic reactivation of at-risk customers

**Timeline:** 12-month dataset (Dec 2010 - Nov 2011)

**Stakeholders:**
- **CEO** - Strategic growth decisions (market expansion)
- **Operations Manager** - Daily revenue monitoring
- **Marketing Manager** - Customer retention campaigns
- **CRM Team** - At-risk customer reactivation

---

## Business Context

### **Company Profile**

**Industry:** E-commerce / Online Retail  
**Primary Market:** United Kingdom (84% of revenue)  
**Product Categories:** Giftware, home décor, seasonal items  
**Business Model:** B2C online sales (B2B excluded from analysis)

**Key Characteristics:**
- Strong UK customer base (3,700+ customers)
- High repeat purchase rate (92% of orders from repeat customers)
- Seasonal revenue patterns (Q4 peak)
- Average order value: £411

---

## Problem Statement

### **Challenge 1: Poor Customer Retention**

**Symptoms:**
- 63% monthly churn rate
- Average customer lifetime: 4.4 months
- 1,280 customers (29%) in "At Risk" segment

**Impact:**
- High customer acquisition cost not offset by lifetime value
- Revenue volatility due to customer churn
- Lost revenue opportunity: £434K from At Risk segment alone

**Root Cause:**
- No systematic reactivation strategy
- Manual monitoring (no alerts for customer inactivity)
- Marketing team lacks actionable customer lists

---

### **Challenge 2: Untapped Francophone Market**

**Symptoms:**
- France, Belgium, Switzerland = only 3.14% of total revenue (£307K)
- 40x smaller than UK market (£8.23M)

**Opportunity Indicators:**
- **Switzerland AOV £1,106** (2x France, 2.6x UK) → Premium market potential
- **Switzerland Revenue/Customer £2,688** (highest) → Premium customer quality
- **Belgium Revenue/Customer £1,647** → Strong mid-tier engagement
- Francophone markets show same Q4 seasonality → Product-market fit exists

**Barriers:**
- No dedicated market analysis
- No localized product strategy
- Operations team lacks visibility into francophone performance

---

### **Challenge 3: Reactive Operations**

**Current State:**
- Revenue monitoring via manual dashboard checks
- No automated alerts for anomalies
- Incident response delayed by 24-48 hours

**Impact:**
- Missed early warning signals (revenue drops, stock issues)
- Delayed corrective actions
- Operational inefficiency (manual reporting)

---

## Proposed Solution

### **Phase 1: Data Infrastructure (Foundation)**

**Deliverables:**
1. **BigQuery Data Warehouse**
   - Centralized data storage (clean, validated)
   - Dimensional model (customers, geography, products)
   - Business metrics layer (pre-aggregated KPIs)

2. **Data Quality Framework**
   - Automated cleaning (returns, duplicates, invalid records)
   - Flagging system (IsReturn, IsB2B)
   - Validation rules (positive amounts, valid dates)

**Timeline:** Week 1-2  
**Stakeholders:** Data team, IT  
**Success Criteria:** 100% data accuracy, <1% rejected records

---

### **Phase 2: Business Intelligence Dashboards**

**Dashboard 1: Executive Overview**
- **Audience:** CEO, Finance Director
- **Purpose:** High-level business health monitoring
- **Key Metrics:** Total revenue, orders, AOV, customer count
- **Insights:** UK dominance, Q4 seasonality, geographic distribution
- **Update Frequency:** Daily

**Dashboard 2: Francophone Expansion**
- **Audience:** CEO, Sales Director, Market Expansion Team
- **Purpose:** Identify growth opportunities in France/Belgium/Switzerland
- **Key Metrics:** Francophone revenue share, country-level AOV, top products
- **Insights:** Switzerland premium potential, Belgium lifecycle model, product localization needs
- **Update Frequency:** Weekly

**Dashboard 3: Retention Analysis**
- **Audience:** CMO, CRM Manager, Marketing Team
- **Purpose:** Reduce churn, identify at-risk customers
- **Key Metrics:** Retention rate, churn rate, RFM segments, cohort retention
- **Insights:** 63% churn problem, 90-day critical window, Champions product mix
- **Update Frequency:** Weekly

**Timeline:** Week 3-6  
**Tools:** Looker Studio (Google Data Studio)  
**Success Criteria:** Dashboards accessed 3x/week by stakeholders

---

### **Phase 3: Automation & Alerts**

**Automation 1: Daily Revenue Alert (Slack)**
- **Trigger:** Every day 09:00 UTC
- **Logic:** Compare France revenue vs 7-day avg, alert if ±15% variance
- **Output:** Slack message to #operations channel
- **Benefit:** Rapid response to revenue anomalies (same-day vs 2-day delay)

**Automation 2: Weekly At-Risk Export (Google Sheets)**
- **Trigger:** Every Monday 08:00 UTC
- **Logic:** Export top 50 At-Risk customers (low recency, high historical frequency)
- **Output:** Google Sheets with CustomerID, Country, Spend, Recommended Action
- **Benefit:** Marketing team has actionable list for weekly reactivation campaigns

**Timeline:** Week 7-8  
**Tools:** Make.com, BigQuery, Slack, Google Sheets  
**Success Criteria:** 0 false alerts, 100% email delivery, <5 min latency

---

## Expected Business Impact

### **Quantified Outcomes (12-Month Projection)**

**Retention Improvement:**
- **Baseline:** 63% monthly churn
- **Target:** 50% monthly churn (via weekly At-Risk campaigns)
- **Assumption:** 20% of At-Risk customers reactivated
- **Impact:** £87K recovered revenue (20% of £434K At-Risk segment)

**Francophone Market Growth:**
- **Baseline:** £307K annual revenue (3.14% share)
- **Target:** £614K (double revenue, 6% share)
- **Strategy:** Localized product bundles (Switzerland premium, France décor)
- **Impact:** £307K incremental revenue

**Operational Efficiency:**
- **Baseline:** 4 hours/week manual reporting
- **Target:** 0.5 hours/week (automated alerts)
- **Impact:** 3.5 hours/week saved = £7K annual labor cost savings (at £40/hour)

**Total Annual Impact:** £401K revenue + £7K cost savings = **£408K**

---

## Success Metrics

### **KPIs to Track (Quarterly)**

**Customer Retention:**
- Monthly churn rate
- % At-Risk customers reactivated
- Average customer lifetime (months)

**Market Expansion:**
- Francophone revenue % (target: 6%)
- Switzerland AOV maintenance (>£1,000)
- New customer acquisition (France/Belgium)

**Operational:**
- Alert accuracy (false positive rate <5%)
- Dashboard usage frequency (3+ sessions/week per user)
- Incident response time (anomaly detection to action)

---

## Risks & Mitigations

**Risk 1: Data Quality Issues**
- **Mitigation:** Automated validation rules, manual spot-checks
- **Contingency:** Fallback to source data if warehouse inconsistencies detected

**Risk 2: Alert Fatigue**
- **Mitigation:** Conservative thresholds (±15%), minimum revenue filter (£1,000)
- **Contingency:** Weekly review of alert relevance, threshold adjustment

**Risk 3: Low At-Risk Reactivation Rate**
- **Mitigation:** A/B test recommended actions (voucher vs free shipping)
- **Contingency:** Refine segment definition (R/F/M thresholds)

**Risk 4: Francophone Market Saturation**
- **Mitigation:** Continuous product analysis (Champions vs general population)
- **Contingency:** Pivot to other EU markets (Germany, Netherlands)

---

## Investment Required

**Technology Costs:**
- Google Cloud BigQuery: $50/month (dataset size <10GB)
- Looker Studio: Free tier (sufficient for 3 dashboards)
- Make.com: Free tier (1,000 ops/month = 30 daily + 4 weekly)
- Slack: Existing workspace (no incremental cost)

**Labor Costs:**
- Data analyst time: 8 weeks @ 20 hours/week = 160 hours
- Stakeholder review meetings: 10 hours
- Total: 170 hours @ $60/hour = **$10,200**

**Total Investment:** $10,800 (6 months)

**ROI:** £408K impact / $10.8K investment = **37x ROI** (assuming 50% attribution)

---

## Timeline

**Week 1-2:** Data infrastructure setup (BigQuery, cleaning, validation)  
**Week 3-4:** Dashboard 1 (Executive Overview)  
**Week 5:** Dashboard 2 (Francophone Expansion)  
**Week 6:** Dashboard 3 (Retention Analysis)  
**Week 7-8:** Automation setup (alerts, exports)  
**Week 9-12:** Stakeholder training, iteration, optimization

**Total Duration:** 12 weeks

---

## Stakeholder Buy-In

**CEO:** "I need visibility into francophone growth potential before committing marketing budget."  
→ **Solution:** Dashboard 2 (Francophone Expansion) provides data-driven market sizing

**CMO:** "We're losing customers faster than we're acquiring them. I need a systematic retention strategy."  
→ **Solution:** Dashboard 3 (RFM analysis) + Weekly At-Risk export

**Operations Manager:** "I find out about revenue issues 2 days too late."  
→ **Solution:** Daily revenue alerts (Slack) with <5 min latency

---

## Conclusion

This project transforms raw transaction data into actionable business intelligence:
- **Strategic layer:** Market expansion insights (Dashboard 2)
- **Operational layer:** Real-time monitoring (Automation 1)
- **Tactical layer:** Customer retention workflows (Dashboard 3 + Automation 3)

**Expected outcome:** £408K annual impact for £10.8K investment (37x ROI)

**Next steps:**
1. Stakeholder approval (Week 0)
2. Data infrastructure buildout (Week 1-2)
3. Dashboard deployment (Week 3-6)
4. Automation launch (Week 7-8)
5. Performance review (Week 12)

---

**Document Owner:** François Tilkin  
**Last Updated:** December 2025  
**Status:** Implementation Complete (Portfolio Version)
