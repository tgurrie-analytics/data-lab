with customers as (
    select * from {{ ref('stg_customer_master') }}
),

orders as (
    select
        customer_id,
        count(*) as order_count,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date
    from {{ ref('stg_transactions') }}
    group by customer_id
)

select
    c.customer_id,
    c.customer_name,
    c.customer_age,
    c.gender,
    c.customer_segment,
    c.customer_city,
    c.customer_state,
    c.customer_country,
    c.region,
    c.customer_postal_code,
    c.customer_acquisition_cost,
    coalesce(o.order_count, 0) as order_count,
    o.first_order_date,
    o.last_order_date,
    coalesce(o.order_count, 0) > 1 as is_repeat_customer
from customers c
left join orders o on c.customer_id = o.customer_id