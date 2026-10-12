CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_utilisation_1 AS SELECT prod_sid,
  CASE
  WHEN util_action_cd = ''
  THEN '-1'
  ELSE IFNULL(util_action_cd, '-1')
  END AS util_action_cd,
 exception_util_dt
FROM ldl_dig_lec_share.v_fact_product_utilisation_1
WHERE dwh_valid_fg;