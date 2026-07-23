select *
from {{ ref('fct_review') }}
where review_score < 1
   or review_score > 5