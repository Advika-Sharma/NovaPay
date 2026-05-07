{{ config(materialized='table') }}

{{ automate_dv.sat(src_pk='ACCOUNT_HK', 
                   src_hashdiff='ACCOUNT_HASHDIFF', 
                   src_payload=['ACCOUNT_TYPE', 'ACCOUNT_STATUS', 'CURRENT_BALANCE',
                    'OPENED_DATE', 'CLOSED_DATE'], 
                   src_ldts='LOAD_DATETIME', 
                   src_source='RECORD_SOURCE', 
                   source_model='stg_vault__accounts') }}