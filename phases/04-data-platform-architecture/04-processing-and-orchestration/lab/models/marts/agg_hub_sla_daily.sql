-- GOLD: the business mart the hub-SLA dashboard reads.
-- One row per hub per day: how many parcels reached a final state and the
-- delivery success rate. This is the number a hub manager trusts at 9 a.m.

with final_scans as (
    select *
    from {{ ref('stg_scan_events') }}
    where status in ('delivered', 'failed')
)

select
    f.event_date,
    f.hub_id,
    h.hub_name,
    count(*)                                          as final_parcels,
    count(*) filter (where f.status = 'delivered')    as delivered,
    count(*) filter (where f.status = 'failed')       as failed,
    round(
        100.0 * count(*) filter (where f.status = 'delivered') / count(*),
        1
    )                                                 as delivery_success_rate_pct
from final_scans f
left join {{ ref('stg_hubs') }} h
    on f.hub_id = h.hub_id
group by 1, 2, 3
order by 1, 2
