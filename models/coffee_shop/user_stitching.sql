
with source as (

    select * from {{ source('web_tracking', 'pageviews') }}

),

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

select * from renamed