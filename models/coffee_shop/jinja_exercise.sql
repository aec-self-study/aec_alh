{{config(
    materialized='view'
) }}



select 
order_id,
{% for product_category in ['coffee_beans', 'merch', 'brewing_supplies'] %}
sum(case when product_category = '{{product_category}}' then price end) as {{product_category}}_amount,
{% endfor %}
-- select
--   date_trunc(sold_at, month) as date_month,
--   sum(case when product_category = 'coffee beans' then price end) as coffee_beans_amount,
--   sum(case when product_category = 'merch' then price end) as merch_amount,
--   sum(case when product_category = 'brewing supplies' then price end) as brewing_supplies_amount
-- you may have to `ref` a different model here, depending on what you've built previously
from {{ ref('obt_order_items') }}
group by 1