

  create or replace view `aec-students`.`dbt_alh`.`monthly_customers`
  OPTIONS()
  as select
    date_trunc(first_order_at, month) as signup_month,
    count(*) as new_customers
 
from `aec-students`.`dbt_alh`.`customers`
 
group by 1;

