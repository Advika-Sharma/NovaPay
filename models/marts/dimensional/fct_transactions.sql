{{ config(materialized='table', schema='DIMENSIONAL') }}

select
    payment_id,
    customer_id,
    account_id,
    merchant_id,
    payment_amount,
    currency_code as PAYMENT_CURRENCY, 
    status as PAYMENT_STATUS,  
    payment_date
from {{ ref('stg_transactions__payments') }}