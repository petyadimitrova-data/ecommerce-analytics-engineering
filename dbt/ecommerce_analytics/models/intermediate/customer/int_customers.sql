select
    c.customer_id,
    c.customer_unique_id,

    c.customer_state as state,
    {{ normalize_text("c.customer_city") }} as city,
    c.customer_zip_code_prefix as zip_code_prefix,

    g.latitude,
    g.longitude

from {{ ref('stg_customers') }} c

left join {{ ref('int_geography') }} g
    on c.customer_zip_code_prefix = g.zip_code_prefix
   and {{ normalize_text("c.customer_city") }} = g.city
   and c.customer_state = g.state