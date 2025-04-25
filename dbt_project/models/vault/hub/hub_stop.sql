with stops as (
    select *
    from {{ ref('stg_stops') }}
)

select
    md5(stop_id) as stop_hk,
    stop_id as stop_id_bk,
    current_timestamp as load_ts,
    'hvv gtfs' as record_source
from stops
group by stop_id
