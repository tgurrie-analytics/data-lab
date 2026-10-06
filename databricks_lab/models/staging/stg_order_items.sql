with typed as (
    select
        order_id,
        product_id,
        cast(quantity as int) as quantity,
        cast(unit_price as decimal(18,2)) as unit_price,
        cast(discount_percentage as decimal(8,4)) as discount_rate,
        cast(discount_amount as decimal(18,2)) as discount_amount,
        cast(gross_sales as decimal(18,2)) as gross_sales,
        cast(tax_amount as decimal(18,2)) as tax_amount,
        cast(shipping_cost as decimal(18,2)) as shipping_cost,
        cast(net_sales as decimal(18,2)) as net_sales,
        cast(product_cost as decimal(18,2)) as line_product_cost,
        cast(profit as decimal(18,2)) as profit
    from {{ source('raw', 'order_items') }}
)

select
    md5(concat_ws('|', order_id, product_id, quantity, unit_price,
                  discount_rate, discount_amount, tax_amount, shipping_cost)) as line_id,
    *
from typed