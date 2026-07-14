select
    s.seller_id,

    s.seller_state as state,
    {{ normalize_text("s.seller_city") }} as city,
    s.seller_zip_code_prefix as zip_code_prefix,

    g.latitude,
    g.longitude

from {{ ref('stg_sellers') }} s

left join {{ ref('int_geography') }} g
    on s.seller_zip_code_prefix = g.zip_code_prefix
   and {{ normalize_text("s.seller_city") }} = g.city
   and s.seller_state = g.state