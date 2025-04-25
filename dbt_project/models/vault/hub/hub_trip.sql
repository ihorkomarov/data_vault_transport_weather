with trips as (
    select *
    from {{ ref('stg_trips') }}
)

select
    md5(trip_id) as trip_hk,
    trip_id as trip_id_bk,
    current_timestamp as load_ts,
    'hvv gtfs' as record_source
from trips
group by trip_id
