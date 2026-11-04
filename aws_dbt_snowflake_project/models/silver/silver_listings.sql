{{ config
   ( materialized='incremental',
    unique_key='LISTING_ID' )
}}


SELECT
    LISTING_ID,    
    HOST_ID,
    property_type,
    room_type,
    bedrooms,
    bathrooms,
    {{ tag('cast(PRICE_PER_NIGHT as int)') }} as PRICE_PER_NIGHT,
    city,
    country,
    ACCOMMODATES,
    created_at
FROM {{ ref('bronze_listings') }}