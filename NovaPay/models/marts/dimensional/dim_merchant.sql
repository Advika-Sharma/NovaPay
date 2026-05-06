{{ config(materialized='table', schema='DIMENSIONAL') }}

select 
    merchant_id,
    merchant_name,
    merchant_category,
    merchant_city as MERCHANT_CITY, 
    case when is_active_flag = true then 'Active' else 'Inactive' end as MERCHANT_STATUS,
    loaded_at
from {{ ref('stg_transactions__merchants') }}