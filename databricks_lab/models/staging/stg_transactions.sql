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
    nullif(return_status, 'null') as return_status,
    nullif(return_reason, 'null') as return_reason,
    nullif(coupon_code, 'null') as coupon_code,
    nullif(campaign_name, 'null') as campaign_name,
    cast(is_repeat_customer as boolean) as is_repeat_customer,
    cast(gross_sales as decimal(18,2)) as gross_sales,
    cast(discount_amount as decimal(18,2)) as discount_amount,
    cast(tax_amount as decimal(18,2)) as tax_amount,
    cast(shipping_cost as decimal(18,2)) as shipping_cost,
    cast(net_sales as decimal(18,2)) as net_sales,
    cast(product_cost as decimal(18,2)) as product_cost,
    cast(profit as decimal(18,2)) as profit,
    cast(profit_margin_percentage as decimal(8,2)) as profit_margin_percentage,
    cast(customer_lifetime_value as decimal(18,2)) as customer_lifetime_value
from source