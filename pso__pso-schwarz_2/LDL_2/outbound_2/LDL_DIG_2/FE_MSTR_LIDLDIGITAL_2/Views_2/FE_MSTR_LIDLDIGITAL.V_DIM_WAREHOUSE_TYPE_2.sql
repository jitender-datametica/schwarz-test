CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse_type_2 (wh_type_cd, wh_type_descr) AS SELECT wh_type_cd
 ,
 wh_type_descr
FROM ldl_dig_lec_share.v_dim_warehouse_type_2
UNION ALL
SELECT '-1',
 '';