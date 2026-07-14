select

    geolocation_state as state,

    {{ normalize_text('geolocation_city') }} as city,

    geolocation_zip_code_prefix as zip_code_prefix,

    avg(geolocation_lat) as latitude,

    avg(geolocation_lng) as longitude

from {{ ref('stg_geolocation') }}

group by
    geolocation_state,
    {{ normalize_text('geolocation_city') }},
    geolocation_zip_code_prefix