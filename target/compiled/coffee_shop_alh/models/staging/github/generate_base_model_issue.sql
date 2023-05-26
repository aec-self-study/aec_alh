

{{ config(materialized='table') }}

with source as (

    select * from {{ source('github', 'issue') }}

),

renamed as (

    select
        id,
        _fivetran_synced,
        body,
        closed_at,
        created_at,
        locked,
        milestone_id,
        number,
        pull_request,
        repository_id,
        state,
        title,
        updated_at,
        user_id

    from source

)

select * from renamed


{{ config(materialized='table') }}

with source as (

    select * from {{ source('github', 'pull_request') }}

),

renamed as (

    select
        id,
        _fivetran_synced,
        base_label,
        base_ref,
        base_repo_id,
        base_sha,
        base_user_id,
        draft,
        head_label,
        head_ref,
        head_repo_id,
        head_sha,
        head_user_id,
        issue_id,
        merge_commit_sha

    from source

)

select * from renamed


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
