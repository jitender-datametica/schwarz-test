CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_sales_promotion_plan_weekly_product_variant_1 AS SELECT PLAN.wshop_cd
 ,
 PLAN.prod_sid,
 PLAN.promo_id,
 PLAN.promo_dur_week_cnt,
 PLAN.promo_start_dt,
 PLAN.promo_sale_start_dt,
 PLAN.supplier_order_qty,
 PLAN.tgt_prod_sale_qty,
 PLAN.estimated_init_promo_stock,
 PLAN.current_promo_week_nr,
 PLAN.week_nr,
 PLAN.promo_sale_cluster_cd,
 PLAN.tgt_sale_pct,
 PLAN.cum_tgt_sale_pct,
 PLAN.sale_promo_phase_cd,
 STOCK.prod_variant_sid,
 STOCK.stock_distribution_pct,
 PLAN.is_current_fg,
  PLAN.plan_amc_qty * STOCK.stock_distribution_pct AS plan_amc_qty_variant,
  CASE
  WHEN PLAN.supplier_order_qty > PLAN.tgt_prod_sale_qty
  THEN PLAN.supplier_order_qty * STOCK.stock_distribution_pct
  ELSE PLAN.tgt_prod_sale_qty * STOCK.stock_distribution_pct
  END AS plan_amc_denominator_perc_variant,
  PLAN.plan_amc_qty_cum * STOCK.stock_distribution_pct AS plan_amc_qty_cum_variant,
  CASE
  WHEN PLAN.supplier_order_qty > PLAN.tgt_prod_sale_qty
  THEN PLAN.supplier_order_qty * STOCK.stock_distribution_pct
  ELSE PLAN.tgt_prod_sale_qty * STOCK.stock_distribution_pct
  END AS plan_amc_cum_denominator_perc_variant,
  PLAN.plan_ab_qty * STOCK.stock_distribution_pct AS plan_ab_qty_variant,
  CASE
  WHEN PLAN.estimated_init_promo_stock > PLAN.tgt_prod_sale_qty
  THEN PLAN.estimated_init_promo_stock * STOCK.stock_distribution_pct
  ELSE PLAN.tgt_prod_sale_qty * STOCK.stock_distribution_pct
  END AS plan_ab_denominator_perc_variant,
  PLAN.plan_ab_qty_cum * STOCK.stock_distribution_pct AS plan_ab_qty_cum_variant,
  CASE
  WHEN PLAN.estimated_init_promo_stock > PLAN.tgt_prod_sale_qty
  THEN PLAN.estimated_init_promo_stock * STOCK.stock_distribution_pct
  ELSE PLAN.tgt_prod_sale_qty * STOCK.stock_distribution_pct
  END AS plan_ab_cum_denominator_perc_variant,
  CASE
  WHEN PLAN.week_nr = (MAX(PLAN.week_nr) OVER (PARTITION BY PLAN.wshop_cd, CAST(STOCK.prod_variant_sid AS STRING), PLAN
       .promo_start_dt, CAST(PLAN.promo_sale_cluster_cd AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING))
  THEN 1
  ELSE 0
  END AS valid_week_nr_for_clusters
FROM ldl_dig_lec_share.v_agg_estimated_initial_promotion_stock_core_view_1 AS STOCK
 INNER JOIN ldl_dig_lec_share.v_agg_sales_promotion_plan_weekly_core_view_1 AS PLAN ON STOCK.promo_id = PLAN.promo_id;