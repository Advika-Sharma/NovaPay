{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  crm_sources: 'customers'
derived_columns:
  CUSTOMER_ID: "RAW_DATA:customer_id::varchar"
  # We add ACCOUNT_ID as a null or placeholder if it's missing from JSON
  # to ensure the Link macro doesn't fail. 
  # If there is a field in the JSON for account, replace 'NULL' with that path.
  ACCOUNT_ID: "NULL" 
  FIRST_NAME: "RAW_DATA:first_name::varchar"
  LAST_NAME: "RAW_DATA:last_name::varchar"
  EMAIL: "RAW_DATA:email::varchar"
  PHONE_NUMBER: "RAW_DATA:phone::varchar"
  BIRTH_DATE: "RAW_DATA:date_of_birth::date"
  CITY: "RAW_DATA:address:city::varchar"
  ADDRESS: "RAW_DATA:address"
  COUNTRY_CODE: "RAW_DATA:address:country::varchar"
  CUSTOMER_TIER: "RAW_DATA:customer_tier::varchar"
  JOINED_DATE: "RAW_DATA:customer_since::date"
  IS_ACTIVE_FLAG: "RAW_DATA:is_active::boolean"
  RECORD_SOURCE: "!CRM_SYSTEM"
  LOAD_DATETIME: "_LOADED_AT"
hashed_columns:
  CUSTOMER_HK: 'CUSTOMER_ID'
  # Adding these two allows your Link model to run without changes
  ACCOUNT_HK: 'ACCOUNT_ID'
  LINK_CUSTOMER_ACCOUNT_HK:
    - 'CUSTOMER_ID'
    - 'ACCOUNT_ID'
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'FIRST_NAME'
      - 'LAST_NAME'
      - 'EMAIL'
      - 'PHONE_NUMBER'
      - 'BIRTH_DATE'
      - 'CITY'
      - 'ADDRESS'
      - 'COUNTRY_CODE'
      - 'CUSTOMER_TIER'
      - 'JOINED_DATE'
      - 'IS_ACTIVE_FLAG'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     hashed_columns=metadata_dict['hashed_columns']) }}