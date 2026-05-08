{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  transaction_sources: 'accounts'
derived_columns:
  # MINIMAL CHANGE: Explicitly map the source columns here
  # This ensures the macro "sees" them even if there's a case or alias issue
  ACCOUNT_ID: 'ACCOUNT_ID'
  CUSTOMER_ID: 'CUSTOMER_ID'
  ACCOUNT_TYPE: 'ACCOUNT_TYPE'
  ACCOUNT_STATUS: 'ACCOUNT_STATUS'
  CURRENT_BALANCE: 'CURRENT_BALANCE'
  OPENED_DATE: 'OPENING_DATE'
  CLOSED_DATE: 'CLOSING_DATE'
  RECORD_SOURCE: '!TRANSACTIONS_SYSTEM'
  LOAD_DATETIME: 'CURRENT_TIMESTAMP()'
hashed_columns:
  ACCOUNT_HK: 'ACCOUNT_ID'
  CUSTOMER_HK: 'CUSTOMER_ID'
  LINK_CUSTOMER_ACCOUNT_HK:
    - 'CUSTOMER_ID'
    - 'ACCOUNT_ID'
  ACCOUNT_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'ACCOUNT_TYPE'
      - 'ACCOUNT_STATUS'
      - 'CURRENT_BALANCE'
      - 'OPENED_DATE'
      - 'CLOSED_DATE'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     hashed_columns=metadata_dict['hashed_columns']) }}