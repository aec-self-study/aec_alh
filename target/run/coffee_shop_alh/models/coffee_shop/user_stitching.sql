

  create or replace view `aec-students`.`dbt_alh`.`user_stitching`
  OPTIONS()
  as with source as (

    select * from `analytics-engineers-club`.`web_tracking`.`pageviews`

), renamed as (

SELECT
  id,
  customer_id,
  first_value(visitor_id) OVER (PARTITION BY customer_id ORDER BY timestamp ASC) as vistor_id, 
  device_type,
  timestamp,
  page
FROM
  source
WHERE
  customer_id IS NOT NULL
)

select * from renamed;

