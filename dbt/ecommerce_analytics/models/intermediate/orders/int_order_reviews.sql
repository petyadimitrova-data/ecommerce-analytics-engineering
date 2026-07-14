SELECT 
review_id, 
order_id, 
review_score, 
review_comment_title, 
review_comment_message, 
review_creation_dt, 
review_answer_ts,
cast(review_answer_ts as date) as review_answer_dt,
FROM {{ ref('stg_order_reviews') }}