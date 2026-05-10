# 🛒 Consumer Behaviour Analysis & Churn Prediction — Olist E-Commerce

> **97% of customers never buy again.** This project finds out why — and which ones are still recoverable.



---

## 📌 Business Problem

Olist is a Brazilian e-commerce marketplace hosting thousands of third-party sellers. Despite strong revenue growth (3× in 18 months), nearly all customers purchase only once and never return. This project analyses 100,000+ transactions to understand customer behaviour, identify churn drivers, and build a predictive model to flag at-risk customers before they are lost.

---

## 🔍 Key Findings

- **97% of customers never repurchase** — the central retention problem driving this entire analysis
- **5-star reviews correlate with early delivery**, not just on-time delivery — customers anchor expectations to the estimated date shown at checkout, meaning conservative estimates could improve scores at zero logistics cost
- **49% of customers are Lost or At Risk** based on RFM segmentation — only ~12% qualify as Champions or Loyal
- **Recency is the dominant churn predictor** — customers inactive for 90+ days show 80%+ churn probability
- **beleza_saude (health & beauty) is the top revenue category**, followed by relogios_presentes and cama_mesa_banho


## 🛠️ Tech Stack

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![Scikit-learn](https://img.shields.io/badge/Scikit--learn-F7931E?style=flat&logo=scikit-learn&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=flat&logo=streamlit&logoColor=white)

---



## ⚙️ How to Run

### 1. Set up MySQL database
```sql
CREATE DATABASE olist;
USE olist;
```
Import all Olist CSV files using MySQL Workbench Table Data Import Wizard or LOAD DATA.
Run scripts in `sql/create_tables.sql` to set up the schema.

### 2. Run the Python notebooks
```bash
pip install pandas matplotlib seaborn scikit-learn mysql-connector-python streamlit
jupyter notebook
```
Run notebooks in this order:
1. `eda.ipynb`
2. `rfm_segmentation.ipynb`
3. `churn_model.ipynb`

### 3. Launch the Streamlit app
```bash
streamlit run app/app.py
```

### 4. Open the Power BI dashboard
Open `powerbi/olist_dashboard.pbix` in Power BI Desktop.
Update the MySQL connection: Home → Transform data → Data source settings → update credentials.

---

## 📊 Analysis Walkthrough

### Step 1 — SQL (MySQL)
Queried 100,000+ records across 8 relational tables using joins, aggregations, window functions, and date arithmetic to extract:
- Revenue by product category
- Monthly sales trends (2016–2018)
- Delivery delay vs review score correlation
- Customer repeat purchase rate
- Seller performance KPIs (revenue, avg review, cancellation rate)

### Step 2 — Python EDA
```python
# Key insight: delivery timing drives review scores
orders['delay_days'] = (
    orders['order_delivered_customer_date'] -
    orders['order_estimated_delivery_date']
).dt.days

# 5-star reviews average -9.3 days delay (arrived early)
# 1-star reviews average +18.6 days delay (arrived very late)
```

### Step 3 — RFM Segmentation
Classified 99,000+ customers into 5 segments:

| Segment | Count | Description |
|---|---|---|
| Champions | ~11,825 | Bought recently, often, high spend |
| Loyal | ~23,308 | Regular buyers, good spend |
| Potential Loyalist | ~11,667 | Recent buyers, low frequency |
| At Risk | ~23,230 | Haven't bought in a while |
| Lost | ~23,328 | Long inactive, unlikely to return |

### Step 4 — Churn Prediction
```python
# Define churn: inactive 180+ days
rfm['churned'] = (rfm['recency'] > 180).astype(int)

# Random Forest classifier
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# AUC-ROC: 0.86
# Top feature: recency (0.72 importance)
```

### Step 5 — Power BI Dashboard
4 KPI cards + revenue by category bar chart + monthly trend line + RFM segment donut chart, connected directly to MySQL via MySQL Connector with slicer-driven cross-filtering.

---

## 💡 Business Recommendations

1. **Trigger re-engagement campaigns at 60 days**, not after churn occurs — recency is the strongest predictor and the window closes fast
2. **Set conservative delivery estimates** at checkout — arriving before the estimate drives 5-star reviews more reliably than improving actual speed
3. **Focus retention spend on Champions and Loyal segments** — they drive disproportionate revenue despite being <25% of the customer base
4. **Investigate high-revenue sellers with low review scores** — they generate income but damage platform trust

---

## 📂 Dataset

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle

100,000+ orders from 2016–2018 across 8 relational CSV files.

---

## 👩‍💻 Author

**Geetanjali Sharma**
[LinkedIn](https://linkedin.com/in/geetanjalisharma) · [GitHub](https://github.com/Geetanjalishrma)
