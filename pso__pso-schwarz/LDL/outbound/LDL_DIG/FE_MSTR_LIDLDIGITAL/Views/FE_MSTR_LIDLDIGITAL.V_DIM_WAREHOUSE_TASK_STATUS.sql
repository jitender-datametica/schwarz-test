CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse_task_status AS SELECT wh_task_status_cd,
 wh_task_status_descr
FROM ldl_dig_lec_share.v_dim_warehouse_task_status
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;