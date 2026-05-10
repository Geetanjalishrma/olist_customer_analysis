USE olist;
SELECT
r.review_score, count(*) AS order_count,
ROUND(avg(DATEDIFF(o.order_delivered_customer_date , o.order_estimated_delivery_date)), 2) as avg_delay_days,
SUM(CASE WHEN DATEDIFF(o.order_delivered_customer_date , o.order_estimated_delivery_date) < 0 THEN 1 ELSE 0 END) as arrived_early_count,
SUM(CASE WHEN DATEDIFF(o.order_delivered_customer_date , o.order_estimated_delivery_date) > 0 THEN 1 ELSE 0 END) as arrived_late_count
FROM olist_orders_dataset o
JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score DESC;