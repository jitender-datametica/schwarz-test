CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_stock_warehouse_storage_location_daily_1 (wh_sid, storage_loc_cd
, prod_variant_sid, cal_dt, active_fg, wh_cd, stock_sys_type_cd, blocked_stock_cnt, blocked_stock_return_cnt,
unrestricted_stock_cnt, restricted_stock_cnt, in_transfer_cnt, in_qty_inspection_cnt, total_stock_cnt) AS SELECT wh_sid
 ,
  CASE
  WHEN storage_loc_cd = ''
  THEN '-1'
  ELSE IFNULL(storage_loc_cd, '-1')
  END AS storage_loc_cd,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
 cal_dt,
 active_fg,
 wh_cd,
 CAST(NULL AS STRING) AS stock_sys_type_cd,
 blocked_stock_cnt,
 blocked_stock_return_cnt,
 unrestricted_stock_cnt,
 restricted_stock_cnt,
 in_transfer_cnt,
 in_qty_inspection_cnt,
 CAST(NULL AS BIGNUMERIC) AS total_stock_cnt
FROM ldl_dig_lec_share.v_fact_stock_warehouse_storage_location_daily_1;