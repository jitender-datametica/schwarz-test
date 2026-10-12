CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse (wh_sid, wh_cd, wh_name, wh_type_cd,
is_run_by_ext_company, wh_storage_type_cd, is_wine_storage_fg) AS SELECT wh_sid,
  CASE
  WHEN wh_cd = ''
  THEN '-1'
  ELSE IFNULL(wh_cd, '-1')
  END AS wh_cd,
 wh_name,
  CASE
  WHEN wh_type_cd = ''
  THEN '-1'
  ELSE IFNULL(wh_type_cd, '-1')
  END AS wh_type_cd,
 is_run_by_ext_company,
  CASE
  WHEN wh_storage_type_cd = ''
  THEN '-1'
  ELSE IFNULL(wh_storage_type_cd, '-1')
  END AS wh_storage_type_cd,
 is_wine_storage_fg
FROM ldl_dig_lec_share.v_dim_warehouse
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '-1',
 '',
 '-1',
 FALSE,
 '-1',
 CAST('FALSE' AS BOOL);