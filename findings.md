# Key Findings – Superstore Sales & Profit Analysis
 
## Dataset Overview
- **Period:** January 2011 – December 2014 (4 years)
- **Total Records:** 9,994 orders
- **Regions:** Central, East, South, West
- **Categories:** Furniture, Office Supplies, Technology
 
---
 
## Finding 1: Sales Are Geographically Concentrated
 
The West region leads in total sales ($725,458), followed by East ($678,781), Central ($501,240), and South ($391,722).
 
California alone contributes $457,688 — more than the entire South region. The top 3 states (California, New York, Texas) account for a disproportionate share of total revenue, creating geographic concentration risk.

---

## Finding 2: Technology Leads in Both Sales and Profit — Furniture Misleads
 
| Category | Total Sales | Total Profit | Profit Margin |
|----------|-------------|--------------|---------------|
| Technology | $836,154 | $145,455 | 17.4% |
| Office Supplies | $719,047 | $122,491 | 17.0% |
| Furniture | $741,999 | $18,451 | 2.5% |

- **Technology** is the top-performing category in both sales and profit.
- Sub-categories like **Phones, Machines, and Accessories** are highly profitable.
- Furniture ranks 2nd in sales but delivers only 2.5% margin — nearly 7x lower than Technology. Selling more Furniture does not meaningfully improve the business. e.g., **Tables** has high-revenue but generate losses.
- Loss-making sub-categories: Tables (-$17,726), Bookcases (-$3,473), Supplies (-$1,189).

---

## Finding 3: High Sales Does Not Guarantee Profit
 
Several products with over $10,000 in sales are net loss-makers across their entire sales history:
 
| Product | Total Sales | Total Profit |
|---------|-------------|--------------|
| Cisco TelePresence System EX90 Videoconferencing Unit | $22,638 | -$1,811 |
| Lexmark MX611dhe Monochrome Laser Printer | $16,830 | -$4,590 |
| Cubify CubeX 3D Printer Double Head Print | $11,100 | -$8,880 |
 
The Cubify 3D Printer is the worst case — $11K in revenue but an $8,880 loss. These products need re-pricing or removal.

---

## Finding 4: Discounts Above 20% Consistently Destroy Profit
 
| Discount | Avg Profit per Order |
|----------|----------------------|
| 0% | +$66.90 |
| 10% | +$96.05 |
| 20% | +$24.70 |
| 30% | -$45.68 |
| 40% | -$111.93 |
 
The 10% discount is the sweet spot — it increases average profit above the no-discount baseline. Beyond 20%, every incremental discount generates losses. Discounts are the single strongest driver of losses in this dataset.

---

## Finding 5: Customer Segment — Volume vs Efficiency
 
| Segment | Total Profit | Profit Margin |
|---------|-------------|---------------|
| Consumer | $134,119 | 12.0% |
| Corporate | $91,979 | 13.8% |
| Home Office | $60,299 | 14.7% |
 
Consumer generates the most total profit by volume but Home Office is the most margin-efficient segment. High order frequency does not equal high profitability — some top-revenue customers are low profit due to discount-heavy transactions.

## Finding 6: Ship Mode Is a Proxy for Product Mix, Not an Independent Driver
 
**Surface observation:** First Class shows 13.93% margin vs Standard Class at 12.08%.
 
**Step 1 — Is discount the cause?**
 
| Ship Mode | Avg Discount | Profit Margin |
|-----------|-------------|---------------|
| First Class | 0.165 | 13.93% |
| Standard Class | 0.160 | 12.08% |
| Same Day | 0.152 | 12.38% |
| Second Class | 0.139 | 12.51% |
 
Average discounts are nearly identical (0.139–0.165). Discount does not explain the gap.
 
**Step 2 — Is product mix the cause?**
 
Furniture delivers ~2–3% margin regardless of ship mode. Technology delivers 14–20% regardless of ship mode. Standard Class handles 1,248 Furniture orders vs only 327 for First Class — 4x more low-margin orders by volume.
 
**Step 3 — Controlled test (Technology, 0% discount only):**
 
| Ship Mode | Profit Margin |
|-----------|---------------|
| First Class | 36.66% |
| Same Day | 35.61% |
| Standard Class | 34.08% |
| Second Class | 30.34% |
 
When category and discount are fixed, margins converge across all ship modes. The original gap disappears.
 
**Conclusion:** Ship mode has no independent effect on profitability. It is a proxy for product mix. Pushing customers to First Class shipping would not improve margins — fixing Furniture pricing would.
 
---

## Finding 7: Strong Seasonality — Business Is Q4-Dependent
 
November ($349,120) and December ($332,177) account for ~30% of annual sales. February is consistently the weakest month ($60,173 — less than 18% of November). Year-over-year growth: -2.83% (2012), +29.32% (2013), +20.62% (2014).

---

## Business Recommendations
 
1. **Cap discounts at 20%.** Discounts above this threshold consistently generate net losses. Limiting excessive discounting would significantly improve margins.
 
2. **Review `Tables` sub-category pricing.** It ranks 2nd in sales volume but generates a $17,726 net loss. More volume makes this worse, not better.
 
3. **Remove or reprice the Cubify 3D Printer line.** $11K in sales, $9K in losses. No sales volume justifies keeping this product at its current price.
 
4. **Reduce geographic concentration.** California, New York, and Texas dominate revenue. Targeted expansion in underperforming high-population states would diversify revenue risk.
 
5. **Build Q1/Q2 promotions.** February through April is consistently weak. Structured campaigns in these months could smooth cash flow without cannibalising Q4 peak revenue.