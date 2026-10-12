CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_build_sql_key (
build_sql_keys_id INTEGER NOT NULL,
key_name STRING(250),
cust_key STRING(250),
kunnr STRING(250),
type_cd STRING(250),
cust_type STRING(250),
parent_key_name STRING(250),
parent_key_value STRING(250)
);