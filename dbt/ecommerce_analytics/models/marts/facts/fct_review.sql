select

    
    dc.customer_sk,

    dd.date_sk as review_creation_date_sk,

   
    r.review_id,
    r.order_id,

    
    r.review_comment_title,
    r.review_comment_message,

    
    r.review_score,

    io.order_status

from {{ ref('int_order_reviews') }} r

left join {{ ref('int_orders') }} io
    on r.order_id = io.order_id

left join {{ ref('dim_customer') }} dc
    on io.customer_id = dc.customer_id

left join {{ ref('dim_date') }} dd
    on r.review_creation_dt = dd.calendar_date