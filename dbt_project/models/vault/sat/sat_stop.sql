{{ config(
    materialized = 'incremental',
    unique_key = 'stop_hk, hashdiff',
    on_schema_change = 'ignore'
) }}

with source as (
    select
        md5(stop_id) as stop_hk,
        stop_name,
        stop_lat,
        stop_lon,
        current_timestamp as load_ts,
        'gtfs' as record_source,
        md5(
            coalesce(stop_name, '')
            || coalesce(stop_lat::text, '')
            || coalesce(stop_lon::text, '')
        ) as hashdiff
    from {{ ref('stg_stops') }}
),

filtered as (
    select *
    from source
    {% if is_incremental() %}
        where not exists (
            select 1 from {{ this }}
            where
                {{ this }}.stop_hk = source.stop_hk
                and {{ this }}.hashdiff = source.hashdiff
        )
    {% endif %}
)

select * from filtered
