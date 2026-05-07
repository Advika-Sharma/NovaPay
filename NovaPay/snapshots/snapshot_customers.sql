{% snapshot snapshot_customers %}

{{
    config(
      unique_key='CUSTOMER_ID',
      strategy='check',
      check_cols='all',
    )
}}

-- This selects from your staging model which contains tier, address, and status
select * from {{ ref('stg_crm__customers') }}

{% endsnapshot %}