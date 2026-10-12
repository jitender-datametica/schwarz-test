CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_availability_level_2 AS SELECT CASE
  WHEN avail_lvl_cd = ''
  THEN '-1'
  ELSE IFNULL(avail_lvl_cd, '-1')
  END AS avail_lvl_cd,
 avail_lvl_descr
FROM ldl_dig_lec_share.v_dim_product_availability_level_2
UNION ALL
SELECT '-1' AS dm__operand0,
 'Offline' AS dm__operand1;