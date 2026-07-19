select
    a.client_id,
    a.total_aum,
    t.tier,
    t.bps
from {{ ref('int_client_aum') }} a
left join {{ ref('stg_fee_tier') }} t
    on a.total_aum >= t.min_aum
   and a.total_aum < t.max_aum