# Automation - Make.com Daily Revenue Alert

## Business Context

**Objective:** Monitor France market revenue anomalies and alert operations team via Slack when significant variance is detected.

**Use Case:** Daily automated surveillance replacing manual dashboard checks, enabling rapid response to revenue drops or unexpected spikes.

---

## Scenario 1: Daily Revenue Alert (BigQuery → Slack)

### **Workflow Overview**

**3 modules:**
1. **Google BigQuery - Run a Query** → Execute revenue analysis SQL
2. **Filter - "Send only if alert"** → Gate alerts based on threshold
3. **Slack - Send a Message** → Post formatted alert to channel

**Trigger:** Scheduled daily (can be configured to 09:00 UTC in production)

---

### **Alert Logic**

**Threshold:** Revenue change ≥ 15% vs 7-day average

**Condition (BigQuery output):**
```sql
is_alert = (ABS(pct_change) >= 15)
```

**Filter rule (Make.com):**
- IF `is_alert = true` → Send Slack message
- ELSE → Skip (no noise in Slack channel)

---

### **Slack Message Format**

**Channel:** `#new-channel` (configurable)

**Message template:**
```
[UK Retail] Daily Revenue Alert - France

Date: {target_date}
Revenue: {revenue_target}
Avg 7d: {avg_7d}
Change: {pct_change}%

Rule: alert if |change| >= 15%
```

**Dynamic fields:** All values populated from BigQuery query results

---

### **SQL Query**

**File:** [daily_revenue_alert.sql](sql/daily_revenue_alert.sql)

**Logic:**
- Compare yesterday's France revenue vs 7-day rolling average
- Calculate percentage change
- Set `is_alert` flag if threshold crossed

---

### **Screenshots**

**Workflow (Make.com):**
![Complete Workflow](screenshots/01_make_workflow_complete.png)

**Filter Inspector:**
![Filter Condition](screenshots/02_make_filter_inspector.png)

**Slack Configuration:**
![Slack Module Setup](screenshots/03_slack_config.png)

**Slack Message Received:**
![Alert in Slack Channel](screenshots/04_slack_message_received.png)

---

### **Technical Notes**

**Challenges resolved:**
- BigQuery "illegal character" errors from copy-paste → Solution: Manual query rewrite in Make editor
- Filter logic validation → Confirmed via Filter Inspector (`is_alert = true`)

**Make.com operations:** ~30/month (1 query/day)

**Slack integration:** Webhook-based (no OAuth required)

---

## Status

✅ **Scenario 1 completed and validated**
- BigQuery query executes successfully
- Filter gates alerts correctly (no false positives)
- Slack messages delivered with formatted content

---

## Tech Stack

- **Make.com** - Workflow automation platform
- **Google BigQuery** - Data warehouse & SQL engine
- **Slack** - Alert delivery channel

---

## Future Enhancements (Optional)

- Add Baseline comparison (same weekday, 4-week avg) for retail seasonality
- Multi-country alerts (UK, France, Belgium) in single scenario
- Slack thread replies with diagnostic queries (top products, order breakdown)

---

## Setup Instructions

**Prerequisites:**
1. Make.com account (Free tier: 1,000 ops/month)
2. Google Cloud project with BigQuery enabled
3. Slack workspace with incoming webhook configured

**Steps:**
1. Import `scenario_1_daily_alert.json` into Make.com
2. Configure BigQuery connection (service account with `bigquery.jobs.create` permission)
3. Update Slack webhook URL and target channel
4. Set schedule trigger (recommended: daily 09:00 UTC)
5. Test with "Run once" before activating

---

## Evidence

All screenshots demonstrate end-to-end functionality:
- Query execution
- Filter logic
- Slack delivery
