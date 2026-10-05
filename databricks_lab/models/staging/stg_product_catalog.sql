select
    product_id,
    product_name,
    product_category,
    product_subcategory,
    brand,
    supplier,
    cast(unit_price as decimal(18,2)) as unit_price,
    cast(product_cost as decimal(18,2)) as unit_cost,
    cast(product_rating as decimal(3,1)) as product_rating
from {{ source('raw', 'product_catalog') }}