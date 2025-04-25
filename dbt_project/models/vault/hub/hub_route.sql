with routes as (
    select *
    from {{ ref('stg_routes') }}
)

select
    md5(route_id) as route_hk,
    route_id as route_id_bk,
    current_timestamp as load_ts,
    'hvv gtfs' as record_source
from routes
group by route_id
