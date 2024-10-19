select  distinct product_id,
        name,
        price
from {{ ref('stg_products') }}
