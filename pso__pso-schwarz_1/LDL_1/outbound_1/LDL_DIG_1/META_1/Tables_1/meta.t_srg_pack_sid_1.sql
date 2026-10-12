CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_pack_sid_1 (
pack_sid BIGNUMERIC(38,0),
pack_order_nr STRING(20),
lead_src_name STRING(100),
lead_src_log_sys_cd STRING(5),
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);