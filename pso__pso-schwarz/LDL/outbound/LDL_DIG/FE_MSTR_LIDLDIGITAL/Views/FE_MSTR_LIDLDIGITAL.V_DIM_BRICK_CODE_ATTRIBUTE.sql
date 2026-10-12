CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_brick_code_attribute AS SELECT CASE
  WHEN attr_cd = ''
  THEN '-1'
  ELSE IFNULL(attr_cd, '-1')
  END AS attr_cd,
 attr_descr,
 is_custom_fg
FROM ldl_dig_lec_share.v_dim_brick_code_attribute
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 FALSE AS dm__operand2;