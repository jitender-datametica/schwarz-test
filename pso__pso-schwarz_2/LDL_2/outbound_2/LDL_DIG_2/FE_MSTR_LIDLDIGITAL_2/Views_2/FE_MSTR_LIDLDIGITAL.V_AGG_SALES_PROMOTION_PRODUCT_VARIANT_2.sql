CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_sales_promotion_product_variant_2 AS SELECT CASE
  WHEN B.wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(B.wshop_cd, '-1')
  END AS wshop_cd,
 IFNULL(B.prod_sid, - 1) AS prod_sid,
 A.promo_start_dt,
 CAST(FLOOR(DATE_DIFF(CURRENT_DATE, A.promo_start_dt, DAY) / 7) AS INTEGER) AS passed_sale_weeks,
 B.promo_sale_start_dt,
  CASE
  WHEN A.sale_promo_type_cd = ''
  THEN '-1'
  ELSE IFNULL(A.sale_promo_type_cd, '-1')
  END AS sale_promo_type_cd,
 A.is_repeated_fg,
 A.promo_dur_week_cnt,
 A.first_week_start_dt,
 A.analysis_start_dt,
 A.analysis_end_dt,
  CASE
  WHEN A.sale_promo_status_cd = ''
  THEN '-1'
  ELSE IFNULL(A.sale_promo_status_cd, '-1')
  END AS sale_promo_status_cd,
 B.promo_id,
 A.tgt_prod_receive_cy_week,
 A.first_delivery_cy_week,
 A.supplier_order_qty,
 A.tgt_prod_sale_qty,
 A.promo_nr,
 A.promo_descr,
 A.amc_ian_nr,
 A.is_tv_promo_fg,
 A.return_cond_descr,
 A.is_catalog_promo_fg,
 IFNULL(B.prod_variant_sid, - 1) AS prod_variant_sid,
  A.tgt_prod_sale_qty * B.stock_distribution_pct AS tgt_prod_sale_qty_variant,
  A.supplier_order_qty * B.stock_distribution_pct AS supplier_order_qty_variant,
 IFNULL(B.stock_distribution_pct, 0) AS stock_distribution_pct
FROM ldl_dig_lec_share.v_agg_sales_promotion_core_view_2 AS A
 INNER JOIN ldl_dig_lec_share.v_agg_estimated_initial_promotion_stock_core_view_2 AS B ON A.prod_sid = B.prod_sid AND A.promo_sale_start_dt
      = B.promo_sale_start_dt AND A.wshop_cd = B.wshop_cd AND A.promo_id = B.promo_id;