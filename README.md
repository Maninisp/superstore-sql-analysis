# 🛒 Superstore Sales SQL Analysis (PostgreSQL)

## 📌 Project Overview
This project analyzes retail sales data using SQL to extract business insights related to sales, profitability, and discount impact.

---

## 📊 Dataset
- Source: Superstore dataset
- Contains information on orders, customers, products, sales, profit, and discounts

---

## 🎯 Key Questions Explored
- Which regions and states generate the highest sales?
- Which categories and sub-categories are most profitable?
- Which products and sub-categories are loss-making?
- How do discounts impact profit and quantity sold?
- What are the monthly sales trends?

---

## 🔍 Key Insights
- The West region generated the highest sales.
- Technology category is the most profitable.
- Some sub-categories like Tables are consistently loss-making.
- Higher discounts increase sales volume but reduce profitability.
- Profit per unit decreases significantly with higher discounts.

---

## 🛠️ Tools Used
- PostgreSQL
- SQL (Aggregation, GROUP BY, HAVING, Window Functions)

---

## 📂 Project Structure
```
sql-data-analysis/
├── data/
│   └── superstore.csv
├── queries/
│   ├── 01_exploration.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_profit_analysis.sql
├── schema.sql
├── findings.md
└── README.md
```


---

## 🚀 How to Run
1. Create a database in PostgreSQL
2. Run `schema.sql` to create the table
3. Import CSV using pgAdmin Import Tool
4. Execute queries from the `queries` folder

---

## ⚠️ Common Issues & Fixes
- **Encoding Error**: If import fails with UTF-8, try LATIN1 or WIN1252
- **Permission Error**: Use pgAdmin Import Tool instead of COPY
