with calendar as (
    select *
    from {{ ref('stg_calendar') }}
)

select
    md5(service_id) as service_hk,
    service_id as service_id_bk,
    current_timestamp as load_ts,
    'dbt' as record_source
from calendar
group by service_id
