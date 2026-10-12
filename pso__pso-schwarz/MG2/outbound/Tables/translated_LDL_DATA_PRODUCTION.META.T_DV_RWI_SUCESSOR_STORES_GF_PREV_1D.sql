CREATE OR REPLACE TABLE ldl_data_production_meta.t_dv_rwi_sucessor_stores_gf_prev_1d (
init_store_nr STRING(16777216),
init_store_sid INTEGER,
next_store_nr STRING(16777216),
next_store_sid INTEGER,
next_store_sid_created_tmsp TIMESTAMP,
failed INTEGER,
total INTEGER,
rule_code STRING(255),
rule_description STRING(255),
metric STRING(255),
dataelem STRING(255),
dataelem_value INTEGER,
collection_time TIMESTAMP
);