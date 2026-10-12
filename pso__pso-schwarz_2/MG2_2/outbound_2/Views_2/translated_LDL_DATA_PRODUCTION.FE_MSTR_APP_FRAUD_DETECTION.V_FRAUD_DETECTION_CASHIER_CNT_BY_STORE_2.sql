CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_cashier_cnt_by_store_2 AS WITH
 cte_min_analysis_dt AS (SELECT MIN(analysis_period_start_dt) AS analysis_period_start_dt
  FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_2 AS ord
  WHERE order_parameter_status_cd = 'RV') (SELECT main.int_org_sid AS store_sid,
   COUNT(DISTINCT main.cashier_nr) AS cashier_cnt
  FROM ldl_data_production_core_app_fraud_detection.t_statistics_by_store_hour_cashier_2 AS main
   INNER JOIN cte_min_analysis_dt AS DT ON main.bus_dt >= DT.analysis_period_start_dt
  GROUP BY store_sid);