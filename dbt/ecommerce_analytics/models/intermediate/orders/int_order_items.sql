SELECT 
order_id, 
order_item_id, 
product_id,
seller_id,
shipping_limit_ts,
cast(shipping_limit_ts as date) as hipping_limit_dt,
price, 
freight_value
FROM {{ ref('stg_order_items') }}