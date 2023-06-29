



select 
order_id,

sum(case when product_category = 'coffee_beans' then price end) as coffee_beans_amount,

sum(case when product_category = 'merch' then price end) as merch_amount,

sum(case when product_category = 'brewing_supplies' then price end) as brewing_supplies_amount,

-- select
--   date_trunc(sold_at, month) as date_month,
--   sum(case when product_category = 'coffee beans' then price end) as coffee_beans_amount,
--   sum(case when product_category = 'merch' then price end) as merch_amount,
--   sum(case when product_category = 'brewing supplies' then price end) as brewing_supplies_amount
-- you may have to `ref` a different model here, depending on what you've built previously
from `aec-students`.`dbt_alh`.`obt_order_items`
group by 1