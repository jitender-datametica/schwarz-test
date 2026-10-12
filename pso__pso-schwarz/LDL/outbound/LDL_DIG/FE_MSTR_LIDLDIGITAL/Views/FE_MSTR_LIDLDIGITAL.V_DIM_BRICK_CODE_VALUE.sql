CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_brick_code_value AS SELECT CASE
  WHEN value_cd = ''
  THEN '-1'
  ELSE IFNULL(value_cd, '-1')
  END AS value_cd,
 value_descr,
 is_custom_fg
FROM ldl_dig_lec_share.v_dim_brick_code_value
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 FALSE AS dm__operand2;