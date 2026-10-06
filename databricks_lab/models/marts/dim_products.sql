select
    product_id,
    product_name,
    product_category,
    product_subcategory,
    brand,
    supplier,
    unit_price,
    unit_cost,
    unit_price - unit_cost as unit_margin,
    round((unit_price - unit_cost) / nullif(unit_price, 0), 4) as unit_margin_rate,
    product_rating
from {{ ref('stg_product_catalog') }}