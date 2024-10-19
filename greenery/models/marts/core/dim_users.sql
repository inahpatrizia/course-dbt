with 

users as (
    select * from {{ ref('stg_users') }}
),

addresses as (
    select * from {{ ref('stg_addresses') }}
)

select  u.user_id,
        u.created_at,
        a.address_id,
        a.zipcode,
        a.state,
        a.country
from users u 
left join addresses a on u.address_id = a.address_id
