CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_stock_warehouse_packaging_daily_1 AS SELECT wh_sid,
 storage_loc_cd,
  CASE
  WHEN pack_material_nr = ''
  THEN '-1'
  ELSE IFNULL(pack_material_nr, '-1')
  END AS pack_material_nr,
 cal_dt,
 active_fg,
 blocked_stock_cnt,
 unrestricted_stock_cnt,
 restricted_stock_cnt,
 in_transfer_cnt,
 in_qty_inspection_cnt
FROM ldl_dig_lec_share.v_fact_stock_warehouse_packaging_daily_1;