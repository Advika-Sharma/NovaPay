{{ config(materialized='incremental') }}

{{ automate_dv.sat(src_pk='ACCOUNT_HK', 
                   src_hashdiff='ACCOUNT_HASHDIFF', 
                   src_payload=['ACCOUNT_TYPE', 'ACCOUNT_STATUS'], 
                   src_ldts='LOAD_DATETIME', 
                   src_source='RECORD_SOURCE', 
                   source_model='stg_vault__accounts') }}