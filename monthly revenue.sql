USE olist;
select
DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
COUNT(Distinct o.order_id) as total_orders,
ROUND(SUM(oi.price), 2) as total_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;