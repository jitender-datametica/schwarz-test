CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_assortment_classification_1 (prod_assortment_class_cd,
prod_assortment_class_descr) AS SELECT prod_assortment_class_cd,
 prod_assortment_class_descr
FROM ldl_dig_lec_share.v_dim_product_assortment_classification_1
UNION ALL
SELECT '-1',
 '';