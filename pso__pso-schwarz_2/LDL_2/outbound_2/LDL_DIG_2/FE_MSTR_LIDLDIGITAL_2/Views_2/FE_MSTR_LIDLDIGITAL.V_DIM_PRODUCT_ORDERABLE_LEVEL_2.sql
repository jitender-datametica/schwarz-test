CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_orderable_level_2 AS SELECT CASE
  WHEN prod_orderable_lvl_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_orderable_lvl_cd, '-1')
  END AS prod_orderable_lvl_cd,
 prod_orderable_lvl_descr
FROM ldl_dig_lec_share.v_dim_product_orderable_level_2
UNION DISTINCT
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;