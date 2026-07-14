select
    dc.customer_sk,
    dd.date_sk as order_purchase_date_sk,

    op.order_id,
    op.payment_sequential,
    op.payment_type,

    op.payment_installments,
    op.payment_value

from {{ ref('int_order_payments') }} op

left join {{ ref('int_orders') }} io
    on op.order_id = io.order_id

left join {{ ref('dim_customer') }} dc
    on io.customer_id = dc.customer_id

left join {{ ref('dim_date') }} dd
    on io.order_purchase_dt = dd.calendar_date