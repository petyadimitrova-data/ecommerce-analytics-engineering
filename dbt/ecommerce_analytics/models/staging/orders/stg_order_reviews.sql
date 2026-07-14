select 
review_id,
order_id,
review_score,
review_comment_title,
review_comment_message,
review_creation_date as review_creation_dt,
review_answer_timestamp as review_answer_ts
from {{ source('raw', 'order_reviews') }}