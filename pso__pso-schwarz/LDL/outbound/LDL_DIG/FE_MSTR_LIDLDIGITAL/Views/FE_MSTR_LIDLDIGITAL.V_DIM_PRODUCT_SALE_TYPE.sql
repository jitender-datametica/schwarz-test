CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_sale_type (prod_sale_type_cd, prod_sale_type_descr) AS
SELECT prod_sale_type_cd,
 prod_sale_type_descr
FROM ldl_dig_lec_share.v_dim_product_sale_type
UNION ALL
SELECT '-1',
 '';