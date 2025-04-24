with stop_times as (
    select *
    from {{ ref("stg_stop_times") }}
)

select
    md5(trip_id || '-' || stop_id) as link_trip_stop_hk,
    md5(trip_id) as trip_hk,
    md5(stop_id) as stop_hk,
    current_timestamp as load_ts,
    'dbt' as record_source
from stop_times
group by trip_id, stop_id
