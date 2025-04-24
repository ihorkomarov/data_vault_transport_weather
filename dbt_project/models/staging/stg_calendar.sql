with calendar as (
    select *
    from {{ source('public', 'raw_calendar') }}
)

select
    service_id,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
    start_date,
    end_date
from calendar
