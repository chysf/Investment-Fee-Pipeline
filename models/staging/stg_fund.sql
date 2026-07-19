select
    "Fund ID" as fund_id,
    "Fund Name" as fund_name,
    cast(nav as decimal(18,2)) as nav,
    category,
    risk
from {{ ref('fund_master') }}