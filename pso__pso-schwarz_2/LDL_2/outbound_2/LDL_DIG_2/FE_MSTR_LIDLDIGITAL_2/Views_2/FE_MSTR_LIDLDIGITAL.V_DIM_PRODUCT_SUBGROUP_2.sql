CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_subgroup_2 (prod_subgroup_cd, prod_subgroup_descr,
prod_group_cd) AS SELECT CASE
  WHEN prod_subgroup_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_subgroup_cd, '-1')
  END AS prod_subgroup_cd,
  CASE
  WHEN prod_subgroup_descr = ''
  THEN '-1'
  ELSE IFNULL(prod_subgroup_descr, '-1')
  END AS prod_subgroup_descr,
  CASE
  WHEN prod_group_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_group_cd, '-1')
  END AS prod_group_cd
FROM ldl_dig_lec_share.v_dim_product_subgroup_2
UNION ALL
SELECT '-1',
 '',
 '-1';