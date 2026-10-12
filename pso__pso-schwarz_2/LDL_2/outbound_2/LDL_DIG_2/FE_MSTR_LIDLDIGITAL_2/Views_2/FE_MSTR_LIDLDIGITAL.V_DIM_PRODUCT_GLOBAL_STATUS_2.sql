CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_global_status_2 (prod_global_status_cd,
prod_global_status_descr) AS SELECT prod_global_status_cd,
 prod_global_status_descr
FROM ldl_dig_lec_share.v_dim_product_global_status_2
UNION ALL
SELECT '-1',
 '';