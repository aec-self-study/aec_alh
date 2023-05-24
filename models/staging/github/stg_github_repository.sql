{{ config(materialized='table') }}

with source as (

    select * from {{ source('github', 'repository') }}

),

renamed as (

    select
        id,
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