select

    order_id,
    customer_id,
    order_status,

    -- Purchase
    order_purchase_ts,
    cast(order_purchase_ts as date) as order_purchase_dt,

    -- Approval
    order_approved_ts,
    cast(order_approved_ts as date) as order_approved_dt,

    -- Carrier
    order_delivered_carrier_ts,
    cast(order_delivered_carrier_ts as date) as order_delivered_carrier_dt,

    -- Customer Delivery
    order_delivered_customer_ts,
    cast(order_delivered_customer_ts as date) as order_delivered_customer_dt,

    -- Estimated Delivery
    order_estimated_delivery_ts,
    cast(order_estimated_delivery_ts as date) as order_estimated_delivery_dt

from {{ ref('stg_orders') }}