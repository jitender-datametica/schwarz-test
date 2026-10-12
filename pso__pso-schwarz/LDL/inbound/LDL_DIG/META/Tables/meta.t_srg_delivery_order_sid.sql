CREATE TABLE meta.t_srg_delivery_order_sid(
   lead_src_name VARCHAR(100),
   lead_src_log_sys_cd VARCHAR(5),
   delivery_order_nr VARCHAR(20),
   delivery_order_sid NUMBER AUTOINCREMENT,
   SRC_TABLE_NAME	VARCHAR(250),
   DWH_CREATED_TMSP	TIMESTAMP_LTZ(9)
);