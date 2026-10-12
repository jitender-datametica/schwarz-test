CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse_storage_location_1 (wh_sid, wh_cd, storage_loc_cd,
storage_loc_descr) AS SELECT wh_sid,
  CASE
  WHEN wh_cd = ''
  THEN '-1'
  ELSE IFNULL(wh_cd, '-1')
  END AS wh_cd,
  CASE
  WHEN storage_loc_cd = ''
  THEN '-1'
  ELSE IFNULL(storage_loc_cd, '-1')
  END AS storage_loc_cd,
 storage_loc_descr
FROM ldl_dig_lec_share.v_dim_warehouse_storage_location_1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '-1',
 '-1',
 '';