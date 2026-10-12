CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_return_pack_sid_1 (
return_pack_sid BIGNUMERIC(38,0),
cust_order_nr STRING(20),
return_pack_tracking_nr STRING(20),
cust_order_pos_nr BIGNUMERIC(38,0),
lead_src_log_sys_cd STRING(5),
lead_src_name STRING(100),
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);