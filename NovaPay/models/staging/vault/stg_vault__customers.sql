{{ automate_dv.stage(include_source_columns=true,
                     source_model='stg_crm__customers',
                     derived_columns={
                         'RECORD_SOURCE': '!CRM_SYSTEM',
                         'LOAD_DATETIME': 'CURRENT_TIMESTAMP()'
                     },
                     hashed_columns={
                         'CUSTOMER_HK': 'CUSTOMER_ID',
                         'CUSTOMER_HASHDIFF': {
                             'is_hashdiff': true,
                             'columns': ['FIRST_NAME', 'LAST_NAME', 'EMAIL']
                         }
                     }) }}