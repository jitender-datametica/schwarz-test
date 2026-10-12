-- special requirement for artikelabverkauf report

CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_sales_promotion_2 AS WITH PROMO_DUR_WEEK_FG AS (SELECT PROMO0.promo_id
   ,
   PROMO0.wshop_cd,
   PROMO0.prod_sid,
    DATE_ADD(PROMO0.first_week_start_dt, INTERVAL CAST(ROUND(par.days_since_promo_start_cnt) AS INTEGER) DAY) < DATE(CURRENT_TIMESTAMP()
     ) AS finished_prom_weeks_fg
  FROM ldl_dig_lec_share.v_agg_sales_promotion_core_view_2 AS PROMO0
   LEFT JOIN (SELECT PARSE_DATE('%F', parameter_value_char) AS active_from,
     PARSE_DATE('%F', parameter_value_char) AS valid_from,
     LEAD(DATE_SUB(PARSE_DATE('%F', parameter_value_char), INTERVAL 1 DAY), 1, PARSE_DATE('%F', '9999-12-31')) OVER (PARTITION BY
        report ORDER BY PARSE_DATE('%F', parameter_value_char) IS NULL, PARSE_DATE('%F', parameter_value_char)) AS
     valid_to,
     parameter_value_numeric AS days_since_promo_start_cnt
    FROM ldl_dig_lec_share.v_meta_report_parameter_2 AS REP
    WHERE report = 'Artikelabverkauf') AS par ON PROMO0.first_week_start_dt BETWEEN par.valid_from AND par.valid_to) (SELECT
   *
  FROM (SELECT CASE
       WHEN PROMO.wshop_cd = ''
       THEN '-1'
       ELSE IFNULL(PROMO.wshop_cd, '-1')
       END AS wshop_cd,
      IFNULL(PROMO.prod_sid, -1) AS prod_sid,
      PROMO.promo_start_dt,
      CAST(FLOOR(DATE_DIFF(CURRENT_DATE, PROMO.promo_start_dt, DAY) / 7) AS INTEGER) AS passed_sale_weeks,
      PROMO.promo_sale_start_dt,
       CASE
       WHEN PROMO.sale_promo_type_cd = ''
       THEN '-1'
       ELSE IFNULL(PROMO.sale_promo_type_cd, '-1')
       END AS sale_promo_type_cd,
      PROMO.is_repeated_fg,
      PROMO.promo_dur_week_cnt,
      PROMO.first_week_start_dt,
      PROMO.analysis_start_dt,
      PROMO.analysis_end_dt,
       CASE
       WHEN PROMO.sale_promo_status_cd = ''
       THEN '-1'
       ELSE IFNULL(PROMO.sale_promo_status_cd, '-1')
       END AS sale_promo_status_cd,
      IFNULL(PROMO.promo_id, -1) AS promo_id,
      PROMO.tgt_prod_receive_cy_week,
      PROMO.first_delivery_cy_week,
      PROMO.supplier_order_qty,
      PROMO.tgt_prod_sale_qty,
      PROMO.is_first_promotion_fg,
      PROMO.promo_nr,
      PROMO.promo_descr,
      IFNULL(PROMO.amc_ian_nr, '-1') AS amc_ian_nr,
      IFNULL(PROMO.amc_ian_nr, 'n/a') AS amc_ian_nr_artikelabverkauf,
      PROMO.is_tv_promo_fg,
      PROMO.return_cond_descr,
      PROMO.is_catalog_promo_fg,
       DATE_ADD(PROMO.first_week_start_dt, INTERVAL 13 DAY) < DATE(CURRENT_TIMESTAMP()) AS finished_3_prom_weeks_fg,
      pdur.finished_prom_weeks_fg
     FROM ldl_dig_lec_share.v_agg_sales_promotion_core_view_2 AS PROMO
      LEFT JOIN PROMO_DUR_WEEK_FG AS pdur ON PROMO.promo_id = pdur.promo_id AND PROMO.wshop_cd = pdur.wshop_cd AND PROMO
        .prod_sid = pdur.prod_sid
     UNION ALL
     SELECT '-1' -- WSHOP_CD
,
      ROUND(CAST('-1' -- PROD_SID
 AS BIGNUMERIC), 0),
      DATE('1900-01-01') -- PROMO_START_DT
,
      ROUND(CAST('0' -- PASSED_SALE_WEEKS
 AS NUMERIC), 0),
      DATE('1900-01-01') -- PROMO_SALE_START_DT
,
      '-1' -- SALE_PROMO_TYPE_CD
,
      CAST('FALSE' -- IS_REPEATED_FG
 AS BOOL),
      ROUND(CAST('0' -- PROMO_DUR_WEEK_CNT
 AS BIGNUMERIC), 0),
      DATE('1900-01-01') -- FIRST_WEEK_START_DT
,
      DATE('1900-01-01') -- ANALYSIS_START_DT
,
      DATE('1900-01-01') -- ANALYSIS_END_DT
,
      '-1' -- SALE_PROMO_STATUS_CD
,
      ROUND(CAST('-1' -- PROMO_ID
 AS BIGNUMERIC), 0),
      ROUND(CAST('0' -- TGT_PROD_RECEIVE_CY_WEEK
 AS BIGNUMERIC), 0),
      ROUND(CAST('0' -- FIRST_DELIVERY_CY_WEEK
 AS BIGNUMERIC), 0),
      ROUND(CAST('0' -- SUPPLIER_ORDER_QTY
 AS BIGNUMERIC), 0),
      ROUND(CAST('0' -- TGT_PROD_SALE_QTY
 AS BIGNUMERIC), 0),
      CAST('0' -- IS_FIRST_PROMOTION_FG
 AS INTEGER),
      '-1' -- PROMO_NR
,
      '' -- PROMO_DESCR
,
      '-1' -- AMC_IAN_NR
,
      'n/a' -- AMC_IAN_NR_ARTIKELABVERKAUF
,
      CAST('FALSE' -- IS_TV_PROMO_FG
 AS BOOL),
      '' -- RETURN_COND_DESCR
,
      CAST('FALSE' -- IS_CATALOG_PROMO_FG
 AS BOOL),
      CAST('FALSE' -- FINISHED_3_PROM_WEEKS_FG
 AS BOOL),
      CAST('FALSE' -- FINISEHD_PROM_WEEKS_FG
 AS BOOL)));