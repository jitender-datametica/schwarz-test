CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_billing_doc_sid_2 (
billing_doc_sid BIGNUMERIC(38,0),
billing_doc_nr STRING(50),
lead_src_log_sys_cd STRING(5),
lead_src_name STRING(100),
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);