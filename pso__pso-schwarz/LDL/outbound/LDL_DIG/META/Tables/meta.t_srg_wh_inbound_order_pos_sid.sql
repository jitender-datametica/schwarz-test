CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_wh_inbound_order_pos_sid (
wh_inbound_order_pos_sid BIGNUMERIC(38,0),
src_inbound_order_pos_id STRING(64),
lead_src_name STRING(100),
lead_src_log_sys_cd STRING(5),
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);