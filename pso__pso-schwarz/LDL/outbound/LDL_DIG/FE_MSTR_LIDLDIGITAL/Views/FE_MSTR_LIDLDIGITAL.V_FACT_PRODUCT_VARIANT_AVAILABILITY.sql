CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_variant_availability (wshop_cd, cal_dt,
prod_variant_sid, active_fg, prod_variant_nr, is_orderable_fg, is_visible_fg, is_replenishment_considered_fg,
is_avail_in_store_fg, is_in_stock_fg, avail_lvl, prod_orderable_lvl_cd, prod_orderable_lvl_cd_product,
content_classification_rating, src_catalog_name, is_in_promo_fg, max_order_qty, total_stock_qty, locale_name,
is_legacy_fg, is_sold_out_fg, prod_sid, prod_nr, reg_prod_name, avail_lvl_product, is_orderable_fg_product,
is_visible_fg_product, is_replenishment_considered_fg_product, is_avail_in_store_fg_product, is_in_stock_fg_product) AS
SELECT CASE
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
 IF(PA.is_replenishment_considered_fg IS NULL, NULL, IF(PA.is_replenishment_considered_fg, 'YES', 'NO')) AS
 is_replenishment_considered_fg,
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
 COALESCE(MAX(PA.prod_orderable_lvl_cd) OVER (PARTITION BY PVR.wshop_cd, PA.cal_dt, CAST(PVR.prod_sid AS STRING)
   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), '-1') AS prod_orderable_lvl_cd_product,
 IFNULL(PA.content_classification_rating, '-1') AS content_classification_rating,
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
FROM ldl_dig_lec_share.v_fact_product_variant_availability AS PA
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_rel_product_variant_regional AS PVR ON PA.prod_variant_sid = PVR.prod_variant_sid
    AND PA.wshop_cd = PVR.wshop_cd;