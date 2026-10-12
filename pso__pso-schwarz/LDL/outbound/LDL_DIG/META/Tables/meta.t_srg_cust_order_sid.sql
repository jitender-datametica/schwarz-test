CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_cust_order_sid (
cust_order_sid BIGNUMERIC,
cust_order_nr STRING(20),
lead_src_log_sys_cd STRING(5),
lead_src_name STRING(100),
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);