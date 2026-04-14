# Superstore Sales SQL Analysis
 
End-to-end SQL analysis of 4 years of retail transaction data (2011–2014) to identify profitability drivers, loss-making products, discount impact, and sales trends. The analysis is structured to move from surface-level observations to controlled root-cause investigation.
 
---
 
## Dataset
 
- **Source:** [Superstore Sales Dataset — Kaggle](https://www.kaggle.com/datasets/ishanshrivastava28/superstore-sales)
- **Size:** 9,994 orders across 4 years (2011–2014)
- **Database:** PostgreSQL
- **Columns:** Order details, customer info, geography, product category, sales, quantity, discount, profit
 
---
 
## Objectives
 
- Identify top-performing regions, products, and customers
- Analyse sales trends and seasonality
- Detect loss-making products and sub-categories
- Understand how discount levels affect profitability
- Evaluate customer segments and shipping mode efficiency
- Perform controlled root-cause analysis on apparent patterns
 
---
 
## Key Findings
 
1. California alone ($457K) outsells the entire South region — heavy geographic concentration
2. Furniture ranks 2nd in sales but delivers only 2.5% margin vs Technology's 17.4%
3. Several high-revenue products are net loss-makers across their full sales history
4. Discounts above 20% consistently generate losses — 10% is the sweet spot
5. Ship mode margin differences are explained entirely by product mix, not shipping speed
6. November–December account for ~30% of annual sales — strong Q4 dependency
 
Full analysis with data: [findings.md](./findings.md)
 

---

## Tools Used
- PostgreSQL
- SQL:
  - Aggregations (SUM, AVG, COUNT)
  - GROUP BY & HAVING
  - Joins & Subqueries
  - Data Analysis & Business Insights

---

## Project Structure
```
sql-data-analysis/
├── data/
│   └── superstore.csv
├── schema/
│   ├── create_table.sql
│   └── alter_columns.sql
├── queries/
│   ├── 01_exploration.sql
│   ├── 02_sales_analysis.sql
│   └── 03_profit_analysis.sql
├── findings.md
└── README.md
```
 
---
 
## How to Run
 
1. Install PostgreSQL and pgAdmin
2. Create a database (e.g. `sql_analysis`)
3. Run `CREATE_TABLE.sql` to create the table
4. Import `data/superstore.csv` via pgAdmin Import/Export wizard (Header: ON, Delimiter: comma)
4. Execute queries from the `queries` folder

---

## Common Issues & Fixes
- **Encoding Error**: If import fails with UTF-8, try LATIN1 or WIN1252
- **Permission Error**: Use pgAdmin Import Tool instead of COPY

---

## What I Learned
 
Writing SQL is not enough — structuring the analysis is equally important. GROUP BY determines the level of aggregation and introducing too many dimensions at once produces noise rather than insight. I learned this directly when trying to analyse ship mode profitability across state and discount simultaneously — the result was 200+ rows with no clear pattern. Breaking it into three focused queries revealed the answer immediately.
 
The most important analytical skill this project reinforced: never accept a surface-level correlation as an explanation. The apparent profitability difference between First Class and Standard Class shipping looked meaningful until controlled analysis (fixing category and discount) showed it was entirely explained by product mix. This is called controlling for confounding variables — the ship mode result was a proxy, not a cause.
 
---


## Future Improvements
- Add advanced SQL techniques (CTEs, Window Functions) as I gain deeper understanding  
- Explore more business questions to extend analysis  
- Optimize queries for performance and readability

---