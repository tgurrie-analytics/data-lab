with typed as (
    select
        order_id,
        product_id,
        cast(quantity as int) as quantity,
        {{ money('unit_price') }} as unit_price,
        cast(discount_percentage as decimal(8,4)) as discount_rate,
        {{ money('discount_amount') }} as discount_amount,
        {{ money('gross_sales') }} as gross_sales,
        {{ money('tax_amount') }} as tax_amount,
        {{ money('shipping_cost') }} as shipping_cost,
        {{ money('net_sales') }} as net_sales,
        {{ money('product_cost') }} as line_product_cost,
        {{ money('profit') }} as profit
    from {{ source('raw', 'order_items') }}
)

select
        {{ hash_columns(['order_id', 'product_id', 'quantity', 'unit_price', 'discount_rate', 'discount_amount', 'tax_amount', 'shipping_cost']) }} as line_id
    *
from typed