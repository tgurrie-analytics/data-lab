with lines as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select order_id, customer_id, order_date, currency
    from {{ ref('stg_transactions') }}
)

select
    l.line_id,
    l.order_id,
    l.product_id,
    o.customer_id,
    o.order_date,
    o.currency,
    l.quantity,
    l.unit_price,
    l.discount_rate,
    l.discount_amount,
    l.gross_sales,
    l.tax_amount,
    l.shipping_cost,
    l.line_product_cost,
    l.net_sales as source_net_sales,
    l.profit as source_profit,
    l.gross_sales - l.discount_amount as merchandise_revenue,
    l.gross_sales - l.discount_amount - l.line_product_cost as profit_excl_tax
from lines l
left join orders o on l.order_id = o.order_id