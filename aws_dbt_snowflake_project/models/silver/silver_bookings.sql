{{
    config(
        materialized='incremental',
        unique_key='BOOKING_ID',
        on_schema_change='sync_all_columns'
    )
}}


 select 
    booking_id,
    listing_id,
    booking_date,
    {{ multiply('nights_booked', 'booking_amount') }} as total_booking_amount,
    cleaning_fee,
    service_fee,
    booking_status,
    created_at
    from {{ ref('bronze_bookings') }} 