CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_product_variant_promotion_1 AS WITH PROMO_DUR_WEEK_FG AS (SELECT
   PVP0.promo_id,
   PVP0.prod_variant_sid,
   PVP0.is_after_cancellation_fg,
   PVP0.curr_usage_type_cd,
    DATE_ADD(PVP0.first_week_start_dt, INTERVAL CAST(ROUND(par.days_since_promo_start_cnt) AS INTEGER) DAY) < DATE(CURRENT_TIMESTAMP()
     ) AS finished_prom_weeks_fg
  FROM ldl_dig_lec_share.v_agg_product_variant_promotion_1 AS PVP0
   LEFT JOIN (SELECT PARSE_DATE('%F', parameter_value_char) AS active_from,
     PARSE_DATE('%F', parameter_value_char) AS valid_from,
     LEAD(DATE_SUB(PARSE_DATE('%F', parameter_value_char), INTERVAL 1 DAY), 1, PARSE_DATE('%F', '9999-12-31')) OVER (PARTITION BY
        report ORDER BY PARSE_DATE('%F', parameter_value_char) IS NULL, PARSE_DATE('%F', parameter_value_char)) AS
     valid_to,
     parameter_value_numeric AS days_since_promo_start_cnt
    FROM ldl_dig_lec_share.v_meta_report_parameter_1 AS REP
    WHERE report = 'Artikelabverkauf') AS par ON PVP0.first_week_start_dt BETWEEN par.valid_from AND par.valid_to) (SELECT
   IFNULL(PVP.wshop_cd, '-1') AS wshop_cd,
   IFNULL(PVP.promo_id, -1) AS promo_id,
   IFNULL(PVP.prod_variant_sid, -1) AS prod_variant_sid,
   PVP.is_after_cancellation_fg,
   PVP.promo_sale_start_dt,
   PVP.promo_start_dt,
   PVP.curr_cd,
   IFNULL(PVP.curr_usage_type_cd, '-1') AS curr_usage_type_cd,
   PVP.is_first_promotion_fg,
   PVP.is_repeated_fg,
   PVP.sale_promo_type_cd,
   PVP.prod_orderable_lvl_cd,
   PVP.first_delivery_cy_week,
     LEFT(SUBSTR(CAST(PVP.first_delivery_cy_week AS STRING), 1, 39), 4) || ' KW ' || RIGHT(SUBSTR(CAST(PVP.first_delivery_cy_week AS STRING)
      , 1, 39), 2) AS first_delivery_cy_week_name,
   PVP.promo_dur_week_cnt,
   PVP.first_inbound_dt,
   PVP.finished_3_prom_weeks_fg,
   pdur.finished_prom_weeks_fg,
   PVP.passed_sale_weeks_cnt,
   PVP.prod_qty,
   PVP.return_prod_qty,
   PVP.tgt_prod_sale_qty,
   PVP.plan_ab_qty,
   PVP.plan_amc_qty,
   PVP.delta_plan_ab_qty,
   PVP.delta_plan_amc_qty AS delta_plan_amc_total_qty,
   PVP.total_plan_ab_qty,
   PVP.total_plan_amc_qty,
   PVP.alloc_stock_cnt,
   PVP.avail_to_promise_cnt,
   PVP.avail_to_sell_cnt,
   PVP.blocked_stock_cnt,
   PVP.total_stock_cnt,
   PVP.receive_on_dock_cnt,
   PVP.wshop_total_stock_cnt,
   PVP.days_not_orderable_in_promotion_cnt,
   PVP.orderable_in_promotion_start_dt,
   PVP.supplier_order_qty,
   PVP.est_init_promo_stock_cnt,
   PVP.promo_sale_price_gross_val,
   PVP.promo_purch_price_net_val,
   PVP.gross_margin_net_val,
   PVP.prod_price_gross_val,
   PVP.prod_price_net_val,
    PVP.promo_purch_price_net_val * PVP.wshop_total_stock_cnt AS wshop_total_stock_at_purch_price_net_val,
    PVP.promo_sale_price_gross_val * PVP.wshop_total_stock_cnt AS wshop_total_stock_at_sale_price_gross_val,
    PVP.promo_sale_price_gross_val * PVP.est_init_promo_stock_cnt AS est_init_promo_stock_at_sale_price_gross_val,
    PVP.avail_to_sell_cnt + PVP.receive_on_dock_cnt AS venlo_stock_cnt,
   PVP.special_analysis_prod_qty,
   PVP.special_analysis_prod_price_net_val,
   PVP.special_analysis_gross_margin_net_val,
    IF(PVP.special_analysis_prod_qty = 0, 0, SAFE_DIVIDE(PVP.special_analysis_prod_price_net_val, PVP.special_analysis_prod_qty
      )) * PVP.supplier_order_qty AS supplier_order_qty_at_avg_special_analysis_sale_price_net_val,
    IF(PVP.special_analysis_prod_qty = 0, 0, SAFE_DIVIDE(PVP.special_analysis_prod_price_net_val, PVP.special_analysis_prod_qty
      )) * PVP.est_init_promo_stock_cnt AS est_init_promo_stock_at_avg_special_analysis_sale_price_net_val,
    IF(PVP.special_analysis_prod_qty = 0, 0, SAFE_DIVIDE(PVP.special_analysis_prod_price_net_val, PVP.special_analysis_prod_qty
      )) * PVP.wshop_total_stock_cnt AS wshop_total_stock_at_avg_special_analysis_sale_price_net_val
  FROM ldl_dig_lec_share.v_agg_product_variant_promotion_1 AS PVP
   LEFT JOIN PROMO_DUR_WEEK_FG AS pdur ON PVP.promo_id = pdur.promo_id AND PVP.prod_variant_sid = pdur.prod_variant_sid
     AND PVP.is_after_cancellation_fg = pdur.is_after_cancellation_fg AND PVP.curr_usage_type_cd = pdur.curr_usage_type_cd
     );