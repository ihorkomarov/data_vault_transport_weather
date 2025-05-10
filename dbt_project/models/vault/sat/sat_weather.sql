{{ config(
    materialized = 'incremental',
    unique_key = 'weather_timestamp, hashdiff',
    on_schema_change = 'ignore'
) }}

with source as (
    select
        weather_timestamp,
        temp_celsius,
        feelslike_celsius,
        humidity,
        dew,
        precip,
        precipprob,
        snow_cm,
        snowdepth_cm,
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
        conditions,
        current_timestamp as load_ts,      -- Wann geladen
        'openweather' as record_source,    -- Quelle
        md5(
            coalesce(temp_celsius::text, '')
            || coalesce(feelslike_celsius::text, '')
            || coalesce(humidity::text, '')
            || coalesce(dew::text, '')
            || coalesce(precip::text, '')
            || coalesce(precipprob::text, '')
            || coalesce(snow_cm::text, '')
            || coalesce(snowdepth_cm::text, '')
            || coalesce(preciptype, '')
            || coalesce(windgust::text, '')
            || coalesce(windspeed::text, '')
            || coalesce(winddir::text, '')
            || coalesce(pressure::text, '')
            || coalesce(visibility::text, '')
            || coalesce(cloudcover::text, '')
            || coalesce(solarradiation::text, '')
            || coalesce(solarenergy::text, '')
            || coalesce(uvindex::text, '')
            || coalesce(conditions, '')
        ) as hashdiff
    from {{ ref('stg_weather') }}
),

filtered as (
    select *
    from source
    {% if is_incremental() %}
        where not exists (
            select 1 from {{ this }}
            where
                {{ this }}.weather_timestamp = source.weather_timestamp
                and {{ this }}.hashdiff = source.hashdiff
        )
    {% endif %}
)

select * from filtered
