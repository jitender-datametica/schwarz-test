CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_brick_code_lvl3_1 AS SELECT CASE
  WHEN prod_gs1_lvl3_brick_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_gs1_lvl3_brick_cd, '-1')
  END AS prod_gs1_lvl3_brick_cd,
 prod_gs1_lvl3_brick_descr,
  CASE
  WHEN prod_gs1_lvl2_brick_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_gs1_lvl2_brick_cd, '-1')
  END AS prod_gs1_lvl2_brick_cd,
 prod_gs1_lvl2_brick_descr,
  CASE
  WHEN prod_gs1_lvl1_brick_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_gs1_lvl1_brick_cd, '-1')
  END AS prod_gs1_lvl1_brick_cd,
 prod_gs1_lvl1_brick_descr
FROM ldl_dig_lec_share.v_dim_product_brick_code_lvl3_1
WHERE dwh_valid_fg
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '-1' AS dm__operand2,
 '' AS dm__operand3,
 '-1' AS dm__operand4,
 '' AS dm__operand5;