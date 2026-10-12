CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_cash_register_event_classification_by_cashier_day_cust_1 (store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED CASH REGISTER EVENT HAPPENED.'),
bus_dt OPTIONS(description='THE BUSINESS DATE ON WHICH THE RETAIL EVENT IS COUNTED.'), cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
scenario_id OPTIONS(description='THE UNIQUE IDENTIFIER OF FRAUD DETECTION SCENARIO'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY_1 FOR WHICH THE RELATED COUNTRY_1 ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY_1 IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
cust_sid OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE CUSTOMER.'), metric_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF MICROSTRATEY METRIC'), calculation_type_cd
OPTIONS(description='THE CALCULATION TYPE OF THE METRIC SUM,SMARTAVG..'), scenario_value_1
OPTIONS(description='THE FIRST VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), scenario_value_2
OPTIONS(description='THE SECOND VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), scenario_value_3
OPTIONS(description='THE THIRD VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), scenario_value_4
OPTIONS(description='THE  VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), curr_cd
OPTIONS(description='THE CODE IDENTIFYING THE CURRENCY ACCORDING TO ISO-4217.'), curr_group_fg
OPTIONS(description='FLAG FOR GROUP CURRENCY'), curr_local_fg OPTIONS(description='FLAG FOR LOCAL CURRENCY'))
OPTIONS(DESCRIPTION = `THIS VIEW BRINGS THE VALUES IN A NORMALIZED FORM TO CALCULATE THE METRICS, WHICH WILL BE USED FOR DYNAMIC DASHBOARD`)
AS WITH CTE_STATISTICS_BY_STORE_DAY_CASHIER AS (SELECT ORG.country_org_cd,
   ORG.sales_company_sid,
   MAIN.int_org_sid AS store_sid,
   MAIN.bus_dt,
   MAIN.cashier_nr,
   FER.src_curr_cd AS curr_cd,
    CASE
    WHEN FER.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN FER.src_curr_cd = FER.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg,
   MAIN.sales_net_val,
   MAIN.return_net_val
  FROM ldl_data_core_app_fraud_detection.t_statistics_by_store_hour_cashier_1 AS MAIN
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS ORG ON MAIN.int_org_sid = ORG.int_org_sid AND ORG.dwh_valid_fg
    
   INNER JOIN ldl_data_core_dim.t_dim_country_1 AS CT ON ORG.country_org_cd = CT.iso_country_cd
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_1 AS FER ON CT.curr_cd = FER.tgt_curr_cd
  WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
   AND FER.active_fg), CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS (SELECT MAIN0.country_org_cd,
   STORE.sales_company_sid,
   MAIN0.store_sid,
   MAIN0.cashier_nr,
   MAIN0.scenario_id,
   MAIN0.cust_sid,
   MAIN0.bus_dt,
   FER0.src_curr_cd AS curr_cd,
    CASE
    WHEN FER0.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN FER0.src_curr_cd = FER0.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg,
   SUM(MAIN0.cash_register_event_cnt) AS cash_register_event_cnt,
   SUM(MAIN0.cash_register_event_affected_line_cnt) AS cash_register_event_affected_line_cnt,
   SUM(MAIN0.cash_register_event_affected_line_cnt) AS cash_register_event_affected_net_val,
   COUNT(DISTINCT MAIN0.cust_sid) AS cust_sid_dst_cnt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_1 AS MAIN0
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS STORE ON MAIN0.store_sid = STORE.int_org_sid AND STORE.dwh_valid_fg
    
   INNER JOIN ldl_data_core_dim.t_dim_country_1 AS CT0 ON MAIN0.country_org_cd = CT0.iso_country_cd
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_1 AS FER0 ON CT0.curr_cd = FER0.tgt_curr_cd
  WHERE FER0.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER0.src_curr_cd = 'EUR' OR FER0.src_curr_cd = FER0.tgt_curr_cd)
   AND FER0.active_fg
   AND MAIN0.scenario_id IN (20, 40, 200100)
  GROUP BY MAIN0.country_org_cd,
   STORE.sales_company_sid,
   MAIN0.store_sid,
   MAIN0.cashier_nr,
   MAIN0.scenario_id,
   MAIN0.bus_dt,
   curr_cd,
   FER0.tgt_curr_cd,
   MAIN0.cust_sid), CTE_CASHIER_SCENARIO AS (SELECT country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id,
   cust_sid
  FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
  GROUP BY country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id,
   cust_sid), CTE_STORE_ANALYSIS_PERIOD AS (SELECT SAL_COMP.country_org_cd,
   STORE0.int_org_sid AS store_sid,
   MIN(ORD.analysis_period_start_dt) AS analysis_period_start_dt,
   MAX(ORD.analysis_period_end_dt) AS analysis_period_end_dt
  FROM ldl_data_core_app_fraud_detection.t_fraud_detection_order_1 AS ORD
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS SAL_COMP ON ORD.int_org_sid = SAL_COMP.int_org_sid
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS STORE0 ON SAL_COMP.sales_company_sid = STORE0.sales_company_sid
    
  WHERE SAL_COMP.dwh_valid_fg
   AND STORE0.dwh_valid_fg
   AND ORD.order_parameter_status_cd = 'RV'
   AND STORE0.int_org_type_cd = 'STORE'
  GROUP BY SAL_COMP.country_org_cd,
   store_sid), CTE_COUNTRY_IN_RV AS (SELECT country_org_cd,
   MIN(analysis_period_start_dt) AS analysis_period_start_dt,
   MAX(analysis_period_end_dt) AS analysis_period_end_dt
  FROM ldl_data_core_app_fraud_detection.t_fraud_detection_order_1 AS ORD
  WHERE order_parameter_status_cd = 'RV'
  GROUP BY country_org_cd), CTE_CUSTOMER_DAY_COUNTRY AS (SELECT R.cust_sid,
   R.bus_dt,
   R.country_org_cd,
   SUM(CASE
     WHEN R.retail_event_type_cd = 'S'
     THEN 1.0
     ELSE NULL
     END) AS sales_event_cnt,
   SUM(CASE
     WHEN R.retail_event_type_cd = 'R'
     THEN 1.0
     ELSE NULL
     END) AS return_event_cnt,
   FER1.src_curr_cd AS curr_cd,
    CASE
    WHEN FER1.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN FER1.src_curr_cd = FER1.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg
  FROM ldl_data_core_rel.t_retail_event_1 AS R
   INNER JOIN CTE_COUNTRY_IN_RV AS CNTRY_IN_RV ON R.country_org_cd = CNTRY_IN_RV.country_org_cd AND R.bus_dt BETWEEN
     CNTRY_IN_RV.analysis_period_start_dt AND CNTRY_IN_RV.analysis_period_end_dt
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_1 AS FER1 ON R.curr_cd = FER1.tgt_curr_cd
  WHERE R.turnover_relevant_fg
   AND R.bus_dt > DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY)
   AND FER1.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER1.src_curr_cd = 'EUR' OR FER1.src_curr_cd = FER1.tgt_curr_cd)
   AND FER1.active_fg
   AND R.cust_sid IS NOT NULL
  GROUP BY R.cust_sid,
   R.bus_dt,
   R.country_org_cd,
   curr_cd,
   FER1.tgt_curr_cd), CTE_STORE_CUST AS (SELECT FACT.country_org_cd,
   FACT.sales_company_sid,
   FACT.store_sid,
   FACT.scenario_id,
   FACT.cust_sid,
   MIN(RV.analysis_period_start_dt) AS analysis_period_start_dt,
   MAX(RV.analysis_period_end_dt) AS analysis_period_end_dt
  FROM CTE_CASHIER_SCENARIO AS FACT
   INNER JOIN CTE_STORE_ANALYSIS_PERIOD AS RV ON FACT.country_org_cd = RV.country_org_cd AND FACT.store_sid = RV.store_sid
     
  GROUP BY FACT.country_org_cd,
   FACT.sales_company_sid,
   FACT.store_sid,
   FACT.scenario_id,
   FACT.cust_sid), CTE_CUSTOMER_DAY_STORE AS (SELECT R.cust_sid,
   R.bus_dt,
   R.country_org_cd,
   R.store_sid,
   CTE_STORE_IN_RV.scenario_id,
   SUM(CASE
     WHEN R.retail_event_type_cd = 'S'
     THEN 1.0
     ELSE NULL
     END) AS sales_event_cnt,
   SUM(CASE
     WHEN R.retail_event_type_cd = 'R'
     THEN 1.0
     ELSE NULL
     END) AS return_event_cnt,
   FER3.src_curr_cd AS curr_cd,
    CASE
    WHEN FER3.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN FER3.src_curr_cd = FER3.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg
  FROM ldl_data_core_rel.t_retail_event_1 AS R
   INNER JOIN CTE_STORE_CUST AS CTE_STORE_IN_RV ON R.country_org_cd = CTE_STORE_IN_RV.country_org_cd AND R.store_sid =
       CTE_STORE_IN_RV.store_sid AND R.cust_sid = CTE_STORE_IN_RV.cust_sid AND R.bus_dt BETWEEN CTE_STORE_IN_RV.analysis_period_start_dt
     AND CTE_STORE_IN_RV.analysis_period_end_dt
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_1 AS FER3 ON R.curr_cd = FER3.tgt_curr_cd
  WHERE R.turnover_relevant_fg
   AND R.bus_dt > DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY)
   AND FER3.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER3.src_curr_cd = 'EUR' OR FER3.src_curr_cd = FER3.tgt_curr_cd)
   AND FER3.active_fg
  GROUP BY R.cust_sid,
   R.bus_dt,
   R.country_org_cd,
   R.store_sid,
   CTE_STORE_IN_RV.scenario_id,
   curr_cd,
   FER3.tgt_curr_cd) (SELECT *
  FROM (SELECT FACT.store_sid,
      FACT.bus_dt,
      FACT.cashier_nr,
      - 100 AS scenario_id,
      FACT.country_org_cd,
      CASHIER.cust_sid,
      - 100 AS metric_id,
      'SUM' AS calculation_type_cd,
       COALESCE(FACT.sales_net_val, 0) - COALESCE(FACT.return_net_val, 0) AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4,
      FACT.curr_cd,
      FACT.curr_group_fg,
      FACT.curr_local_fg
     FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
      INNER JOIN CTE_CASHIER_SCENARIO AS CASHIER ON FACT.country_org_cd = CASHIER.country_org_cd AND FACT.store_sid =
         CASHIER.store_sid AND FACT.cashier_nr = CASHIER.cashier_nr
     WHERE COALESCE(FACT.sales_net_val, 0) - COALESCE(FACT.return_net_val, 0) <> 0
      AND CASHIER.scenario_id = 20
     UNION ALL
     SELECT MAIN.store_sid,
      CUST.bus_dt,
      MAIN.cashier_nr,
      40 AS scenario_id,
      MAIN.country_org_cd,
      MAIN.cust_sid,
      4050 AS metric_id,
      'SUM' AS calculation_type_cd,
       COALESCE(CUST.sales_event_cnt, 0) + COALESCE(CUST.return_event_cnt, 0) AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CUST.curr_cd,
      CUST.curr_group_fg,
      CUST.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS MAIN
      INNER JOIN CTE_STORE_ANALYSIS_PERIOD AS STO ON MAIN.country_org_cd = STO.country_org_cd AND MAIN.store_sid = STO.store_sid
        
      INNER JOIN CTE_CUSTOMER_DAY_COUNTRY AS CUST ON MAIN.cust_sid = CUST.cust_sid AND MAIN.country_org_cd = CUST.country_org_cd
          AND CUST.bus_dt BETWEEN STO.analysis_period_start_dt AND STO.analysis_period_end_dt
     WHERE MAIN.scenario_id = 20
     UNION ALL
     SELECT MAIN.store_sid,
      MAIN.bus_dt,
      MAIN.cashier_nr,
      MAIN.scenario_id,
      MAIN.country_org_cd,
      MAIN.cust_sid,
       CASE
       WHEN M.metric_id = 2010
       THEN CAST(- 100 AS BIGNUMERIC)
       ELSE M.metric_id
       END AS m_metric_id_m_metric_id,
      M.calculation_type_cd,
       CASE
       WHEN M.metric_id IN (2010, 2100, 2200, 3200)
       THEN MAIN.cash_register_event_affected_net_val
       WHEN M.metric_id = 4005
       THEN CAST(MAIN.cust_sid_dst_cnt AS BIGNUMERIC)
       ELSE MAIN.cash_register_event_cnt
       END AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      MAIN.curr_cd,
      MAIN.curr_group_fg,
      MAIN.curr_local_fg
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S ON MAIN.scenario_id = S.scenario_id
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS M ON S.scenario_id = M.scenario_id
     WHERE M.metric_id IN (2000, 200100)
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE_FACT.bus_dt,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      CASHIER.cust_sid,
      CASHIER.metric_id,
      CASHIER.calculation_type_cd,
      CASHIER_FACT.cash_register_event_cnt AS scenario_value_1,
      STORE_FACT.cash_register_event_cnt AS scenario_value_2,
      1 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE_FACT.curr_cd,
      STORE_FACT.curr_group_fg,
      STORE_FACT.curr_local_fg
     FROM (SELECT FACT.store_sid,
        FACT.cashier_nr,
        FACT.scenario_id,
        FACT.country_org_cd,
        FACT.cust_sid,
        M.metric_id,
        M.calculation_type_cd
       FROM CTE_CASHIER_SCENARIO AS FACT
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S ON FACT.scenario_id = S.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS M ON S.scenario_id = M.scenario_id
         
       WHERE S.scenario_type_cd = 'AUTO'
        AND M.calculation_type_cd = 'LEVELAVG') AS CASHIER
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.bus_dt,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        MAIN.cust_sid,
        M0.metric_id,
        SUM(COALESCE(MAIN.sales_event_cnt, 0) + COALESCE(MAIN.return_event_cnt, 0)) AS cash_register_event_cnt,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg
       FROM CTE_CUSTOMER_DAY_STORE AS MAIN
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S0 ON MAIN.scenario_id = S0.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS M0 ON S0.scenario_id = M0.scenario_id
         
       WHERE S0.scenario_type_cd = 'AUTO'
        AND M0.calculation_type_cd = 'LEVELAVG'
       GROUP BY MAIN.store_sid,
        MAIN.bus_dt,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        MAIN.cust_sid,
        M0.metric_id,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg) AS STORE_FACT ON CASHIER.store_sid = STORE_FACT.store_sid AND CASHIER.metric_id = STORE_FACT
         .metric_id AND CASHIER.cust_sid = STORE_FACT.cust_sid
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.cashier_nr,
        MAIN.bus_dt,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        MAIN.cust_sid,
        M1.metric_id,
        MAIN.cash_register_event_cnt,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 AS S1 ON MAIN.scenario_id = S1.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS M1 ON S1.scenario_id = M1.scenario_id
         
       WHERE S1.scenario_type_cd = 'AUTO'
        AND M1.calculation_type_cd = 'LEVELAVG') AS CASHIER_FACT ON CASHIER.cashier_nr = CASHIER_FACT.cashier_nr AND
            STORE_FACT.store_sid = CASHIER_FACT.store_sid AND STORE_FACT.metric_id = CASHIER_FACT.metric_id AND
          STORE_FACT.bus_dt = CASHIER_FACT.bus_dt AND STORE_FACT.curr_cd = CASHIER_FACT.curr_cd AND STORE_FACT.cust_sid
        = CASHIER_FACT.cust_sid));