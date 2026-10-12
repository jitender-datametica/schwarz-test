CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_delivery_order_sid_1 (
lead_src_name STRING(100),
lead_src_log_sys_cd STRING(5),
delivery_order_nr STRING(20),
delivery_order_sid BIGNUMERIC,
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);