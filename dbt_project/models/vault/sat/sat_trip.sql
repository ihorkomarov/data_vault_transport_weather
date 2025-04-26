{{ config(
    materialized = 'incremental',
    unique_key = 'trip_hk, hashdiff',
    on_schema_change = 'ignore'
) }}

with source as (
    select
        md5(trip_id) as trip_hk,
        trip_headsign,
        direction_id,
        current_timestamp as load_ts,
        'gtfs' as record_source,
        md5(
            coalesce(trip_headsign, '')
            || coalesce(direction_id::text, '')
        ) as hashdiff
    from {{ ref('stg_trips') }}
),

filtered as (
    select *
    from source
    {% if is_incremental() %}
        where not exists (
            select 1 from {{ this }}
            where
                {{ this }}.trip_hk = source.trip_hk
                and {{ this }}.hashdiff = source.hashdiff
        )
    {% endif %}
)

select * from filtered
