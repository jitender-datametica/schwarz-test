CREATE OR REPLACE TABLE ldl_data_production_etl.t_sales_account_manager_remapped_keys (
int_org_sid INTEGER,
int_org_type_cd STRING(20),
int_org_name STRING(300),
party_sid INTEGER,
party_key_type_cd STRING(20),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
party_nat_key_nr STRING(250),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER,
dwh_node_cd STRING(20)
);