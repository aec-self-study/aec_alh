

  create or replace view `aec-students`.`dbt_alh`.`stg_github_issue_merged`
  OPTIONS()
  as with source as (
select * from `analytics-engineers-club`.`github`.`issue_merged`
),

renamed as (
select 
    issue_id,
    actor_id as merge_user_id,
    commit_sha,					
    merged_at
    --_fivetran_synced,	
from source					
)
    select *
    from renamed;

