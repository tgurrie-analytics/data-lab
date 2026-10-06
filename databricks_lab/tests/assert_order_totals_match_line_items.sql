{{ config(severity='warn') }}
select
    h.order_id,
    h.gross_sales as header_gross,
    coalesce(sum(l.gross_sales), 0) as lines_gross,
    h.quantity as header_qty,
    coalesce(sum(l.quantity), 0) as lines_qty
from {{ ref('stg_transactions') }} h
left join {{ ref('stg_order_items') }} l on h.order_id = l.order_id
group by h.order_id, h.gross_sales, h.quantity
having abs(h.gross_sales - coalesce(sum(l.gross_sales), 0)) > 0.01
    or h.quantity != coalesce(sum(l.quantity), 0)