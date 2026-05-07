{{ automate_dv.stage(include_source_columns=true,
                     source_model='stg_transactions__accounts',
                     derived_columns={
                         'RECORD_SOURCE': '!TRANSACTIONS_SYSTEM',
                         'LOAD_DATETIME': 'CURRENT_TIMESTAMP()'
                     },
                     hashed_columns={
                         'ACCOUNT_HK': 'ACCOUNT_ID',
                         'CUSTOMER_HK': 'CUSTOMER_ID',
                         'LINK_CUSTOMER_ACCOUNT_HK': ['CUSTOMER_ID', 'ACCOUNT_ID'],
                         'ACCOUNT_HASHDIFF': {
                             'is_hashdiff': true,
                             'columns': ['ACCOUNT_TYPE', 'ACCOUNT_STATUS']
                         }
                     }) }}