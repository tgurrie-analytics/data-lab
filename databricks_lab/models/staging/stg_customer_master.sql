select
    customer_id,
    customer_name,
    customer_age,
    gender,
    customer_segment,
    customer_city,
    customer_state,
    customer_country,
    region,
    cast(customer_postal_code as string) as customer_postal_code,
    cast(customer_acquisition_cost as decimal(18,2)) as customer_acquisition_cost
from {{ source('raw', 'customer_master') }}