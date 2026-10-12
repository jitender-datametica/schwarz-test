CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_monitoring_season_products_2 AS WITH STOCK AS (SELECT PROD.prod_sid
   ,
   PROD.prod_nr,
   MAX(PROD.prod_name) AS prod_name,
   SWD.wh_sid,
   SWD.wh_cd,
   MIN(PROD_UT_DT.correct_utilisation) AS correct_utilisation,
   MIN(PROD_UT.util_action_cd) AS util_action_cd,
   SUM(SWD.total_stock_cnt) AS total_stock_cnt,
   SUM(SWD.total_stock_cnt * FACT_PPS.price_val) AS total_stock_val,
   SUM(SWD.blocked_stock_cnt) AS blocked_stock_cnt,
   SUM(SWD.blocked_stock_cnt * FACT_PPS.price_val) AS blocked_stock_val,
   SUM(SWD.unrestricted_stock_cnt) AS unrestricted_stock_cnt,
   SUM(SWD.unrestricted_stock_cnt * FACT_PPS.price_val) AS unrestricted_stock_val
  FROM ldl_dig_lec_share.v_fact_stock_warehouse_daily_2 AS SWD
   LEFT JOIN ldl_dig_lec_share.v_dim_product_variant_2 AS PROD_VAR ON SWD.prod_variant_sid = PROD_VAR.prod_variant_sid AND
     PROD_VAR.dwh_valid_fg AND SWD.active_fg
   INNER JOIN (SELECT TEMP_SWD.active_fg,
     TEMP_PROD_VAR.prod_sid,
     TEMP_SWD.wh_sid
    FROM ldl_dig_lec_share.v_fact_stock_warehouse_daily_2 AS TEMP_SWD
     LEFT JOIN ldl_dig_lec_share.v_dim_product_variant_2 AS TEMP_PROD_VAR ON TEMP_SWD.prod_variant_sid = TEMP_PROD_VAR.prod_variant_sid
      
    WHERE TEMP_PROD_VAR.dwh_valid_fg
     AND TEMP_SWD.active_fg
    GROUP BY TEMP_SWD.wh_sid,
     TEMP_SWD.active_fg,
     TEMP_PROD_VAR.prod_sid
    HAVING SUM(TEMP_SWD.total_stock_cnt) <> 0.0) AS FILTER ON SWD.wh_sid = FILTER.wh_sid AND PROD_VAR.prod_sid = FILTER
     .prod_sid
   LEFT JOIN ldl_dig_lec_share.v_dim_product_2 AS PROD ON PROD_VAR.prod_sid = PROD.prod_sid AND PROD.dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_dim_product_utilisation_date_core_view_2 AS PROD_UT_DT ON PROD_VAR.prod_sid = PROD_UT_DT
    .prod_sid
   LEFT JOIN ldl_dig_lec_share.v_fact_product_utilisation_2 AS PROD_UT ON PROD_VAR.prod_sid = PROD_UT.prod_sid AND PROD_UT
    .dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_fact_product_price_supplier_2 AS FACT_PPS ON PROD_VAR.main_supplier_sid = FACT_PPS.supplier_sid
          AND PROD_VAR.prod_variant_sid = FACT_PPS.prod_variant_sid AND SWD.cal_dt BETWEEN CAST(FACT_PPS.active_from_tmsp AS DATE)
        AND (CAST(FACT_PPS.active_to_tmsp AS DATE)) AND FACT_PPS.wshop_cd = 'DE' AND FACT_PPS.price_type_cd = 'EKP' AND
     FACT_PPS.curr_cd = 'EUR'
  WHERE SWD.active_fg
  GROUP BY PROD.prod_sid,
   PROD.prod_nr,
   SWD.wh_sid,
   SWD.wh_cd), SALES_2 AS (SELECT PROD_REG.prod_sid,
   CUST_ORD.wh_sid,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1) AND CUST_ORD.wshop_cd = 'BE'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS be_prod_qty_last_week,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 14 AND (- 1) AND CUST_ORD.wshop_cd = 'BE'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS be_prod_qty_last_2_weeks,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1) AND CUST_ORD.wshop_cd = 'BE'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS be_prod_qty_last_6_weeks,
   MAX(CASE
     WHEN CUST_ORD.wshop_cd = 'BE'
     THEN CAL_D.cal_dt
     ELSE NULL
     END) AS be_last_sales_date,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1) AND CUST_ORD.wshop_cd = 'CZ'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS cz_prod_qty_last_week,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 14 AND (- 1) AND CUST_ORD.wshop_cd = 'CZ'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS cz_prod_qty_last_2_weeks,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1) AND CUST_ORD.wshop_cd = 'CZ'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS cz_prod_qty_last_6_weeks,
   MAX(CASE
     WHEN CUST_ORD.wshop_cd = 'CZ'
     THEN CAL_D.cal_dt
     ELSE NULL
     END) AS cz_last_sales_date,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1) AND CUST_ORD.wshop_cd = 'DE'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS de_prod_qty_last_week,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 14 AND (- 1) AND CUST_ORD.wshop_cd = 'DE'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS de_prod_qty_last_2_weeks,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1) AND CUST_ORD.wshop_cd = 'DE'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS de_prod_qty_last_6_weeks,
   MAX(CASE
     WHEN CUST_ORD.wshop_cd = 'DE'
     THEN CAL_D.cal_dt
     ELSE NULL
     END) AS de_last_sales_date,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1) AND CUST_ORD.wshop_cd = 'FR'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS fr_prod_qty_last_week,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 14 AND (- 1) AND CUST_ORD.wshop_cd = 'FR'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS fr_prod_qty_last_2_weeks,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1) AND CUST_ORD.wshop_cd = 'FR'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS fr_prod_qty_last_6_weeks,
   MAX(CASE
     WHEN CUST_ORD.wshop_cd = 'FR'
     THEN CAL_D.cal_dt
     ELSE NULL
     END) AS fr_last_sales_date,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1) AND CUST_ORD.wshop_cd = 'NL'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS nl_prod_qty_last_week,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 14 AND (- 1) AND CUST_ORD.wshop_cd = 'NL'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS nl_prod_qty_last_2_weeks,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1) AND CUST_ORD.wshop_cd = 'NL'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS nl_prod_qty_last_6_weeks,
   MAX(CASE
     WHEN CUST_ORD.wshop_cd = 'NL'
     THEN CAL_D.cal_dt
     ELSE NULL
     END) AS nl_last_sales_date,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1) AND CUST_ORD.wshop_cd = 'PL'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS pl_prod_qty_last_week,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 14 AND (- 1) AND CUST_ORD.wshop_cd = 'PL'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS pl_prod_qty_last_2_weeks,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1) AND CUST_ORD.wshop_cd = 'PL'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS pl_prod_qty_last_6_weeks,
   MAX(CASE
     WHEN CUST_ORD.wshop_cd = 'PL'
     THEN CAL_D.cal_dt
     ELSE NULL
     END) AS pl_last_sales_date,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1) AND CUST_ORD.wshop_cd = 'SK'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS sk_prod_qty_last_week,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 14 AND (- 1) AND CUST_ORD.wshop_cd = 'SK'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS sk_prod_qty_last_2_weeks,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1) AND CUST_ORD.wshop_cd = 'SK'
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS sk_prod_qty_last_6_weeks,
   MAX(CASE
     WHEN CUST_ORD.wshop_cd = 'SK'
     THEN CAL_D.cal_dt
     ELSE NULL
     END) AS sk_last_sales_date,
   SUM(CASE
     WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1)
     THEN CUST_ORD.prod_qty
     ELSE NULL
     END) AS prod_qty_last_week,
    CASE
    WHEN SUM(CASE
       WHEN CAL_D.cal_dt_offset BETWEEN - 7 AND (- 1)
       THEN CUST_ORD.prod_qty
       ELSE NULL
       END) <= 7
    THEN 1
    ELSE 0
    END AS prod_qty_last_week_less_7_fg,
   MAX(CAL_D.cal_dt) AS last_sales_date
  FROM ldl_dig_lec_share.v_fact_customer_order_line_2 AS CUST_ORD
   LEFT JOIN ldl_dig_lec_share.v_rel_product_variant_regional_2 AS PROD_VAR_REG ON CUST_ORD.prod_variant_sid =
      PROD_VAR_REG.prod_variant_sid AND CUST_ORD.wshop_cd = PROD_VAR_REG.wshop_cd AND PROD_VAR_REG.dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_rel_product_regional_2 AS PROD_REG ON PROD_VAR_REG.prod_sid = PROD_REG.prod_sid AND
      PROD_VAR_REG.wshop_cd = PROD_REG.wshop_cd AND PROD_REG.dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_dim_cal_day_2 AS CAL_D ON CUST_ORD.cust_order_dt = CAL_D.cal_dt
  WHERE CAL_D.cal_dt_offset BETWEEN - 42 AND (- 1)
   AND CASE
     WHEN CUST_ORD.is_order_cancel_fg IS NOT NULL
     THEN CASE
      WHEN CUST_ORD.is_order_cancel_fg
      THEN 1
      ELSE 0
      END
     ELSE NULL
     END IN (0)
   AND CUST_ORD.is_part_of_bundle_header_cnt_fg
  GROUP BY PROD_REG.prod_sid,
   CUST_ORD.wh_sid), PRODUCT AS (SELECT PROD0.prod_sid,
   ROUND(CAST(MIN(CASE
       WHEN PROD_REG0.wshop_cd = 'BE'
       THEN CASE
        WHEN TRIM(PROD_VAR_REG0.prod_online_status_cd) = ''
        THEN '-1'
        ELSE IFNULL(PROD_VAR_REG0.prod_online_status_cd, '-1')
        END
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS be_prod_online_status_cd,
   ROUND(CAST(MIN(CASE
       WHEN PROD_REG0.wshop_cd = 'CZ'
       THEN CASE
        WHEN TRIM(PROD_VAR_REG0.prod_online_status_cd) = ''
        THEN '-1'
        ELSE IFNULL(PROD_VAR_REG0.prod_online_status_cd, '-1')
        END
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS cz_prod_online_status_cd,
   ROUND(CAST(MIN(CASE
       WHEN PROD_REG0.wshop_cd = 'DE'
       THEN CASE
        WHEN TRIM(PROD_VAR_REG0.prod_online_status_cd) = ''
        THEN '-1'
        ELSE IFNULL(PROD_VAR_REG0.prod_online_status_cd, '-1')
        END
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS de_prod_online_status_cd,
   ROUND(CAST(MIN(CASE
       WHEN PROD_REG0.wshop_cd = 'FR'
       THEN CASE
        WHEN TRIM(PROD_VAR_REG0.prod_online_status_cd) = ''
        THEN '-1'
        ELSE IFNULL(PROD_VAR_REG0.prod_online_status_cd, '-1')
        END
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS fr_prod_online_status_cd,
   ROUND(CAST(MIN(CASE
       WHEN PROD_REG0.wshop_cd = 'NL'
       THEN CASE
        WHEN TRIM(PROD_VAR_REG0.prod_online_status_cd) = ''
        THEN '-1'
        ELSE IFNULL(PROD_VAR_REG0.prod_online_status_cd, '-1')
        END
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS nl_prod_online_status_cd,
   ROUND(CAST(MIN(CASE
       WHEN PROD_REG0.wshop_cd = 'PL'
       THEN CASE
        WHEN TRIM(PROD_VAR_REG0.prod_online_status_cd) = ''
        THEN '-1'
        ELSE IFNULL(PROD_VAR_REG0.prod_online_status_cd, '-1')
        END
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS pl_prod_online_status_cd,
   ROUND(CAST(MIN(CASE
       WHEN PROD_REG0.wshop_cd = 'SK'
       THEN CASE
        WHEN TRIM(PROD_VAR_REG0.prod_online_status_cd) = ''
        THEN '-1'
        ELSE IFNULL(PROD_VAR_REG0.prod_online_status_cd, '-1')
        END
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS sk_prod_online_status_cd,
   MAX(PROD_VAR0.palette_capacity_cnt) AS palette_capacity_cnt,
   MAX(PROD_MNGR.prod_manager_name) AS prod_manager_name
  FROM ldl_dig_lec_share.v_dim_product_2 AS PROD0
   LEFT JOIN ldl_dig_lec_share.v_rel_product_regional_2 AS PROD_REG0 ON PROD0.prod_sid = PROD_REG0.prod_sid AND PROD_REG0
    .dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_rel_product_variant_regional_2 AS PROD_VAR_REG0 ON PROD0.prod_sid = PROD_VAR_REG0.prod_sid
       AND PROD_REG0.wshop_cd = PROD_VAR_REG0.wshop_cd AND PROD_VAR_REG0.dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_dim_product_variant_2 AS PROD_VAR0 ON PROD_VAR_REG0.prod_variant_sid = PROD_VAR0.prod_variant_sid
      AND PROD_VAR0.dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_dim_product_manager_2 AS PROD_MNGR ON PROD0.prod_manager_cd = PROD_MNGR.prod_manager_cd
  WHERE PROD0.dwh_valid_fg
  GROUP BY PROD0.prod_sid), AMC AS (WITH PROMO_START AS (SELECT prod_sid,
      wshop_cd,
      MIN(CASE
        WHEN wshop_cd = 'BE' AND DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS be_next_promotion_start_date,
      MIN(CASE
        WHEN wshop_cd = 'CZ' AND DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS cz_next_promotion_start_date,
      MIN(CASE
        WHEN wshop_cd = 'DE' AND DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS de_next_promotion_start_date,
      MIN(CASE
        WHEN wshop_cd = 'FR' AND DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS fr_next_promotion_start_date,
      MIN(CASE
        WHEN wshop_cd = 'NL' AND DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS nl_next_promotion_start_date,
      MIN(CASE
        WHEN wshop_cd = 'PL' AND DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS pl_next_promotion_start_date,
      MIN(CASE
        WHEN wshop_cd = 'SK' AND DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS sk_next_promotion_start_date,
      MIN(CASE
        WHEN DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) > 0
        THEN promo_start_dt
        ELSE NULL
        END) AS next_promotion_start_date,
      MIN(CASE
        WHEN DATE_DIFF(promo_start_dt, CURRENT_DATE, DAY) BETWEEN 0 AND 28
        THEN 0
        ELSE 1
        END) AS next_promotion_start_date_outside_next_4_weeks_fg,
      MAX(promo_season_cd) AS promo_season_cd
     FROM ldl_dig_lec_share.v_dim_sales_promotion_2
     WHERE dwh_valid_fg
     GROUP BY prod_sid,
      wshop_cd), DELIVERY AS (SELECT SALES_PROMO.prod_sid,
      MIN(CASE
        WHEN CAL_WEEK.cy_week_offset > 0
        THEN SALES_PROMO.first_delivery_cy_week
        ELSE NULL
        END) AS next_delivery_cy_week,
      MIN(CASE
        WHEN CAL_WEEK.cy_week_offset > 0
        THEN CAL_WEEK.cy_week_offset
        ELSE NULL
        END) AS next_delivery_cy_week_offset,
       CASE
       WHEN MIN(CASE
         WHEN CAL_WEEK.cy_week_offset > 0
         THEN SALES_PROMO.first_delivery_cy_week
         ELSE NULL
         END) IS NULL
       THEN 1
       ELSE 0
       END AS no_upcoming_delivery_fg,
      MAX(CASE
        WHEN CAL_WEEK.cy_week_offset < 0
        THEN SALES_PROMO.first_delivery_cy_week
        ELSE NULL
        END) AS last_delivery_cy_week,
      MAX(CASE
        WHEN CAL_WEEK.cy_week_offset < 0
        THEN CAL_WEEK.cy_week_offset
        ELSE NULL
        END) AS last_delivery_cy_week_offset,
       CASE
       WHEN MAX(CASE
          WHEN CAL_WEEK.cy_week_offset < 0
          THEN CAL_WEEK.cy_week_offset
          ELSE NULL
          END) < - 8
       THEN 1
       ELSE 0
       END AS last_delivery_more_than_8_weeks_ago_fg
     FROM ldl_dig_lec_share.v_dim_sales_promotion_2 AS SALES_PROMO
      LEFT JOIN ldl_dig_lec_share.v_dim_cal_week_2 AS CAL_WEEK ON SALES_PROMO.first_delivery_cy_week = CAL_WEEK.cy_week
     WHERE SALES_PROMO.dwh_valid_fg
     GROUP BY SALES_PROMO.prod_sid) (SELECT t23.prod_sid,
      MIN(t23.be_next_promotion_start_date) AS be_next_promotion_start_date,
      MIN(t23.cz_next_promotion_start_date) AS cz_next_promotion_start_date,
      MIN(t23.de_next_promotion_start_date) AS de_next_promotion_start_date,
      MIN(t23.fr_next_promotion_start_date) AS fr_next_promotion_start_date,
      MIN(t23.nl_next_promotion_start_date) AS nl_next_promotion_start_date,
      MIN(t23.pl_next_promotion_start_date) AS pl_next_promotion_start_date,
      MIN(t23.sk_next_promotion_start_date) AS sk_next_promotion_start_date,
      MIN(t23.next_promotion_start_date) AS next_promotion_start_date,
      MIN(t23.next_promotion_start_date_outside_next_4_weeks_fg) AS next_promotion_start_date_outside_next_4_weeks_fg,
      SUM(CASE
        WHEN t23.wshop_cd = 'BE'
        THEN SALES_PROMO0.tgt_prod_sale_qty
        ELSE NULL
        END) AS be_tgt_prod_sale_qty,
      SUM(CASE
        WHEN t23.wshop_cd = 'CZ'
        THEN SALES_PROMO0.tgt_prod_sale_qty
        ELSE NULL
        END) AS cz_tgt_prod_sale_qty,
      SUM(CASE
        WHEN t23.wshop_cd = 'DE'
        THEN SALES_PROMO0.tgt_prod_sale_qty
        ELSE NULL
        END) AS de_tgt_prod_sale_qty,
      SUM(CASE
        WHEN t23.wshop_cd = 'FR'
        THEN SALES_PROMO0.tgt_prod_sale_qty
        ELSE NULL
        END) AS fr_tgt_prod_sale_qty,
      SUM(CASE
        WHEN t23.wshop_cd = 'NL'
        THEN SALES_PROMO0.tgt_prod_sale_qty
        ELSE NULL
        END) AS nl_tgt_prod_sale_qty,
      SUM(CASE
        WHEN t23.wshop_cd = 'PL'
        THEN SALES_PROMO0.tgt_prod_sale_qty
        ELSE NULL
        END) AS pl_tgt_prod_sale_qty,
      SUM(CASE
        WHEN t23.wshop_cd = 'SK'
        THEN SALES_PROMO0.tgt_prod_sale_qty
        ELSE NULL
        END) AS sk_tgt_prod_sale_qty,
      MAX(t23.promo_season_cd) AS promo_season_cd,
      MAX(t28.next_delivery_cy_week) AS next_delivery_cy_week,
      MAX(t28.no_upcoming_delivery_fg) AS no_upcoming_delivery_fg,
      MAX(t28.last_delivery_cy_week) AS last_delivery_cy_week,
      MAX(t28.last_delivery_more_than_8_weeks_ago_fg) AS last_delivery_more_than_8_weeks_ago_fg
     FROM PROMO_START AS t23
      LEFT JOIN DELIVERY AS t28 ON t23.prod_sid = t28.prod_sid
      LEFT JOIN ldl_dig_lec_share.v_dim_sales_promotion_2 AS SALES_PROMO0 ON t23.prod_sid = SALES_PROMO0.prod_sid AND t23
          .wshop_cd = SALES_PROMO0.wshop_cd AND (t23.be_next_promotion_start_date = SALES_PROMO0.promo_start_dt OR t23.cz_next_promotion_start_date
                 = SALES_PROMO0.promo_start_dt OR t23.de_next_promotion_start_date = SALES_PROMO0.promo_start_dt OR t23
              .fr_next_promotion_start_date = SALES_PROMO0.promo_start_dt OR t23.nl_next_promotion_start_date =
             SALES_PROMO0.promo_start_dt OR t23.pl_next_promotion_start_date = SALES_PROMO0.promo_start_dt OR t23.sk_next_promotion_start_date
            = SALES_PROMO0.promo_start_dt) AND SALES_PROMO0.dwh_valid_fg
     GROUP BY t23.prod_sid)) (SELECT t8.prod_sid,
   t8.prod_nr,
   t8.prod_name,
   t8.wh_sid,
   t8.wh_cd,
   t8.correct_utilisation,
   t8.util_action_cd,
   t8.total_stock_cnt,
   t8.total_stock_val,
   t8.blocked_stock_cnt,
   t8.blocked_stock_val,
   t8.unrestricted_stock_cnt,
   t8.unrestricted_stock_val,
   t13.be_prod_qty_last_week,
   t13.be_prod_qty_last_2_weeks,
   t13.be_prod_qty_last_6_weeks,
   t13.be_last_sales_date,
   t13.cz_prod_qty_last_week,
   t13.cz_prod_qty_last_2_weeks,
   t13.cz_prod_qty_last_6_weeks,
   t13.cz_last_sales_date,
   t13.de_prod_qty_last_week,
   t13.de_prod_qty_last_2_weeks,
   t13.de_prod_qty_last_6_weeks,
   t13.de_last_sales_date,
   t13.fr_prod_qty_last_week,
   t13.fr_prod_qty_last_2_weeks,
   t13.fr_prod_qty_last_6_weeks,
   t13.fr_last_sales_date,
   t13.nl_prod_qty_last_week,
   t13.nl_prod_qty_last_2_weeks,
   t13.nl_prod_qty_last_6_weeks,
   t13.nl_last_sales_date,
   t13.pl_prod_qty_last_week,
   t13.pl_prod_qty_last_2_weeks,
   t13.pl_prod_qty_last_6_weeks,
   t13.pl_last_sales_date,
   t13.sk_prod_qty_last_week,
   t13.sk_prod_qty_last_2_weeks,
   t13.sk_prod_qty_last_6_weeks,
   t13.sk_last_sales_date,
   t13.prod_qty_last_week,
   t13.prod_qty_last_week_less_7_fg,
   t13.last_sales_date,
   t18.be_prod_online_status_cd,
   t18.cz_prod_online_status_cd,
   t18.de_prod_online_status_cd,
   t18.fr_prod_online_status_cd,
   t18.nl_prod_online_status_cd,
   t18.pl_prod_online_status_cd,
   t18.sk_prod_online_status_cd,
   t18.palette_capacity_cnt,
   t18.prod_manager_name,
   t33.be_next_promotion_start_date,
   t33.cz_next_promotion_start_date,
   t33.de_next_promotion_start_date,
   t33.fr_next_promotion_start_date,
   t33.nl_next_promotion_start_date,
   t33.pl_next_promotion_start_date,
   t33.sk_next_promotion_start_date,
   t33.next_promotion_start_date,
   t33.next_promotion_start_date_outside_next_4_weeks_fg,
   t33.be_tgt_prod_sale_qty,
   t33.cz_tgt_prod_sale_qty,
   t33.de_tgt_prod_sale_qty,
   t33.fr_tgt_prod_sale_qty,
   t33.nl_tgt_prod_sale_qty,
   t33.pl_tgt_prod_sale_qty,
   t33.sk_tgt_prod_sale_qty,
   t33.promo_season_cd,
   t33.next_delivery_cy_week,
   t33.no_upcoming_delivery_fg,
   t33.last_delivery_cy_week,
   t33.last_delivery_more_than_8_weeks_ago_fg
  FROM STOCK AS t8
   LEFT JOIN SALES_2 AS t13 ON t8.prod_sid = t13.prod_sid AND t8.wh_sid = t13.wh_sid
   LEFT JOIN PRODUCT AS t18 ON t8.prod_sid = t18.prod_sid
   LEFT JOIN AMC AS t33 ON t8.prod_sid = t33.prod_sid);