select
    client_id,
    total_aum,
    tier,
    bps,

    total_aum * bps / 10000 as annual_fee,

    total_aum * bps / 10000 / 12 as monthly_fee

from {{ ref('int_fee_tier_assignment') }}