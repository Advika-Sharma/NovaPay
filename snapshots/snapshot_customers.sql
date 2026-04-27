{% snapshot snapshot_customers %}

{{
    config(
      target_schema='SNAPSHOTS',
      unique_key='CUSTOMER_ID',
      strategy='check',
      check_cols=['CUSTOMER_TIER', 'ADDRESS', 'IS_ACTIVE_STATUS'],
    )
}}

select * from {{ ref('stg_crm__customers') }}

{% endsnapshot %}