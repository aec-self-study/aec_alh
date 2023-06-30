with utils as (
    select * from {{ ref('utils_day')}}
)

, source as (
    select * from `analytics-engineers-club.coffee_shop.product_prices`
),

renamed as (
    select
        u.date_day,
        id as product_price_id,
        product_id,
        price,
        created_at,
        ended_at
    from source s 
    left join utils u 
    --price created date is before the date we want in our table
    on cast(s.created_at as date) <= u.date_day
    -- end date of price is after the date we want in our model or there is no end date
    and (cast(s.ended_at as date) > u.date_day
            or cast(s.ended_at as date) is null)

)

select * from renamed
