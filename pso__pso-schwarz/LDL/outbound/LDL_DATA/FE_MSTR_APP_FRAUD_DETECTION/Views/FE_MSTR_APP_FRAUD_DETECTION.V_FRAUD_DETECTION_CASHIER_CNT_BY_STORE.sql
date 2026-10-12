CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_cashier_cnt_by_store (store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED CASH REGISTER EVENT HAPPENED.'),
cashier_cnt OPTIONS(description='THE NUMBER OF CASHIERS WORKED ON ANALYSIS PERIOD'))
OPTIONS(DESCRIPTION = `CASHIER COUNT PER STORE FOR LAST 9 WEEKS`) AS WITH CTE_MIN_ANALYSIS_DT AS (SELECT MIN(analysis_period_start_dt
    ) AS analysis_period_start_dt
  FROM ldl_data_core_app_fraud_detection.t_fraud_detection_order AS ORD
  WHERE order_parameter_status_cd = 'RV') (SELECT MAIN.int_org_sid AS store_sid,
   COUNT(DISTINCT MAIN.cashier_nr) AS cashier_cnt
  FROM ldl_data_core_app_fraud_detection.t_statistics_by_store_hour_cashier AS MAIN
   INNER JOIN CTE_MIN_ANALYSIS_DT AS DT ON MAIN.bus_dt >= DT.analysis_period_start_dt
  GROUP BY store_sid);