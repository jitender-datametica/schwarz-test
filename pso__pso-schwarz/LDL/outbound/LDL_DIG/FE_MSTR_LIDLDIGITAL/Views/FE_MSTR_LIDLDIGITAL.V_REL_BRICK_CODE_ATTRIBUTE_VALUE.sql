CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_brick_code_attribute_value (attr_cd, prod_brick_cd, attr_descr
) AS SELECT CASE
  WHEN attr_cd = ''
  THEN '-1'
  ELSE IFNULL(attr_cd, '-1')
  END AS attr_cd,
  CASE
  WHEN prod_brick_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_brick_cd, '-1')
  END AS prod_brick_cd,
 attr_descr
FROM ldl_dig_lec_share.v_rel_brick_code_attribute_value
WHERE dwh_valid_fg;