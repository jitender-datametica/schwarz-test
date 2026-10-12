CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_material_type_2 (prod_material_type_cd,
prod_material_type_descr) AS SELECT prod_material_type_cd,
 prod_material_type_descr
FROM ldl_dig_lec_share.v_dim_product_material_type_2
UNION ALL
SELECT '-1',
 '';