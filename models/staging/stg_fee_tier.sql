select
    tier,
    min_aum,
    max_aum,
    bps
from {{ ref('fee_tiers') }}