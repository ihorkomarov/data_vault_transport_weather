with trips as (
    select *
    from {{ ref('stg_trips') }}
)

select
    md5(trip_id || '-' || route_id) as link_trip_route_hk,
    md5(trip_id) as trip_hk,
    md5(route_id) as route_hk,
    current_timestamp as load_ts,
    'hvv gtfs' as record_source
from trips
group by trip_id, route_id
