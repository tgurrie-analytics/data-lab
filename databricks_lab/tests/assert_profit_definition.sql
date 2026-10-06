select line_id
from {{ ref('fct_order_lines') }}
where abs(profit_excl_tax - (source_profit - tax_amount)) > 0.02