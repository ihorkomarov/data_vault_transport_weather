{{ config(
    materialized = 'incremental',
    unique_key = 'route_hk, hashdiff',
    on_schema_change = 'ignore'
) }}

with source as (
    select
        md5(route_id) as route_hk,
        route_short_name,
        route_long_name,
        route_type,
        current_timestamp as load_ts,
        'gtfs' as record_source,
        md5(
            coalesce(route_short_name, '')
            || coalesce(route_long_name, '')
            || coalesce(route_type::text, '')
        ) as hashdiff
    from {{ ref('stg_routes') }}
),

filtered as (
    select *
    from source
    {% if is_incremental() %}
        where not exists (
            select 1 from {{ this }}
            where
                {{ this }}.route_hk = source.route_hk
                and {{ this }}.hashdiff = source.hashdiff
        )
    {% endif %}
)

select * from filtered
