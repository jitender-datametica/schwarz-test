CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_online_status_1 (prod_online_status_cd,
prod_online_status_descr) AS SELECT prod_online_status_cd,
 prod_online_status_descr
FROM ldl_dig_lec_share.v_dim_product_online_status_1
UNION ALL
SELECT '-1',
 '';