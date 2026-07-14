select

    md5(seller_id) as seller_sk,

    seller_id,

    state,

    city,

    zip_code_prefix,

    latitude,

    longitude

from {{ ref('int_sellers') }}