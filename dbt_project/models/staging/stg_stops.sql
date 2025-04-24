with stops as (

    select *
    from {{ source('public', 'raw_stops') }}
)

select
    cast(stop_id as text) as stop_id,
    stop_name,
    stop_lat,
    stop_lon
from stops
