CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_dangerous_good_classification_1 (prod_dang_good_class_cd
, prod_dang_good_class_descr) AS SELECT prod_dang_good_class_cd,
 prod_dang_good_class_descr
FROM ldl_dig_lec_share.v_dim_product_dangerous_good_classification_1
UNION ALL
SELECT '-1',
 '';