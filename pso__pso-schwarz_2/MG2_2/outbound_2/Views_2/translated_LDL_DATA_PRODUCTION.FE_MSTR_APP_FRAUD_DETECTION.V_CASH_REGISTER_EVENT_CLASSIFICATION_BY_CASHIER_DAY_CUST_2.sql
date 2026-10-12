CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_event_classification_by_cashier_day_cust_2
AS WITH cte_statistics_by_store_day_cashier AS (SELECT org.country_org_cd,
   org.sales_company_sid,
   main.int_org_sid AS store_sid,
   main.bus_dt,
   main.cashier_nr,
   fer.src_curr_cd AS curr_cd,
    CASE
    WHEN fer.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN fer.src_curr_cd = fer.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg,
   main.sales_net_val,
   main.return_net_val
  FROM ldl_data_production_core_app_fraud_detection.t_statistics_by_store_hour_cashier_2 AS main
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS org ON main.int_org_sid = org.int_org_sid AND
    org.dwh_valid_fg
   INNER JOIN ldl_data_production_core_dim.t_dim_country_2 AS ct ON org.country_org_cd = ct.iso_country_cd
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON ct.curr_cd = fer.tgt_curr_cd
  WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
   AND fer.active_fg), cte_cash_register_event_classification AS (SELECT main0.country_org_cd,
   store.sales_company_sid,
   main0.store_sid,
   main0.cashier_nr,
   main0.scenario_id,
   main0.cust_sid,
   main0.bus_dt,
   fer0.src_curr_cd AS curr_cd,
    CASE
    WHEN fer0.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN fer0.src_curr_cd = fer0.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg,
   SUM(main0.cash_register_event_cnt) AS cash_register_event_cnt,
   SUM(main0.cash_register_event_affected_line_cnt) AS cash_register_event_affected_line_cnt,
   SUM(main0.cash_register_event_affected_line_cnt) AS cash_register_event_affected_net_val,
   COUNT(DISTINCT main0.cust_sid) AS cust_sid_dst_cnt
  FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS main0
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS store ON main0.store_sid = store.int_org_sid
    AND store.dwh_valid_fg
   INNER JOIN ldl_data_production_core_dim.t_dim_country_2 AS ct0 ON main0.country_org_cd = ct0.iso_country_cd
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer0 ON ct0.curr_cd = fer0.tgt_curr_cd
  WHERE fer0.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer0.src_curr_cd = 'EUR' OR fer0.src_curr_cd = fer0.tgt_curr_cd)
   AND fer0.active_fg
   AND main0.scenario_id IN (20, 40, 200100)
  GROUP BY main0.country_org_cd,
   store.sales_company_sid,
   main0.store_sid,
   main0.cashier_nr,
   main0.scenario_id,
   main0.bus_dt,
   curr_cd,
   fer0.tgt_curr_cd,
   main0.cust_sid), cte_cashier_scenario AS (SELECT country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id,
   cust_sid
  FROM cte_cash_register_event_classification AS FACT
  GROUP BY country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id,
   cust_sid), cte_store_analysis_period AS (SELECT sal_comp.country_org_cd,
   store0.int_org_sid AS store_sid,
   MIN(ord.analysis_period_start_dt) AS analysis_period_start_dt,
   MAX(ord.analysis_period_end_dt) AS analysis_period_end_dt
  FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_2 AS ord
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS sal_comp ON ord.int_org_sid = sal_comp.int_org_sid
    
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS store0 ON sal_comp.sales_company_sid = store0
    .sales_company_sid
  WHERE sal_comp.dwh_valid_fg
   AND store0.dwh_valid_fg
   AND ord.order_parameter_status_cd = 'RV'
   AND store0.int_org_type_cd = 'STORE'
  GROUP BY sal_comp.country_org_cd,
   store_sid), cte_country_in_rv AS (SELECT country_org_cd,
   MIN(analysis_period_start_dt) AS analysis_period_start_dt,
   MAX(analysis_period_end_dt) AS analysis_period_end_dt
  FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_2 AS ord
  WHERE order_parameter_status_cd = 'RV'
  GROUP BY country_org_cd), cte_customer_day_country AS (SELECT r.cust_sid,
   r.bus_dt,
   r.country_org_cd,
   SUM(CASE
     WHEN r.retail_event_type_cd = 'S'
     THEN 1.0
     ELSE NULL
     END) AS sales_event_cnt,
   SUM(CASE
     WHEN r.retail_event_type_cd = 'R'
     THEN 1.0
     ELSE NULL
     END) AS return_event_cnt,
   fer1.src_curr_cd AS curr_cd,
    CASE
    WHEN fer1.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN fer1.src_curr_cd = fer1.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg
  FROM ldl_data_production_core_rel.t_retail_event_2 AS r
   INNER JOIN cte_country_in_rv AS CNTRY_IN_RV ON r.country_org_cd = CNTRY_IN_RV.country_org_cd AND r.bus_dt BETWEEN
     CNTRY_IN_RV.analysis_period_start_dt AND CNTRY_IN_RV.analysis_period_end_dt
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer1 ON r.curr_cd = fer1.tgt_curr_cd
  WHERE r.turnover_relevant_fg
   AND r.bus_dt > DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY)
   AND fer1.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer1.src_curr_cd = 'EUR' OR fer1.src_curr_cd = fer1.tgt_curr_cd)
   AND fer1.active_fg
   AND r.cust_sid IS NOT NULL
  GROUP BY r.cust_sid,
   r.bus_dt,
   r.country_org_cd,
   curr_cd,
   fer1.tgt_curr_cd), cte_store_cust AS (SELECT FACT.country_org_cd,
   FACT.sales_company_sid,
   FACT.store_sid,
   FACT.scenario_id,
   FACT.cust_sid,
   MIN(RV.analysis_period_start_dt) AS analysis_period_start_dt,
   MAX(RV.analysis_period_end_dt) AS analysis_period_end_dt
  FROM cte_cashier_scenario AS FACT
   INNER JOIN cte_store_analysis_period AS RV ON FACT.country_org_cd = RV.country_org_cd AND FACT.store_sid = RV.store_sid
     
  GROUP BY FACT.country_org_cd,
   FACT.sales_company_sid,
   FACT.store_sid,
   FACT.scenario_id,
   FACT.cust_sid), cte_customer_day_store AS (SELECT r.cust_sid,
   r.bus_dt,
   r.country_org_cd,
   r.store_sid,
   CTE_STORE_IN_RV.scenario_id,
   SUM(CASE
     WHEN r.retail_event_type_cd = 'S'
     THEN 1.0
     ELSE NULL
     END) AS sales_event_cnt,
   SUM(CASE
     WHEN r.retail_event_type_cd = 'R'
     THEN 1.0
     ELSE NULL
     END) AS return_event_cnt,
   fer3.src_curr_cd AS curr_cd,
    CASE
    WHEN fer3.src_curr_cd = 'EUR'
    THEN 1
    ELSE 0
    END AS curr_group_fg,
    CASE
    WHEN fer3.src_curr_cd = fer3.tgt_curr_cd
    THEN 1
    ELSE 0
    END AS curr_local_fg
  FROM ldl_data_production_core_rel.t_retail_event_2 AS r
   INNER JOIN cte_store_cust AS CTE_STORE_IN_RV ON r.country_org_cd = CTE_STORE_IN_RV.country_org_cd AND r.store_sid =
       CTE_STORE_IN_RV.store_sid AND r.cust_sid = CTE_STORE_IN_RV.cust_sid AND r.bus_dt BETWEEN CTE_STORE_IN_RV.analysis_period_start_dt
     AND CTE_STORE_IN_RV.analysis_period_end_dt
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer3 ON r.curr_cd = fer3.tgt_curr_cd
  WHERE r.turnover_relevant_fg
   AND r.bus_dt > DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY)
   AND fer3.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer3.src_curr_cd = 'EUR' OR fer3.src_curr_cd = fer3.tgt_curr_cd)
   AND fer3.active_fg
  GROUP BY r.cust_sid,
   r.bus_dt,
   r.country_org_cd,
   r.store_sid,
   CTE_STORE_IN_RV.scenario_id,
   curr_cd,
   fer3.tgt_curr_cd) (SELECT *
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
     FROM cte_statistics_by_store_day_cashier AS FACT
      INNER JOIN cte_cashier_scenario AS CASHIER ON FACT.country_org_cd = CASHIER.country_org_cd AND FACT.store_sid =
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
     FROM cte_cashier_scenario AS MAIN
      INNER JOIN cte_store_analysis_period AS STO ON MAIN.country_org_cd = STO.country_org_cd AND MAIN.store_sid = STO.store_sid
        
      INNER JOIN cte_customer_day_country AS CUST ON MAIN.cust_sid = CUST.cust_sid AND MAIN.country_org_cd = CUST.country_org_cd
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
       WHEN m.metric_id = 2010
       THEN - 100
       ELSE m.metric_id
       END AS m_metric_id_m_metric_id,
      m.calculation_type_cd,
       CASE
       WHEN m.metric_id IN (2010, 2100, 2200, 3200)
       THEN MAIN.cash_register_event_affected_net_val
       WHEN m.metric_id = 4005
       THEN CAST(MAIN.cust_sid_dst_cnt AS INTEGER)
       ELSE MAIN.cash_register_event_cnt
       END AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      MAIN.curr_cd,
      MAIN.curr_group_fg,
      MAIN.curr_local_fg
     FROM cte_cash_register_event_classification AS MAIN
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s ON MAIN.scenario_id = s.scenario_id
       
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m ON s.scenario_id = m.scenario_id
       
     WHERE m.metric_id IN (2000, 200100)
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
        m.metric_id,
        m.calculation_type_cd
       FROM cte_cashier_scenario AS FACT
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s ON FACT.scenario_id = s
         .scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m ON s.scenario_id = m
         .scenario_id
       WHERE s.scenario_type_cd = 'AUTO'
        AND m.calculation_type_cd = 'LEVELAVG') AS CASHIER
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.bus_dt,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        MAIN.cust_sid,
        m0.metric_id,
        SUM(COALESCE(MAIN.sales_event_cnt, 0) + COALESCE(MAIN.return_event_cnt, 0)) AS cash_register_event_cnt,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg
       FROM cte_customer_day_store AS MAIN
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s0 ON MAIN.scenario_id =
         s0.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m0 ON s0.scenario_id =
         m0.scenario_id
       WHERE s0.scenario_type_cd = 'AUTO'
        AND m0.calculation_type_cd = 'LEVELAVG'
       GROUP BY MAIN.store_sid,
        MAIN.bus_dt,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        MAIN.cust_sid,
        m0.metric_id,
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
        m1.metric_id,
        MAIN.cash_register_event_cnt,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg
       FROM cte_cash_register_event_classification AS MAIN
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s1 ON MAIN.scenario_id =
         s1.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m1 ON s1.scenario_id =
         m1.scenario_id
       WHERE s1.scenario_type_cd = 'AUTO'
        AND m1.calculation_type_cd = 'LEVELAVG') AS CASHIER_FACT ON CASHIER.cashier_nr = CASHIER_FACT.cashier_nr AND
            STORE_FACT.store_sid = CASHIER_FACT.store_sid AND STORE_FACT.metric_id = CASHIER_FACT.metric_id AND
          STORE_FACT.bus_dt = CASHIER_FACT.bus_dt AND STORE_FACT.curr_cd = CASHIER_FACT.curr_cd AND STORE_FACT.cust_sid
        = CASHIER_FACT.cust_sid));