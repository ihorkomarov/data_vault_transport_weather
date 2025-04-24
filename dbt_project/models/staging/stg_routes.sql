with routes as (
    select *
    from {{ source('public', 'raw_routes') }}
)

select
    cast(route_id as text) as route_id,
    route_short_name,
    route_long_name,
    route_type
from routes
