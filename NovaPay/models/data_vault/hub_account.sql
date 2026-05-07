{{ config(materialized='table') }}

{{ automate_dv.hub(src_pk='ACCOUNT_HK', 
                   src_nk='ACCOUNT_ID', 
                   src_ldts='LOAD_DATETIME', 
                   src_source='RECORD_SOURCE', 
                   source_model='stg_vault__accounts') }}