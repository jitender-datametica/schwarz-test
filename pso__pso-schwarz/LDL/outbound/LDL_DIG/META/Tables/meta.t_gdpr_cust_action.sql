CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_cust_action (
cust_action_id INTEGER,
exec_cust_id INTEGER NOT NULL,
cust_key_id INTEGER NOT NULL,
deletion_table_id INTEGER NOT NULL,
cust_action INTEGER NOT NULL,
tmsp_insert DATETIME
);