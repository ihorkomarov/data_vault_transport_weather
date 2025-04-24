select
    md5(cast(service_id as text)) as service_hk,
    service_id as service_id_bk,
    current_timestamp as load_ts,
    'dbt' as record_source
from {{ ref('stg_calendar') }}
group by service_id
