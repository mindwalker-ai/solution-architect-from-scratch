-- SILVER: clean + dedupe raw scans into one trusted row per scan_id.
-- Demonstrates the dedupe/idempotency pattern from the lesson: the raw feed
-- contains duplicate scan_ids; we keep only the latest event per scan_id.

with deduped as (
    select
        scan_id,
        parcel_id,
        courier_id,
        hub_id,
        lower(status)                as status,
        cast(event_ts as timestamp)  as event_ts,
        row_number() over (
            partition by scan_id
            order by cast(event_ts as timestamp) desc
        ) as rn
    from {{ ref('raw_scan_events') }}
)

select
    scan_id,
    parcel_id,
    courier_id,
    hub_id,
    status,
    event_ts,
    cast(event_ts as date) as event_date
from deduped
where rn = 1
