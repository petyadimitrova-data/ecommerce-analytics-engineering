select *
from {{ ref('fct_delivery_performance') }}
where delivery_days is not null
  and delivery_days < 0