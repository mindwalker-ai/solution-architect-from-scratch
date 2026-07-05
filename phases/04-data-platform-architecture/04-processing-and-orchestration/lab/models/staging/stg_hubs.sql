-- SILVER: the hub dimension (small, full-refresh).

select
    hub_id,
    hub_name,
    city
from {{ ref('raw_hubs') }}
