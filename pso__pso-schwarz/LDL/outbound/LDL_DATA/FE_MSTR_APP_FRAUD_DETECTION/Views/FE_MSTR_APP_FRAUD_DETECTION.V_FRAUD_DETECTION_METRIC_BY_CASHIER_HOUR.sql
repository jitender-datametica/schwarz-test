CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_metric_by_cashier_hour (store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED CASH REGISTER EVENT HAPPENED.'),
cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
bus_dt OPTIONS(description='THE BUSINESS DATE ON WHICH THE RETAIL EVENT IS COUNTED.'), hr
OPTIONS(description='HOUR INFORMATION'), metric_id OPTIONS(description='THE UNIQUE IDENTIFIER OF MICROSTRATEY METRIC'),
country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY FOR WHICH THE RELATED COUNTRY ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
curr_cd OPTIONS(description='THE CODE IDENTIFYING THE CURRENCY ACCORDING TO ISO-4217.'), curr_group_fg
OPTIONS(description='FLAG FOR GROUP CURRENCY'), curr_local_fg OPTIONS(description='FLAG FOR LOCAL CURRENCY'),
scenario_id OPTIONS(description='THE UNIQUE IDENTIFIER OF FRAUD DETECTION SCENARIO'), calculation_type_cd
OPTIONS(description='THE CALCULATION TYPE OF THE METRIC SUM,SMARTAVG..'), metric_val_1
OPTIONS(description='THE FIRST VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), metric_val_2
OPTIONS(description='THE SECOND VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), metric_val_3
OPTIONS(description='THE THIRD VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), metric_val_4
OPTIONS(description='THE  VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'))
OPTIONS(DESCRIPTION = `THIS VIEW BRINGS THE VALUES IN A NORMALIZED FORM TO CALCULATE THE METRICS, WHICH WILL BE USED FOR DYNAMIC DASHBOARD`)
AS WITH CTE_METRICS AS (SELECT M.metric_id,
   M.calculation_type_cd,
   M.scenario_id,
   ((SUBSTR(M.format_type_cd, 1, 3) = 'INT' OR SUBSTR(M.format_type_cd, 1, 3) = 'FLT' AND M.calculation_type_cd =
         'LEVELAVG' OR M.metric_id BETWEEN 3400 AND 3499 OR M.metric_id BETWEEN 2400 AND 2499)) IS NOT TRUE AS
   exchange_rate_calc_fg
  FROM ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS M
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S ON M.scenario_id = S.scenario_id) (SELECT
   MAIN.store_sid,
   MAIN.cashier_nr,
   MAIN.bus_dt,
   MAIN.hr,
   M.metric_id,
   MAIN.country_org_cd,
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
   M.scenario_id,
   M.calculation_type_cd,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN MAIN.metric_val_1 / FER.exchange_rate
    ELSE MAIN.metric_val_1
    END AS metric_val_1,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN MAIN.metric_val_2 / FER.exchange_rate
    ELSE MAIN.metric_val_2
    END AS metric_val_2,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN MAIN.metric_val_3 / FER.exchange_rate
    ELSE MAIN.metric_val_3
    END AS metric_val_3,
    CASE
    WHEN M.exchange_rate_calc_fg
    THEN MAIN.metric_val_4 / FER.exchange_rate
    ELSE MAIN.metric_val_4
    END AS metric_val_4
  FROM ldl_data_core_app_fraud_detection.t_fraud_detection_metric_by_cashier_hour AS MAIN
   INNER JOIN CTE_METRICS AS M ON MAIN.metric_id = M.metric_id
   INNER JOIN ldl_data_core_dim.t_dim_country AS CT ON MAIN.country_org_cd = CT.iso_country_cd
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER ON CT.curr_cd = FER.tgt_curr_cd
  WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
   AND FER.active_fg);