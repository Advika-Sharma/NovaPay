{{ config(materialized='incremental') }}

{{ automate_dv.hub(src_pk='CUSTOMER_HK', 
                   src_nk='CUSTOMER_ID', 
                   src_ldts='LOAD_DATETIME', 
                   src_source='RECORD_SOURCE', 
                   source_model='stg_vault__customers') }}