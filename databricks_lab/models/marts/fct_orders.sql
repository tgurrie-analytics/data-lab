with line_totals as (
    select
        order_id,
        count(*) as line_count,
        sum(quantity) as units,
        sum(gross_sales) as gross_sales,
        sum(discount_amount) as discount_amount,
        sum(tax_amount) as tax_amount,
        sum(shipping_cost) as shipping_cost,
        sum(line_product_cost) as product_cost,
        sum(merchandise_revenue) as merchandise_revenue,
        sum(profit_excl_tax) as profit_excl_tax
    from {{ ref('fct_order_lines') }}
    group by order_id
)

select
    h.order_id,
    h.customer_id,
    h.order_date,
    h.currency,
    h.return_status,
    h.return_reason,
    h.coupon_code,
    h.campaign_name,
    t.line_count,
    t.units,
    t.gross_sales,
    t.discount_amount,
    t.tax_amount,
    t.shipping_cost,
    t.product_cost,
    t.merchandise_revenue,
    t.profit_excl_tax,
    h.quantity as header_units,
    h.gross_sales as header_gross_sales,
    h.net_sales as header_net_sales,
    h.profit as header_profit,
    t.gross_sales - h.gross_sales as gross_sales_gap,
    (abs(t.gross_sales - h.gross_sales) <= 0.01 and t.units = h.quantity) as totals_reconcile
from {{ ref('stg_transactions') }} h
left join line_totals t on h.order_id = t.order_id