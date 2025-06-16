-- Query 1: Clean and prepare data
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

-- Query 2: Monthly revenue and order volume
SELECT 
    STRFTIME('%Y', OrderDate) AS year,
    STRFTIME('%m', OrderDate) AS month,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS order_volume
FROM clean_orders
GROUP BY year, month
ORDER BY year, month;
