CREATE TABLE meta.t_srg_cust_order_sid_2(
   cust_order_sid NUMBER AUTOINCREMENT,
   cust_order_nr VARCHAR(20),
   lead_src_log_sys_cd VARCHAR(5),
   lead_src_name VARCHAR(100),
   SRC_TABLE_NAME	VARCHAR(250),
   DWH_CREATED_TMSP	TIMESTAMP_LTZ(9)
);