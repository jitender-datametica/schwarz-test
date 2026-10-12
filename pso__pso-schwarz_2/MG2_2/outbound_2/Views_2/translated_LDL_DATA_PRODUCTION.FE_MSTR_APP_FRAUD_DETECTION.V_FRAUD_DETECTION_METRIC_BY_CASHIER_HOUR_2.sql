CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_metric_by_cashier_hour_2 AS WITH
 cte_metrics AS (SELECT m.metric_id,
   m.calculation_type_cd,
   m.scenario_id,
   ((SUBSTR(m.format_type_cd, 1, 3) = 'INTEGER ' OR SUBSTR(m.format_type_cd, 1, 3) = 'FLT' AND m.calculation_type_cd =
         'LEVELAVG' OR m.metric_id BETWEEN 3400 AND 3499 OR m.metric_id BETWEEN 2400 AND 2499)) IS NOT TRUE AS
   exchange_rate_calc_fg
  FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s ON m.scenario_id = s.scenario_id
    ) (SELECT main.store_sid,
   main.cashier_nr,
   main.bus_dt,
   main.hr,
   M.metric_id,
   main.country_org_cd,
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
   M.scenario_id,
   M.calculation_type_cd,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN main.metric_val_1 / fer.exchange_rate
    ELSE main.metric_val_1
    END AS metric_val_1,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN main.metric_val_2 / fer.exchange_rate
    ELSE main.metric_val_2
    END AS metric_val_2,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN main.metric_val_3 / fer.exchange_rate
    ELSE main.metric_val_3
    END AS metric_val_3,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN main.metric_val_4 / fer.exchange_rate
    ELSE main.metric_val_4
    END AS metric_val_4
  FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_metric_by_cashier_hour_2 AS main
   INNER JOIN cte_metrics AS M ON main.metric_id = M.metric_id
   INNER JOIN ldl_data_production_core_dim.t_dim_country_2 AS ct ON main.country_org_cd = ct.iso_country_cd
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON ct.curr_cd = fer.tgt_curr_cd
  WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
   AND fer.active_fg);