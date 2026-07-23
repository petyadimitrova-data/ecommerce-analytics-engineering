select *
from {{ ref('fct_order_line') }}
where price < 0