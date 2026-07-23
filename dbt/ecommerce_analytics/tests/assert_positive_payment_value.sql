select *
from {{ ref('fct_payment') }}
where payment_value < 0