CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_promotional_classification_1 (prod_promo_class_cd,
prod_promo_class_descr) AS SELECT prod_promo_class_cd,
 prod_promo_class_descr
FROM ldl_dig_lec_share.v_dim_product_promotional_classification_1
UNION ALL
SELECT '-1',
 '';