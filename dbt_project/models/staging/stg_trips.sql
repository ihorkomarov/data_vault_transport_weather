with trips as (
    select *
    from {{ source('public', 'raw_trips') }}
)

select
    cast(route_id as text) as route_id,
    cast(service_id as text) as service_id,
    cast(trip_id as text) as trip_id,
    trip_headsign,
    direction_id
from trips
