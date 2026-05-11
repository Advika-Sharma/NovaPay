{{ 
    config(
        materialized='incremental',
        unique_key='payment_id',
        schema='DIMENSIONAL'
    ) 
}}

select * from {{ ref('int_fct_payments') }}

{% if is_incremental() %}
  where loaded_at >= (
    select coalesce(max(loaded_at), '1900-01-01'::timestamp_ntz) from {{ this }}
  )
{% endif %}

qualify row_number() over (
    partition by payment_id
    order by loaded_at desc
) = 1