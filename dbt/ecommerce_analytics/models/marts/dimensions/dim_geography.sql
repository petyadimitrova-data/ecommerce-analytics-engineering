select

    md5(concat(state, '|', city, '|', zip_code_prefix)) as geography_sk,

    state,
    city,
    zip_code_prefix,

    latitude,
    longitude

from {{ ref('int_geography') }}