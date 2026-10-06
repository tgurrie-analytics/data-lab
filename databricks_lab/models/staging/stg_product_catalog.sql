select
    product_id,
    product_name,
    product_category,
    product_subcategory,
    brand,
    supplier,
    {{ money('unit_price') }} as unit_price,
    {{ money('product_cost') }} as unit_cost,
    cast(product_rating as decimal(3,1)) as product_rating
from {{ source('raw', 'product_catalog') }}