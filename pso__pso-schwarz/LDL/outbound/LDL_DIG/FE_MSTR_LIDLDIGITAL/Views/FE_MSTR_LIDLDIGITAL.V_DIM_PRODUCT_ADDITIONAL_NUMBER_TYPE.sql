CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_additional_number_type (prod_add_nr_type_cd,
prod_add_nr_type_descr) AS SELECT prod_add_nr_type_cd,
 prod_add_nr_type_descr
FROM ldl_dig_lec_share.v_dim_product_additional_number_type
UNION ALL
SELECT '-1',
 '';