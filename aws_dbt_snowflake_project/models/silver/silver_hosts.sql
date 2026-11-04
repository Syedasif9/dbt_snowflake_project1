{{ config(materialized='incremental', unique_key='HOST_ID') }}

select 
    host_id,
    replace(host_name, ' ', '_') as host_name,
    host_since as host_since,
    is_superhost as is_superhost,
    response_rate as response_rate,
    case 
    when response_rate > 95 then 'very good'
    when response_rate > 80 then 'good'
    when response_rate > 60 then 'average'
    when response_rate > 40 then 'poor'
    when response_rate > 20 then 'very poor'
    else 'bad'
    end as response_quality,
    created_at as created_at
from {{ ref('bronze_hosts') }}