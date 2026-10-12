CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_availability_active_1 AS SELECT CASE
  WHEN PA.wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(PA.wshop_cd, '-1')
  END AS wshop_cd,
 PA.cal_dt,
 IFNULL(PA.prod_variant_sid, -1) AS prod_variant_sid,
 PA.active_fg,
 PA.prod_variant_nr,
 PA.is_orderable_fg,
 PA.is_visible_fg,
 PA.is_replenishment_considered_fg,
 PA.is_avail_in_store_fg,
 PA.is_in_stock_fg,
  CASE
  WHEN PA.avail_lvl_cd = ''
  THEN '-1'
  ELSE IFNULL(PA.avail_lvl_cd, '-1')
  END AS avail_lvl,
  CASE
  WHEN PA.prod_orderable_lvl_cd = ''
  THEN '-1'
  ELSE IFNULL(PA.prod_orderable_lvl_cd, '-1')
  END AS prod_orderable_lvl_cd,
 PA.src_catalog_name,
 PA.is_in_promo_fg,
 PA.max_order_qty,
 PA.total_stock_qty,
 PA.locale_name,
 PA.is_legacy_fg,
 PA.is_sold_out_fg,
 PVR.prod_sid,
 PVR.prod_nr,
 PVR.reg_prod_name,
 COALESCE(MAX(PA.avail_lvl_cd) OVER (PARTITION BY PVR.wshop_cd, PA.cal_dt, CAST(PVR.prod_sid AS STRING) RANGE BETWEEN
   UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), '-1') AS avail_lvl_product,
 MAX(PA.is_orderable_fg) OVER (PARTITION BY PVR.wshop_cd, PA.cal_dt, CAST(PVR.prod_sid AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS is_orderable_fg_product,
 MAX(PA.is_visible_fg) OVER (PARTITION BY PVR.wshop_cd, PA.cal_dt, CAST(PVR.prod_sid AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS is_visible_fg_product,
 MAX(PA.is_replenishment_considered_fg) OVER (PARTITION BY PVR.wshop_cd, PA.cal_dt, CAST(PVR.prod_sid AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS is_replenishment_considered_fg_product,
 MAX(PA.is_avail_in_store_fg) OVER (PARTITION BY PVR.wshop_cd, PA.cal_dt, CAST(PVR.prod_sid AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS is_avail_in_store_fg_product,
 MAX(PA.is_in_stock_fg) OVER (PARTITION BY PVR.wshop_cd, PA.cal_dt, CAST(PVR.prod_sid AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS is_in_stock_fg_product
FROM ldl_dig_lec_share.v_fact_product_variant_availability_1 AS PA
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_rel_product_variant_regional_1 AS PVR ON PA.prod_variant_sid = PVR.prod_variant_sid
    AND PA.wshop_cd = PVR.wshop_cd
WHERE PA.active_fg;