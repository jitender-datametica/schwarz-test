CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse_order_line_process_status_2 (wh_order_line_process_status_cd
, wh_order_line_process_status_descr) AS SELECT IFNULL(wh_order_line_process_status_cd, -1) AS
 wh_order_line_process_status_cd,
 wh_order_line_process_status_descr
FROM ldl_dig_lec_share.v_dim_warehouse_order_line_process_status_2
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '';