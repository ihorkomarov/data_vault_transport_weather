select
    md5(stop_id) as stop_hk,
    stop_id as stop_id_bk,
    current_timestamp as load_ts,
    'dbt' as record_source
from {{ ref('stg_stops') }}
group by stop_id
