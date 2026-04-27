{{ config(materialized='table', schema='DIMENSIONAL') }}

select 
    ACCOUNT_ID,
    CUSTOMER_ID,
    ACCOUNT_TYPE,
    ACCOUNT_STATUS,
    CURRENT_BALANCE,
    OPENED_DATE,
    CLOSED_DATE
from {{ ref('stg_transactions__accounts') }}