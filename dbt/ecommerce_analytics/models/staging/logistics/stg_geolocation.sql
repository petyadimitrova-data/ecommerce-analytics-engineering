select 
geolocation_state,
geolocation_city,
geolocation_zip_code_prefix, 
geolocation_lat, 
geolocation_lng
from {{ source('raw', 'geolocation') }}