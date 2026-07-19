select
    client_id,
    sum(market_value) as total_aum
from {{ ref('int_portfolio_value') }}
group by client_id