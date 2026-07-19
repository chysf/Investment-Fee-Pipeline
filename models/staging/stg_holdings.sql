select
    holding_id,
    client_id,
    fund_id,
    cast(units as integer) as units
from {{ ref('fact_holdings') }}