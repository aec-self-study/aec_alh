
  
    

    create or replace table `aec-students`.`dbt_alh`.`stg_github_repository`
    
    
    OPTIONS()
    as (
      

with source as (

    select * from `analytics-engineers-club`.`github`.`repository`

),

renamed as (

    select
        id as repo_id,
        _fivetran_synced,
        archived,
        created_at,
        default_branch,
        description,
        fork,
        full_name,
        homepage,
        language,
        name,
        owner_id,
        private,
        stargazers_count

    from source

)

select * from renamed
    );
  