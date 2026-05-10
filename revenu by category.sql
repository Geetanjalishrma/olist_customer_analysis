-- create DATABASE olist;
Use olist;
-- SELECT * from product_category_name_translation LIMIT 3

SELECT
coalesce(t.product_category_name_english, p.product_category_name) AS category,
COUNT(distinct oi.order_id) AS total_orders,
round(SUM(oi.price), 2) AS total_revenue,
ROUND(AVG(oi.price), 2) AS avg_order_value

FROM olist_order_items_dataset oi
JOIN olist_products_dataset p On oi.product_id = p.product_id
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
LEFT JOIN product_category_name_translation t ON p.product_category_name = t.ï»¿product_category_name

WHERE o.order_status = 'delivered'
AND p.product_category_name IS NOT NULL
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 15;