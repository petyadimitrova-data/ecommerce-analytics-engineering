select *
from {{ ref('fct_order_line') }}
where quantity <> 1