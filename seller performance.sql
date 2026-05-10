USE olist;
SELECT 
s.seller_id,
s.seller_state,
COUNT(DISTINCT o.order_id) as total_orders,
ROUND(SUM(oi.price), 2) as total_revenue,
ROUND(AVG(r.review_score), 2) as avg_review_score,
ROUND(SUM(CASE WHEN o.order_status = 'canceled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as cancel_pct
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id 
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
LEFT JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
GROUP BY s.seller_id, s.seller_state
HAVING total_orders > 50
ORDER BY total_revenue DESC
LIMIT 20;