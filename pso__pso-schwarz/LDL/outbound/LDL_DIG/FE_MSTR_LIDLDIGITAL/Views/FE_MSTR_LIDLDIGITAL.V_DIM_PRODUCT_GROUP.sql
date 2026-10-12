CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_group (prod_group_cd, prod_group_descr) AS SELECT
 prod_group_cd,
 prod_group_descr
FROM ldl_dig_lec_share.v_dim_product_group
UNION ALL
SELECT '-1',
 '';