select 
customer_id,
customer_unique_id,
customer_state,
customer_city,
customer_zip_code_prefix
from {{ source('raw', 'customers') }}