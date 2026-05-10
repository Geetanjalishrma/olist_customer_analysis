USE olist;
SELECT 
order_count,
COUNT(*) as num_of_customers,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_customers
FROM (
SELECT c.customer_unique_id, COUNT(o.order_id) AS order_count
FROM olist_customers_dataset c 
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
) sub
GROUP BY order_count
ORDER BY order_count;
