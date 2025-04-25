with weather as (
    select *
    from {{ ref('stg_weather') }}
)

select
    md5(cast(weather_timestamp as text)) as weather_hk,
    weather_timestamp as weather_timestamp_bk,
    current_timestamp as load_ts,
    'OpenWeather' as record_source
from weather
group by weather_timestamp
