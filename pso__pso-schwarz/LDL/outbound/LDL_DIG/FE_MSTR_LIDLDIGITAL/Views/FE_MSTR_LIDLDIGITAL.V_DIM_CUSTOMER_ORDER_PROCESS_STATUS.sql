CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_order_process_status (cust_order_process_status_cd,
cust_order_process_status_descr) AS SELECT cust_order_process_status_cd,
 cust_order_process_status_descr
FROM ldl_dig_lec_share.v_dim_customer_order_process_status
UNION ALL
SELECT '-1',
 '';