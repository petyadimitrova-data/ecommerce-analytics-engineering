select

    md5(customer_id) as customer_sk,

    customer_id,

    customer_unique_id,

    state,

    city,

    zip_code_prefix,

    latitude,

    longitude

from {{ ref('int_customers') }}