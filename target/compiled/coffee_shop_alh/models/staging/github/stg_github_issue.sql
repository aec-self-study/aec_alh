

with source as (
    select * from `analytics-engineers-club`.`github`.`issue`

),

renamed as (

    select
        id as issue_id,
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
    --    _fivetran_synced,
    from source

)

select * from renamed