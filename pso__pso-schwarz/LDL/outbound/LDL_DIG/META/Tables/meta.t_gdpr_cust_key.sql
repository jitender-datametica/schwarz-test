CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_cust_key (
cust_key_id INTEGER NOT NULL,
exec_cust_id INTEGER NOT NULL,
key_name_id INTEGER NOT NULL,
parent_key_name_id INTEGER,
parent_key_value STRING(250),
cust_key STRING(250),
tmsp_insert DATETIME
);