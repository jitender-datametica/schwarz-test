CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_availability_2 (wshop_cd, cal_dt, prod_sid, prod_nr,
active_fg, is_orderable_fg, is_visible_fg, is_sold_out_fg, is_replenishment_considered_fg, is_avail_in_store_fg,
is_in_stock_fg, avail_lvl, prod_orderable_lvl_cd, total_stock_qty) AS SELECT CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
 cal_dt,
 IFNULL(prod_sid, -1) AS prod_sid,
 prod_nr,
 active_fg,
 is_orderable_fg,
 is_visible_fg,
 is_sold_out_fg,
 IF(is_replenishment_considered_fg IS NULL, NULL, IF(is_replenishment_considered_fg, 'YES', 'NO')) AS
 is_replenishment_considered_fg,
 is_avail_in_store_fg,
 is_in_stock_fg,
  CASE
  WHEN avail_lvl_cd = ''
  THEN '-1'
  ELSE IFNULL(avail_lvl_cd, '-1')
  END AS avail_lvl,
  CASE
  WHEN prod_orderable_lvl_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_orderable_lvl_cd, '-1')
  END AS prod_orderable_lvl_cd,
 total_stock_qty
FROM ldl_dig_lec_share.v_fact_product_availability_2;