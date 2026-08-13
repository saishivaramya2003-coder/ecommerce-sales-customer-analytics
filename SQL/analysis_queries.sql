USE ecommerce_portfolio;

-- 1. Payment Type Analysis
SELECT
payment_type,
COUNT(*) AS total_transactions,
ROUND(SUM(payment_value), 2) AS total_payment
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- 2. Customers by State
SELECT
customer_state,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- 3. Review Score Analysis
SELECT
review_score,
COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- 4. Average Delivery Time
SELECT
ROUND(
AVG(
DATEDIFF(
order_delivered_customer_date,
order_purchase_timestamp
)
),
2
) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 5. Monthly Revenue Analysis
SELECT
DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
ROUND(SUM(p.payment_value), 2) AS monthly_revenue
FROM orders o
JOIN order_payments p
ON o.order_id = p.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

-- 6. Top 10 Sellers by Revenue
SELECT
oi.seller_id,
ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;
