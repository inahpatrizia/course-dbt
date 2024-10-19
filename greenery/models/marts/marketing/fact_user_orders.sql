with 

users as (
    select * from {{ ref('stg_users') }}
),

user_orders as (
    select  user_id,
            min(created_at) as first_order_created_at,
            max(created_at) as last_order_created_at,
            sum(order_cost) as total_spend,
            count(order_id) as orders
    from {{ ref('stg_orders') }}
    group by 1
),

products_purchased as (
    select  user_id,
            count(oi.product_id) as products_purchased
    from {{ ref('stg_order_items') }} oi
    left join {{ ref('stg_orders') }} o on oi.order_id = o.order_id
    group by 1
)

select  u.user_id,
        uo.orders is not null as is_buyer,
        coalesce(uo.orders, 0) >= 2 as is_frequent_buyer,
        uo.first_order_created_at,
        uo.last_order_created_at,
        uo.orders,
        coalesce(uo.total_spend, 0) as total_spend,
        coalesce(p.products_purchased, 0) as products_purchased
from users u
left join user_orders uo on u.user_id = uo.user_id
left join products_purchased p on p.user_id = u.user_id
