CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_coupon_type_2 AS SELECT CASE
  WHEN coupon_type_cd = ''
  THEN '-1'
  ELSE IFNULL(coupon_type_cd, '-1')
  END AS coupon_type_cd,
 coupon_type_descr
FROM ldl_dig_lec_share.v_dim_coupon_type_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;