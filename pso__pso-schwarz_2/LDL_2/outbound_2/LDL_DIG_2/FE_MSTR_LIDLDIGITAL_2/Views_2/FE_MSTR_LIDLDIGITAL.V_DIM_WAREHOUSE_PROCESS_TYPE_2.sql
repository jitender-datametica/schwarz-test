CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse_process_type_2 AS SELECT wh_process_type_cd,
 wh_process_type_descr
FROM ldl_dig_lec_share.v_dim_warehouse_process_type_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;