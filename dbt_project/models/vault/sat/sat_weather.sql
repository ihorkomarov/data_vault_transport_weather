{{ config(
    materialized = 'incremental',
    unique_key = 'datetime, hashdiff',
    on_schema_change = 'ignore'
) }}

with source as (
    select
        datetime,
        temp,
        feelslike,
        humidity,
        dew,
        precip,
        precipprob,
        snow,
        snowdepth,
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
            coalesce(temp::text, '')
            || coalesce(feelslike::text, '')
            || coalesce(humidity::text, '')
            || coalesce(dew::text, '')
            || coalesce(precip::text, '')
            || coalesce(precipprob::text, '')
            || coalesce(snow::text, '')
            || coalesce(snowdepth::text, '')
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
                {{ this }}.datetime = source.datetime
                and {{ this }}.hashdiff = source.hashdiff
        )
    {% endif %}
)

select * from filtered
