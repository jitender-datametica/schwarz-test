CREATE OR REPLACE VIEW ldl_dig_lec_share.v_agg_data_quality_kpi_2 AS WITH COGS_DATA AS (SELECT cust_order_dt,
    IFNULL(cogs_price_net_local_val, 0) = 0 AS zero_cogs_fg
  FROM ldl_dig_core.t_fact_customer_order_line_2 AS ORDER_LINE
  WHERE cust_order_dt >= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)), COGS_AGG AS (SELECT cust_order_dt,
   COUNT(*) AS order_positions_cnt,
   SUM(CASE
     WHEN zero_cogs_fg IS NOT NULL
     THEN CASE
      WHEN zero_cogs_fg
      THEN 1
      ELSE 0
      END
     ELSE NULL
     END) AS missing_cogs_per_position_cnt,
   IF(COUNT(*) = 0, 0, SAFE_DIVIDE(SUM(CASE
       WHEN zero_cogs_fg IS NOT NULL
       THEN CASE
        WHEN zero_cogs_fg
        THEN 1
        ELSE 0
        END
       ELSE NULL
       END), COUNT(*))) AS cogs_availability_ratio,
    CAST(100 - ROUND(100 * IF(COUNT(*) = 0, 0, SAFE_DIVIDE(SUM(CASE
            WHEN zero_cogs_fg IS NOT NULL
            THEN CASE
             WHEN zero_cogs_fg
             THEN 1
             ELSE 0
             END
            ELSE NULL
            END), COUNT(*))), 2) AS STRING) || ' %' AS cogs_availability_pct
  FROM COGS_DATA
  GROUP BY cust_order_dt), PRCD_AGG AS (SELECT DATE_SUB(dm__operand, INTERVAL 1 DAY) AS cust_order_dt,
   prcd_updated_tmsp,
   CAST(CONCAT(dm__operand, ' 05:00:00') AS DATETIME) AS order_line_sheduled_tmsp,
    CASE
    WHEN prcd_updated_tmsp > CAST(CAST(CONCAT(dm__operand, ' 05:00:00') AS DATETIME) AS TIMESTAMP)
    THEN '❌'
    ELSE '✔'
    END AS check_prcd_in_time
  FROM (SELECT DATE(dwh_updated_tmsp) AS dm__operand,
     MAX(dwh_updated_tmsp) AS prcd_updated_tmsp
    FROM ldl_dig_etl_process.t_etl_prcd_elements_position_2 AS PRCD
    WHERE TIME(src_file_tmsp) BETWEEN TIME '01:00:00' AND TIME '03:30:00'
     AND DATE_SUB(DATE(dwh_updated_tmsp), INTERVAL 1 DAY) >= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)
    GROUP BY dm__operand) AS t10), ORDER_DELAY_DATA AS (SELECT ORDER_HEADER.cust_order_dt,
   ORDER_HEADER.cust_order_sid,
   ORDER_HEADER.dwh_created_tmsp AS head_dwh_tmsp,
   ORDER_POSITION.dwh_created_tmsp AS pos_dwh_tmsp,
   PARSE_DATETIME('%F %H:%M:%S', CONCAT(DATE_ADD(ORDER_HEADER.cust_order_dt, INTERVAL 1 DAY), ' 02:00:00')) AS
   sql_schedule_tmsp,
   IFNULL(GREATEST(ORDER_HEADER.dwh_created_tmsp, ORDER_POSITION.dwh_created_tmsp) < CAST(PARSE_DATETIME('%F %H:%M:%S', CONCAT(DATE_ADD(ORDER_HEADER.cust_order_dt, INTERVAL 1 DAY), ' 02:00:00')) AS TIMESTAMP)
     , FALSE) AS etl_before_sql_fg
  FROM ldl_dig_etl_process.t_etl_order_header_2 AS ORDER_HEADER
   LEFT JOIN ldl_dig_etl_process.t_etl_order_position_2 AS ORDER_POSITION ON ORDER_HEADER.cust_order_sid = ORDER_POSITION
    .cust_order_sid
  WHERE ORDER_HEADER.cust_order_type_cd IN ('ZWSO', 'ZRPL')
   AND ORDER_HEADER.cust_order_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1
      DAY))), ORDER_DELAY_AGG AS (SELECT cust_order_dt,
   COUNT(DISTINCT cust_order_sid) AS total_orders_cnt,
   COUNT(DISTINCT IF(etl_before_sql_fg = FALSE, cust_order_sid, NULL)) AS delay_cnt,
   IF(COUNT(DISTINCT cust_order_sid) = 0, 0, SAFE_DIVIDE(COUNT(DISTINCT IF(etl_before_sql_fg = FALSE, cust_order_sid,
       NULL)), COUNT(DISTINCT cust_order_sid))) AS delay_ratio,
    CAST(ROUND(100 * IF(COUNT(DISTINCT cust_order_sid) = 0, 0, SAFE_DIVIDE(COUNT(DISTINCT IF(etl_before_sql_fg = FALSE, cust_order_sid, NULL)), COUNT(DISTINCT cust_order_sid))), 2) AS STRING)
    || ' %' AS delay_pct,
    CAST(ROUND(100 * (1 - IF(COUNT(DISTINCT cust_order_sid) = 0, 0, SAFE_DIVIDE(COUNT(DISTINCT IF(etl_before_sql_fg = FALSE, cust_order_sid, NULL)), COUNT(DISTINCT cust_order_sid)))), 2) AS STRING)
    || ' %' AS on_time_pct
  FROM ORDER_DELAY_DATA
  GROUP BY cust_order_dt) (SELECT t7.cust_order_dt,
   t7.order_positions_cnt,
   t7.missing_cogs_per_position_cnt,
   t7.cogs_availability_pct,
   t12.prcd_updated_tmsp,
   t12.order_line_sheduled_tmsp,
   t12.check_prcd_in_time,
   t20.total_orders_cnt,
   t20.delay_cnt,
   t20.delay_pct,
   t20.on_time_pct
  FROM COGS_AGG AS t7
   FULL JOIN PRCD_AGG AS t12 ON t7.cust_order_dt = t12.cust_order_dt
   FULL JOIN ORDER_DELAY_AGG AS t20 ON t7.cust_order_dt = t20.cust_order_dt
  ORDER BY t7.cust_order_dt DESC NULLS FIRST);