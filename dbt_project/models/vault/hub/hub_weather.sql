select
    md5(cast(weather_timestamp as TEXT)) as weather_hk,
    weather_timestamp as weather_timestamp_bk,
    current_timestamp as load_ts,
    'dbt' as record_source
from {{ ref('stg_weather') }}
group by weather_timestamp
