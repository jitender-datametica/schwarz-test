CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_cust_key_audit (
cust_key_audit_id INTEGER NOT NULL,
deletions_exec_id INTEGER,
kunnr STRING(50),
key_name STRING(50),
cust_key STRING(50),
tmsp_insert DATETIME,
tmsp_update DATETIME
);