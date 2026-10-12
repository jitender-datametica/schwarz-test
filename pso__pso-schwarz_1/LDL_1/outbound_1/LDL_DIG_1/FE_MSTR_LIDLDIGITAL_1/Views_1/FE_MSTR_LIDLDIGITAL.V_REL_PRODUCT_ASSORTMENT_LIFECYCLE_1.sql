CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_product_assortment_lifecycle_1 AS SELECT CASE
  WHEN prod_assortment_lifecycle_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_assortment_lifecycle_cd, '-1')
  END AS prod_assortment_lifecycle_cd,
  CASE
  WHEN prod_assortment_lifecycle_cat_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_assortment_lifecycle_cat_cd, '-1')
  END AS prod_assortment_lifecycle_cat_cd,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
  CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd
FROM ldl_dig_lec_share.v_rel_product_assortment_lifecycle_1
WHERE dwh_valid_fg;