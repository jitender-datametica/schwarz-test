CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_wh_order_sid_2 (
wh_order_sid BIGNUMERIC(38,0),
wh_order_nr STRING(64),
lead_src_name STRING(100),
lead_src_log_sys_cd STRING(5),
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);