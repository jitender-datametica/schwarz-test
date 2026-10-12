CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_sales_promotion_type AS SELECT CASE
  WHEN sale_promo_type_cd = ''
  THEN '-1'
  ELSE IFNULL(sale_promo_type_cd, '-1')
  END AS sale_promo_type_cd,
 sale_promo_type_name,
 sale_promo_type_descr,
  CASE
  WHEN sale_promo_type_cd = ''
  THEN '-1'
  ELSE IFNULL(sale_promo_type_cd, '-1')
  END AS sale_promo_type_cd_technical
FROM ldl_dig_lec_share.v_dim_sales_promotion_type
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2,
 '' AS dm__operand3;