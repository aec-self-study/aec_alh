

  create or replace view `aec-students`.`dbt_alh`.`obt_order_items`
  OPTIONS()
  as select
    -- ids first
    order_items.order_id,
    order_items.product_id,
    customers.customer_id,

    -- product details
    products.name as product_name,
    products.category as product_category,

    -- customer details
    customers.name as customer_name,
    customers.email as customer_email,

    -- order details
    orders.state as order_state,
    orders.created_at as sold_at,

    -- order item details
    product_prices.price as price

from `analytics-engineers-club.sample_data_staging.stg_coffee_shop__order_items` as order_items

left join `analytics-engineers-club.sample_data_staging.stg_coffee_shop__orders` as orders
    on order_items.order_id = orders.order_id

left join `analytics-engineers-club.sample_data_staging.stg_coffee_shop__customers` as customers
    on orders.customer_id = customers.customer_id

left join `analytics-engineers-club.sample_data_staging.stg_coffee_shop__products` as products
    on order_items.product_id = products.product_id

left join `analytics-engineers-club.sample_data_staging.stg_coffee_shop__product_prices` as product_prices
  on products.product_id = product_prices.product_id
  and orders.created_at between product_prices.created_at and product_prices.ended_at;

