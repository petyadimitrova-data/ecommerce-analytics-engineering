select

    dc.customer_sk,
    dp.product_sk,
    ds.seller_sk,
    dd.date_sk as order_purchase_date_sk,

    oi.order_id,
    oi.order_item_id,

    1 as quantity,
    oi.price,
    oi.freight_value

from {{ ref('int_order_items') }} oi

left join {{ ref('int_orders') }} io
    on oi.order_id = io.order_id

left join {{ ref('dim_customer') }} dc
    on io.customer_id = dc.customer_id

left join {{ ref('dim_product') }} dp
    on oi.product_id = dp.product_id

left join {{ ref('dim_seller') }} ds
    on oi.seller_id = ds.seller_id

left join {{ ref('dim_date') }} dd
    on io.order_purchase_dt = dd.calendar_date