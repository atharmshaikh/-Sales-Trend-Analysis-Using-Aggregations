
# Task 6: Sales Trend Analysis Using Aggregations

## Objective
Analyze monthly revenue and order volume from the online sales dataset using SQL aggregation techniques.

## Tools Used
- DB Browser for SQLite
- SQL (SQLite syntax)
- Dataset Source: [Kaggle - Online Sales Dataset](https://www.kaggle.com/datasets/yusufdelikkaya/online-sales-dataset)

## Dataset Overview
The dataset contains sales transaction records including:
- `InvoiceNo` (Order ID)
- `InvoiceDate` (Order date and time)
- `Quantity` (Number of items sold)
- `UnitPrice` (Price per unit)
- `Discount` (Percentage discount on the order)
- `ReturnStatus` (Indicates whether the item was returned)

## Data Cleaning
- Removed records with returned items (`ReturnStatus = 'Returned'`)
- Excluded rows with non-positive `Quantity` or `UnitPrice`
- Calculated net revenue using the formula:  
  `Revenue = Quantity * UnitPrice * (1 - Discount)`
- Converted `InvoiceDate` to `OrderDate` in `YYYY-MM-DD` format for grouping

## SQL Steps

### Step 1: Create Cleaned Data Table
```sql
CREATE TABLE clean_orders AS
SELECT 
    InvoiceNo,
    DATE(InvoiceDate) AS OrderDate,
    Quantity,
    UnitPrice,
    Discount,
    ROUND((Quantity * UnitPrice) * (1 - Discount), 2) AS Revenue,
    ReturnStatus
FROM orders
WHERE 
    ReturnStatus != 'Returned'
    AND Quantity > 0
    AND UnitPrice > 0
    AND Discount >= 0 AND Discount < 1;
```

### Step 2: Monthly Aggregation

```sql
SELECT 
    STRFTIME('%Y', OrderDate) AS year,
    STRFTIME('%m', OrderDate) AS month,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS order_volume
FROM clean_orders
GROUP BY year, month
ORDER BY year, month;
```

## Output

* **SQL Script:** `sales_trend_analysis.sql`
* **Results Table (CSV):** `monthly_sales_trend.csv`

## Result Summary

The final query outputs monthly total revenue and the number of distinct orders, helping visualize and analyze sales trends over time.

---


