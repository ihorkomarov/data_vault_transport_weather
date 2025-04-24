with trips as (
    select *
    from {{ ref('stg_trips') }}
)

select
    md5(trip_id || '-' || service_id) as link_trip_service_hk,
    md5(trip_id) as trip_hk,
    md5(service_id) as service_hk,
    current_timestamp as load_ts,
    'dbt' as record_source
from trips
group by trip_id, service_id
