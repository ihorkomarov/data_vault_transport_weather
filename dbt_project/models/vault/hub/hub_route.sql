select
    md5(route_id) as route_hk,
    route_id as route_id_bk,
    current_timestamp as load_ts,
    'dbt' as record_source
from {{ ref('stg_routes') }}
group by route_id
