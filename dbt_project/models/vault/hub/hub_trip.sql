select
    md5(cast(trip_id as text)) as trip_hk,
    trip_id as trip_id_bk,
    current_timestamp as load_ts,
    'dbt' as record_source
from {{ ref('stg_trips') }}
group by trip_id
