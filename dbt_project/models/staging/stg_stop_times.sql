with stop_times as (
    select *
    from {{ source('public', 'raw_stop_times') }}
)

select
    trip_id,
    arrival_time,
    departure_time,
    stop_id,
    stop_sequence
from stop_times
