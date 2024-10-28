with 

events as (
    select * from {{ ref('stg_events') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}

),

session_timing_agg as (
    select * from {{ ref('int_session_timings') }}
)

<<<<<<< HEAD
{% set event_types = dbt_utils.get_column_values(
        table = ref('stg_events'),
        column = 'event_type'
    )
%}

=======
>>>>>>> 1e83b440539df3949ff8ce388920b9504df6c922
select  distinct e.session_id,
        e.user_id,
        session_started_at,
        session_ended_at,
        {% for event_type in event_types %}
        {{ sum_of('e.event_type', event_type) }} as {{ event_type }}s,
        {%endfor%}
        datediff('minute', session_started_at, session_ended_at) as session_length_minutes
from events e 
left join session_timing_agg s on s.session_id = e.session_id
<<<<<<< HEAD
group by 1,2,3,4
=======
group by 1,2,3,4

>>>>>>> 1e83b440539df3949ff8ce388920b9504df6c922
