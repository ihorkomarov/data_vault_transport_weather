with stop_times as (
    select *
    from {{ source('public', 'raw_stop_times') }}
)

select
    cast(trip_id as text) as trip_id,
    arrival_time,
    departure_time,
    cast(stop_id as text) as stop_id,
    stop_sequence
from stop_times
