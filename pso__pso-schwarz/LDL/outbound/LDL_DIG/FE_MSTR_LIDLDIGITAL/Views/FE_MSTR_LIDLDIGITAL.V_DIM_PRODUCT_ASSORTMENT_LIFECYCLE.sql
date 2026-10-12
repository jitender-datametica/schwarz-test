CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_assortment_lifecycle AS SELECT CASE
  WHEN prod_assortment_lifecycle_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_assortment_lifecycle_cd, '-1')
  END AS prod_assortment_lifecycle_cd,
 prod_assortment_lifecycle_descr
FROM ldl_dig_lec_share.v_dim_product_assortment_lifecycle
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;