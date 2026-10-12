CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_return_reason_1 (prod_return_reason_cd,
prod_return_reason_descr) AS SELECT prod_return_reason_cd,
 prod_return_reason_descr
FROM ldl_dig_lec_share.v_dim_product_return_reason_1
UNION ALL
SELECT '-1',
 'No reason provided';