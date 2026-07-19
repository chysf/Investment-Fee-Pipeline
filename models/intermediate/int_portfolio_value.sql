select
    h.client_id,
    h.fund_id,
    f.fund_name,
    h.units,
    f.nav,
    h.units * f.nav as market_value
from {{ ref('stg_holdings') }} h
left join {{ ref('stg_fund') }} f
    on h.fund_id = f.fund_id