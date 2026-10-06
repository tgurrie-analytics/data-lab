with source as (
    select * from {{ source('raw', 'transactions') }}
)

select
    * except (
        order_date, return_status, return_reason, coupon_code, campaign_name,
        is_repeat_customer, gross_sales, discount_amount, tax_amount,
        shipping_cost, net_sales, product_cost, profit,
        profit_margin_percentage, customer_lifetime_value
    ),
    cast(order_date as date) as order_date,
    {{ clean_null('return_status') }} as return_status,
    {{ clean_null('return_reason') }} as return_reason,
    {{ clean_null('coupon_code') }} as coupon_code,
    {{ clean_null('campaign_name') }} as campaign_name,
    cast(is_repeat_customer as boolean) as is_repeat_customer,
    {{ money('gross_sales') }} as gross_sales,
    {{ money('discount_amount') }} as discount_amount,
    {{ money('tax_amount') }} as tax_amount,
    {{ money('shipping_cost') }} as shipping_cost,
    {{ money('net_sales') }} as net_sales,
    {{ money('product_cost') }} as product_cost,
    {{ money('profit') }} as profit,
    cast(profit_margin_percentage as decimal(8,2)) as profit_margin_percentage,
    {{ money('customer_lifetime_value') }} as customer_lifetime_value
from source