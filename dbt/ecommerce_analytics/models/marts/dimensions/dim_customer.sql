select

    md5(customer_id) as customer_sk,

      md5(concat(state, '|', city, '|', zip_code_prefix)) as geography_sk,

    customer_id,

    customer_unique_id,

    state,

    city,

    zip_code_prefix,

    latitude,

    longitude

from {{ ref('int_customers') }}