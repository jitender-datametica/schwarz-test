CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_coupon AS SELECT coupon_id,
  CASE
  WHEN coupon_cd = ''
  THEN '-1'
  ELSE IFNULL(coupon_cd, '-1')
  END AS coupon_cd,
  CASE
  WHEN coupon_promo_cd = ''
  THEN '-1'
  ELSE IFNULL(coupon_promo_cd, '-1')
  END AS coupon_promo_cd,
 coupon_promo_name,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(coupon_valid_from_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS coupon_valid_from_tmsp,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(coupon_valid_to_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS coupon_valid_to_tmsp,
  CASE
  WHEN coupon_type_cd = ''
  THEN '-1'
  ELSE IFNULL(coupon_type_cd, '-1')
  END AS coupon_type_cd,
  CASE
  WHEN coupon_discount_type_cd = ''
  THEN '-1'
  ELSE IFNULL(coupon_discount_type_cd, '-1')
  END AS coupon_discount_type_cd,
 coupon_max_redemption_cnt,
  CASE
  WHEN prod_food_class_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_food_class_cd, '-1')
  END AS prod_food_class_cd,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
 discount_ship_fg,
 coupon_discount_pct,
 coupon_discount_gross_local_val
FROM ldl_dig_lec_share.v_dim_coupon
UNION ALL
SELECT '-1' AS dm__operand0,
 '-1' AS dm__operand1,
 '-1' AS dm__operand2,
 '-1' AS dm__operand3,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dm__operand4,
 CAST('2999-01-01 00:00:00' AS DATETIME) AS dm__operand5,
 '-1' AS dm__operand6,
 '-1' AS dm__operand7,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand8,
 '-1' AS dm__operand9,
 '-1' AS dm__operand10,
 FALSE AS dm__operand11,
 ROUND(CAST('0' AS BIGNUMERIC), 5) AS dm__operand12,
 ROUND(CAST('0' AS BIGNUMERIC), 5) AS dm__operand13;