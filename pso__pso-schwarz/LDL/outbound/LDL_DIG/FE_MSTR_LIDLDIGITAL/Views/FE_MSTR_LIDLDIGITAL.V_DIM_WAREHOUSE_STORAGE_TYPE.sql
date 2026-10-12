CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse_storage_type AS SELECT wh_storage_type_cd,
 wh_storage_type_descr
FROM ldl_dig_lec_share.v_dim_warehouse_storage_type
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;