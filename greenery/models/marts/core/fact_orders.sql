with 

orders as (
    select * from {{ ref('stg_orders') }}
),

addresses as (
    select * from {{ ref('stg_addresses') }}
),

products_in_orders as (
    select  order_id,
            count(product_id) as products_in_orders
    from {{ ref('stg_order_items') }}
    group by 1
)

select  o.order_id,
        o.user_id,
        o.promo_id,
        o.address_id,
        a.country,
        a.state,
        o.created_at,
        o.order_cost,
        o.shipping_cost,
        o.order_total,
        o.tracking_id,
        o.shipping_service,
        o.estimated_delivery_at,
        o.delivered_at,
        o.status as order_status,
        p.products_in_orders
from orders o 
left join addresses a on o.address_id = a.address_id
left join products_in_orders p on p.order_id = o.order_id
