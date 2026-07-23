select *
from {{ ref('fct_delivery_performance') }}
where approval_days is not null
  and approval_days < 0