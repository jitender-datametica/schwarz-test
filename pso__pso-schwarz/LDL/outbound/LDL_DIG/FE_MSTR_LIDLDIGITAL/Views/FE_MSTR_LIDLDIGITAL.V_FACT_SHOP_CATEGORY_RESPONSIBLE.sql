CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_shop_category_responsible AS SELECT CASE
  WHEN prod_brick_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_brick_cd, '-1')
  END AS prod_brick_cd,
 resp_team_name,
 cat_manager_name
FROM ldl_dig_lec_share.v_fact_shop_category_responsible
WHERE dwh_valid_fg;