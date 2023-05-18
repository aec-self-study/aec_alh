

  create or replace view `aec-students`.`dbt_alh`.`customers`
  OPTIONS()
  as SELECT 
	orders.customer_id AS customer_id,
	customers.name AS name,
	customers.email AS email,
	MIN(orders.created_at) AS first_order_at,
	COUNT(orders.created_at) AS nr_of_orders
FROM `analytics-engineers-club.coffee_shop.customers` AS customers
INNER JOIN `analytics-engineers-club.coffee_shop.orders` AS orders ON customers.id=orders.customer_id
GROUP BY 
	customer_id,
	name,
	email
ORDER BY first_order_at limit 5;;

