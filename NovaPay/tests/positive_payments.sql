-- tests/positive_payments.sql
with payments as (
    select * from {{ ref('stg_transactions__payments') }}
)

select
    payment_id,
    payment_amount
from payments
where status = 'completed'
  and payment_amount < 0