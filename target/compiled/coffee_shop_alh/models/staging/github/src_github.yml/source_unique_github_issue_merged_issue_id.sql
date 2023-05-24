
    
    

with dbt_test__target as (

  select issue_id as unique_field
  from `analytics-engineers-club`.`github`.`issue_merged`
  where issue_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


