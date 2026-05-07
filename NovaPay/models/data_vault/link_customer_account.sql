{{ config(materialized='table') }}

{{ automate_dv.link(src_pk='LINK_CUSTOMER_ACCOUNT_HK', 
                    src_fk=['CUSTOMER_HK', 'ACCOUNT_HK'], 
                    src_ldts='LOAD_DATETIME', 
                    src_source='RECORD_SOURCE', 
                    source_model=['stg_vault__accounts', 'stg_vault__customers']) }}

                    