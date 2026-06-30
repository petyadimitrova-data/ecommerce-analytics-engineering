select 
order_id,
order_item_id,
product_id,
seller_id,
shipping_limit_date as shipping_limit_ts,
price,
freight_value
from {{ source('raw', 'order_items') }}