CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_sales_promotion_plan_weekly_2 AS SELECT CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
 IFNULL(prod_sid, -1) AS prod_sid,
 IFNULL(promo_id, -1) AS promo_id,
 promo_dur_week_cnt,
 promo_start_dt,
 promo_sale_start_dt,
 supplier_order_qty,
 tgt_prod_sale_qty,
 estimated_init_promo_stock,
 current_promo_week_nr,
 week_nr,
 IFNULL(promo_sale_cluster_cd, -1) AS promo_sale_cluster_cd,
 tgt_sale_pct,
 cum_tgt_sale_pct,
  CASE
  WHEN sale_promo_phase_cd = ''
  THEN '-1'
  ELSE IFNULL(sale_promo_phase_cd, '-1')
  END AS sale_promo_phase_cd,
 plan_amc_qty,
 plan_amc_perc,
  CASE
  WHEN supplier_order_qty > tgt_prod_sale_qty
  THEN supplier_order_qty
  ELSE tgt_prod_sale_qty
  END AS plan_amc_denominator_perc,
 plan_amc_qty_cum,
 plan_amc_cum_perc,
  CASE
  WHEN supplier_order_qty > tgt_prod_sale_qty
  THEN supplier_order_qty
  ELSE tgt_prod_sale_qty
  END AS plan_amc_cum_denominator_perc,
 plan_ab_qty,
 plan_ab_perc,
  CASE
  WHEN estimated_init_promo_stock > tgt_prod_sale_qty
  THEN estimated_init_promo_stock
  ELSE tgt_prod_sale_qty
  END AS plan_ab_denominator_perc,
 plan_ab_qty_cum,
 plan_ab_cum_perc,
  CASE
  WHEN estimated_init_promo_stock > tgt_prod_sale_qty
  THEN estimated_init_promo_stock
  ELSE tgt_prod_sale_qty
  END AS plan_ab_cum_denominator_perc
FROM ldl_dig_lec_share.v_agg_sales_promotion_plan_weekly_core_view_2;