-- tests/closing_date_closed_accounts.sql

with accounts as (
    select * from {{ ref('stg_transactions__accounts') }}
)

select
    account_id,
    account_status, 
    closed_date
from accounts
where account_status = 'closed'
  and closed_date is null