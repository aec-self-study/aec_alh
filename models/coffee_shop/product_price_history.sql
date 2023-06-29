with source as (
    select * from `analytics-engineers-club.coffee_shop.product_prices`
),

renamed as (
    select
        id as product_price_id,
        product_id,
        price,
        created_at,
        ended_at
    from source
)

select * from renamed