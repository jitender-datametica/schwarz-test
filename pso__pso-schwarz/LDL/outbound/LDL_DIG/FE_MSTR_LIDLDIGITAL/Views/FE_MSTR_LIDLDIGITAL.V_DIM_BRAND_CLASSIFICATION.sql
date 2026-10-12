CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_brand_classification (brand_class_cd, brand_class_descr,
brand_class_descr_dbr) AS SELECT brand_class_cd,
 brand_class_descr,
 brand_class_descr AS brand_class_descr_dbr
FROM ldl_dig_lec_share.v_dim_brand_classification
UNION ALL
SELECT '-1',
 '',
 'Sonst';