{{ config(materialized='view') }}

with payments as (
    select * from {{ ref('stg_transactions__payments') }}
),
accounts as (
    select * from {{ ref('stg_transactions__accounts') }}
),
merchants as (
    select * from {{ ref('stg_transactions__merchants') }}
)

select
    p.payment_id,
    p.customer_id,
    p.account_id,
    p.merchant_id,
    p.payment_date,
    p.payment_amount,
    p.fee_amount,
    (p.payment_amount - p.fee_amount) as net_amount,
    case when p.payment_amount < 0 then true else false end as is_refund,
    p.currency_code,
    p.status,
    p.loaded_at
from payments p
left join accounts a on p.account_id = a.account_id
left join merchants m on p.merchant_id = m.merchant_id