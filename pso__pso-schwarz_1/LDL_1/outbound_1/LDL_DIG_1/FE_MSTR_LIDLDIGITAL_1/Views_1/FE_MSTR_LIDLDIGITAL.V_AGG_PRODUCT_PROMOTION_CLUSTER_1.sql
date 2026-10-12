CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_product_promotion_cluster_1 AS WITH PROMO_DUR_WEEK_FG AS (SELECT
   PVP.promo_id,
   PVP.prod_sid,
   PVP.is_after_cancellation_fg,
   PVP.curr_usage_type_cd,
   PVP.promo_sale_cluster_cd,
    DATE_ADD(PVP.first_week_start_dt, INTERVAL CAST(ROUND(par.days_since_promo_start_cnt) AS INTEGER) DAY) < DATE(CURRENT_TIMESTAMP()
     ) AS finished_prom_weeks_fg
  FROM ldl_dig_lec_share.v_agg_product_promotion_cluster_1 AS PVP
   LEFT JOIN (SELECT PARSE_DATE('%F', parameter_value_char) AS active_from,
     PARSE_DATE('%F', parameter_value_char) AS valid_from,
     LEAD(DATE_SUB(PARSE_DATE('%F', parameter_value_char), INTERVAL 1 DAY), 1, PARSE_DATE('%F', '9999-12-31')) OVER (PARTITION BY
        report ORDER BY PARSE_DATE('%F', parameter_value_char) IS NULL, PARSE_DATE('%F', parameter_value_char)) AS
     valid_to,
     parameter_value_numeric AS days_since_promo_start_cnt
    FROM ldl_dig_lec_share.v_meta_report_parameter_1 AS REP
    WHERE report = 'Artikelabverkauf') AS par ON PVP.first_week_start_dt BETWEEN par.valid_from AND par.valid_to) (SELECT
   IFNULL(PROMO.wshop_cd, '-1') AS wshop_cd,
   IFNULL(PROMO.promo_id, -1) AS promo_id,
   IFNULL(PROMO.prod_sid, -1) AS prod_sid,
   PROMO.promo_start_dt,
   PROMO.promo_sale_start_dt,
   PROMO.is_after_cancellation_fg,
   IFNULL(PROMO.curr_usage_type_cd, '-1') AS curr_usage_type_cd,
   PROMO.curr_cd,
   PROMO.prod_orderable_lvl_cd,
   PROMO.first_inbound_dt,
   PROMO.promo_sale_cluster_cd,
   PROMO.current_promo_sale_cluster_cd,
   PROMO.is_current_promo_sale_cluster_fg,
   PROMO.prod_qty,
   PROMO.cum_prod_qty,
   PROMO.return_prod_qty,
   PROMO.cum_return_prod_qty,
   PROMO.plan_amc_qty,
   PROMO.cum_plan_amc_qty,
   PROMO.plan_ab_qty,
   PROMO.cum_plan_ab_qty,
   PROMO.gross_margin_net_val,
   PROMO.cum_gross_margin_net_val,
   PROMO.prod_price_net_val,
   PROMO.cum_prod_price_net_val,
   PROMO.prod_price_gross_val,
   PROMO.cum_prod_price_gross_val,
   PROMO.sale_promo_type_cd,
   PROMO.is_first_promotion_fg,
   PROMO.is_repeated_fg,
   PROMO.promo_dur_week_cnt,
   PROMO.first_delivery_cy_week,
   PROMO.finished_3_prom_weeks_fg,
   pdur.finished_prom_weeks_fg
  FROM ldl_dig_lec_share.v_agg_product_promotion_cluster_1 AS PROMO
   LEFT JOIN PROMO_DUR_WEEK_FG AS pdur ON PROMO.promo_id = pdur.promo_id AND PROMO.prod_sid = pdur.prod_sid AND PROMO.is_after_cancellation_fg
        = pdur.is_after_cancellation_fg AND PROMO.curr_usage_type_cd = pdur.curr_usage_type_cd AND PROMO.promo_sale_cluster_cd
      = pdur.promo_sale_cluster_cd);