CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_assortment_lifecycle_category AS SELECT CASE
  WHEN prod_assortment_lifecycle_cat_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_assortment_lifecycle_cat_cd, '-1')
  END AS prod_assortment_lifecycle_cat_cd,
 prod_assortment_lifecycle_cat_descr,
  CASE
  WHEN prod_assortment_lifecycle_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_assortment_lifecycle_cd, '-1')
  END AS prod_assortment_lifecycle_cd
FROM ldl_dig_lec_share.v_dim_product_assortment_lifecycle_category
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '-1' AS dm__operand2;