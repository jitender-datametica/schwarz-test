CREATE OR REPLACE TABLE ldl_data_production_fe_mstr_temp.txxx_2 (
param_id INTEGER,
country_org_cd STRING(2),
param_status_cd STRING(20),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
param_val_qty NUMERIC(29,5),
requestor_user_name STRING(100),
request_tmsp TIMESTAMP,
approver_user_name STRING(100),
approved_tmsp TIMESTAMP,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER,
dwh_node_cd STRING(20)
);