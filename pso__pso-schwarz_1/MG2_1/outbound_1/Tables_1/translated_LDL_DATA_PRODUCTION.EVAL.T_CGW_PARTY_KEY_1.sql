CREATE OR REPLACE TABLE ldl_data_production_eval.t_cgw_party_key_1 (
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