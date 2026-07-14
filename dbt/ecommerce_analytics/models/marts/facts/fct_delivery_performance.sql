select

    -- Foreign Keys
    dc.customer_sk,

    dd_purchase.date_sk  as order_purchase_date_sk,
    dd_delivery.date_sk  as order_delivered_date_sk,

    -- Degenerate Dimension
    io.order_id,

    -- Measures
    datediff(
        'day',
        io.order_purchase_dt,
        io.order_approved_dt
    ) as approval_days,

    datediff(
        'day',
        io.order_purchase_dt,
        io.order_delivered_customer_dt
    ) as delivery_days,

 case
    when io.order_delivered_customer_dt <= io.order_estimated_delivery_dt
    then 1
    else 0
end as delivered_on_time

from {{ ref('int_orders') }} io

left join {{ ref('dim_customer') }} dc
    on io.customer_id = dc.customer_id

left join {{ ref('dim_date') }} dd_purchase
    on io.order_purchase_dt = dd_purchase.calendar_date

left join {{ ref('dim_date') }} dd_delivery
    on io.order_delivered_customer_dt = dd_delivery.calendar_date