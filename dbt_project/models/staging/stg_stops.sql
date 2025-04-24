with stops as (

    select *
    from {{ source('public', 'raw_stops') }}
)

select
    stop_id,
    stop_name,
    stop_lat,
    stop_lon
from stops
