{% set nights_booked_threshold=1 %}

select * from {{ref('bronze_bookings')}}
where nights_booked > {{ nights_booked_threshold }}