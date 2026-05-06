{{ config(materialized='table', schema='DIMENSIONAL') }}

with customers as (
    select * from {{ ref('stg_crm__customers') }}
),
credit_scores as (
    select * from {{ ref('stg_vendor__credit_scores') }}
    qualify row_number() over(partition by customer_id order by loaded_at desc) = 1
)
select
    c.customer_id,
    c.customer_tier as CUSTOMER_TIER, 
    c.address as ADDRESS,            
    c.is_active_flag as IS_ACTIVE_STATUS, 
    cs.credit_score,
    cs.risk_category
from customers c
left join credit_scores cs on c.customer_id = cs.customer_id