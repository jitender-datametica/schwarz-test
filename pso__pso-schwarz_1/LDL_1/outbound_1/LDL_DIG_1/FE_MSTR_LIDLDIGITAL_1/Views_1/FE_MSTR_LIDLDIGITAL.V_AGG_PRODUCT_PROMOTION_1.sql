CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_product_promotion_1 AS WITH PROMO_DUR_WEEK_FG AS (SELECT PROMO0.promo_id
   ,
   PROMO0.prod_sid,
   PROMO0.is_after_cancellation_fg,
   PROMO0.curr_usage_type_cd,
    DATE_ADD(PROMO0.first_week_start_dt, INTERVAL CAST(ROUND(par.days_since_promo_start_cnt) AS INTEGER) DAY) < DATE(CURRENT_TIMESTAMP()
     ) AS finished_prom_weeks_fg
  FROM ldl_dig_lec_share.v_agg_product_promotion_1 AS PROMO0
   LEFT JOIN (SELECT PARSE_DATE('%F', parameter_value_char) AS active_from,
     PARSE_DATE('%F', parameter_value_char) AS valid_from,
     LEAD(DATE_SUB(PARSE_DATE('%F', parameter_value_char), INTERVAL 1 DAY), 1, PARSE_DATE('%F', '9999-12-31')) OVER (PARTITION BY
        report ORDER BY PARSE_DATE('%F', parameter_value_char) IS NULL, PARSE_DATE('%F', parameter_value_char)) AS
     valid_to,
     parameter_value_numeric AS days_since_promo_start_cnt
    FROM ldl_dig_lec_share.v_meta_report_parameter_1 AS REP
    WHERE report = 'Artikelabverkauf') AS par ON PROMO0.first_week_start_dt BETWEEN par.valid_from AND par.valid_to) (SELECT
   IFNULL(PROMO.wshop_cd, '-1') AS wshop_cd,
   IFNULL(PROMO.promo_id, -1) AS promo_id,
   PROMO.promo_sale_start_dt,
   PROMO.promo_start_dt,
   IFNULL(PROMO.prod_sid, -1) AS prod_sid,
   PROMO.amc_ian_nr,
   PROMO.is_after_cancellation_fg,
   IFNULL(PROMO.curr_usage_type_cd, '-1') AS curr_usage_type_cd,
   PROMO.curr_cd,
   PROMO.is_first_promotion_fg,
   PROMO.is_repeated_fg,
   PROMO.sale_promo_type_cd,
   PROMO.prod_orderable_lvl_cd,
   PROMO.first_delivery_cy_week,
     LEFT(SUBSTR(CAST(PROMO.first_delivery_cy_week AS STRING), 1, 39), 4) || ' KW ' || RIGHT(SUBSTR(CAST(PROMO.first_delivery_cy_week AS STRING)
      , 1, 39), 2) AS first_delivery_cy_week_name,
   PROMO.promo_dur_week_cnt,
   PROMO.first_inbound_dt,
   PROMO.finished_3_prom_weeks_fg,
   pdur.finished_prom_weeks_fg,
   PROMO.passed_sale_weeks_cnt,
   PROMO.prod_qty,
   PROMO.return_prod_qty,
   PROMO.tgt_prod_sale_qty,
   PROMO.plan_ab_qty,
   PROMO.plan_amc_qty,
   PROMO.delta_plan_ab_qty,
   PROMO.delta_plan_amc_qty,
   PROMO.total_plan_ab_qty,
   PROMO.total_plan_amc_qty,
   PROMO.alloc_stock_cnt,
   PROMO.avail_to_promise_cnt,
   PROMO.avail_to_sell_cnt,
   PROMO.blocked_stock_cnt,
   PROMO.total_stock_cnt,
   PROMO.receive_on_dock_cnt,
   PROMO.wshop_total_stock_cnt,
   PROMO.wshop_prod_promos_cnt,
   PROMO.days_not_orderable_in_promotion_cnt,
   PROMO.orderable_in_promotion_start_dt,
   PROMO.orderable_prod_variants_cnt,
   PROMO.supplier_order_qty,
   PROMO.est_init_promo_stock_cnt,
   PROMO.promo_sale_price_gross_val,
   PROMO.promo_purch_price_net_val,
   PROMO.gross_margin_net_val,
   PROMO.prod_price_gross_val,
   PROMO.prod_price_net_val,
   PROMO.active_prod_variants_cnt,
    IF(PROMO.prod_qty = 0, 0, SAFE_DIVIDE(PROMO.prod_price_net_val, PROMO.prod_qty)) * PROMO.est_init_promo_stock_cnt AS
   est_init_promo_stock_at_avg_sale_price_net_val,
    IF(PROMO.prod_qty = 0, 0, SAFE_DIVIDE(PROMO.prod_price_net_val, PROMO.prod_qty)) * PROMO.supplier_order_qty AS
   supplier_order_qty_at_avg_sale_price_net_val,
    IF(PROMO.prod_qty = 0, 0, SAFE_DIVIDE(PROMO.prod_price_net_val, PROMO.prod_qty)) * PROMO.wshop_total_stock_cnt AS
   wshop_total_stock_at_avg_sale_price_net_val,
    PROMO.promo_sale_price_gross_val * PROMO.tgt_prod_sale_qty AS tgt_prod_sale_qty_at_sale_price_gross_val,
    PROMO.promo_purch_price_net_val * PROMO.wshop_total_stock_cnt AS wshop_total_stock_at_purch_price_net_val,
    PROMO.promo_sale_price_gross_val * PROMO.wshop_total_stock_cnt AS wshop_total_stock_at_sale_price_gross_val,
    PROMO.promo_sale_price_gross_val * PROMO.est_init_promo_stock_cnt AS est_init_promo_stock_at_sale_price_gross_val,
    PROMO.avail_to_sell_cnt + PROMO.receive_on_dock_cnt AS venlo_stock_cnt,
   PROMO.special_analysis_prod_qty,
   PROMO.special_analysis_prod_price_net_val,
   PROMO.special_analysis_gross_margin_net_val,
    IF(PROMO.special_analysis_prod_qty = 0, 0, SAFE_DIVIDE(PROMO.special_analysis_prod_price_net_val, PROMO.special_analysis_prod_qty
      )) * PROMO.supplier_order_qty AS supplier_order_qty_at_avg_special_analysis_sale_price_net_val,
    IF(PROMO.special_analysis_prod_qty = 0, 0, SAFE_DIVIDE(PROMO.special_analysis_prod_price_net_val, PROMO.special_analysis_prod_qty
      )) * PROMO.est_init_promo_stock_cnt AS est_init_promo_stock_at_avg_special_analysis_sale_price_net_val,
    IF(PROMO.special_analysis_prod_qty = 0, 0, SAFE_DIVIDE(PROMO.special_analysis_prod_price_net_val, PROMO.special_analysis_prod_qty
      )) * PROMO.wshop_total_stock_cnt AS wshop_total_stock_at_avg_special_analysis_sale_price_net_val
  FROM ldl_dig_lec_share.v_agg_product_promotion_1 AS PROMO
   LEFT JOIN PROMO_DUR_WEEK_FG AS pdur ON PROMO.promo_id = pdur.promo_id AND PROMO.prod_sid = pdur.prod_sid AND PROMO.is_after_cancellation_fg
       = pdur.is_after_cancellation_fg AND PROMO.curr_usage_type_cd = pdur.curr_usage_type_cd);