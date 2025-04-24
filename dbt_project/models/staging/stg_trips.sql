with trips as (
    select *
    from {{ source('public', 'raw_trips') }}
)

select
    route_id,
    service_id,
    trip_id,
    trip_headsign,
    direction_id
from trips
