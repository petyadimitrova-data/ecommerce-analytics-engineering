select 
seller_id,
seller_state,
seller_city,
seller_zip_code_prefix
from {{ source('raw', 'sellers') }}