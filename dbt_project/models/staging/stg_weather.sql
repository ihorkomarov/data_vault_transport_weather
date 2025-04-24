with raw_weather as (
    select *
    from {{ source('public', 'raw_weather') }}
)

select
    datetime as weather_timestamp,
    temp as temp_celsius,
    feelslike as feelslike_celsius,
    humidity,
    dew,
    precip,
    precipprob,
    snow as snow_cm,
    snowdepth as snowdepth_cm,
    preciptype,
    windgust,
    windspeed,
    winddir,
    pressure,
    visibility,
    cloudcover,
    solarradiation,
    solarenergy,
    uvindex,
    conditions
from raw_weather
