with routes as (
    select *
    from {{ source('public', 'raw_routes') }}
)

select
    route_id,
    route_short_name,
    route_long_name,
    route_type
from routes
