-- 
 -- 
 -- THIS WILL CREATE SEPARATE ROWS FOR RECEIPT AND ACTIVE FLAG
 -- Main

CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_cash_register_event_classification_by_cashier_day (store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED CASH REGISTER EVENT HAPPENED.'),
bus_dt OPTIONS(description='THE BUSINESS DATE ON WHICH THE RETAIL EVENT IS COUNTED.'), hr
OPTIONS(description='HOUR INFORMATION'), cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
scenario_id OPTIONS(description='THE UNIQUE IDENTIFIER OF FRAUD DETECTION SCENARIO'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY FOR WHICH THE RELATED COUNTRY ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
metric_id OPTIONS(description='THE UNIQUE IDENTIFIER OF MICROSTRATEY METRIC'), calculation_type_cd
OPTIONS(description='THE CALCULATION TYPE OF THE METRIC SUM,SMARTAVG..'), scenario_value_1
OPTIONS(description='THE FIRST VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), scenario_value_2
OPTIONS(description='THE SECOND VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), scenario_value_3
OPTIONS(description='THE THIRD VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), scenario_value_4
OPTIONS(description='THE  VALUE TO CALCULATE DEFINED MICROSTRATEGY METRIC'), curr_cd
OPTIONS(description='THE CODE IDENTIFYING THE CURRENCY ACCORDING TO ISO-4217.'), curr_group_fg
OPTIONS(description='FLAG FOR GROUP CURRENCY'), curr_local_fg OPTIONS(description='FLAG FOR LOCAL CURRENCY'))
OPTIONS(DESCRIPTION = `THIS VIEW BRINGS THE VALUES IN A NORMALIZED FORM TO CALCULATE THE METRICS, WHICH WILL BE USED FOR DYNAMIC DASHBOARD`)
AS WITH CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS (SELECT MAIN.country_org_cd,
   STORE.sales_company_sid,
   MAIN.store_sid,
   MAIN.cashier_nr,
   MAIN.scenario_id,
   MAIN.bus_dt,
   MAIN.event_end_hr,
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
   SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
   SUM(MAIN.cash_register_event_affected_line_cnt) AS cash_register_event_affected_line_cnt,
   SUM(MAIN.cash_register_event_affected_line_cnt) AS cash_register_event_affected_net_val,
   COUNT(DISTINCT MAIN.cust_sid) AS cust_sid_dst_cnt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification AS MAIN
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization AS STORE ON MAIN.store_sid = STORE.int_org_sid AND STORE.dwh_valid_fg
    
   INNER JOIN ldl_data_core_dim.t_dim_country AS CT ON MAIN.country_org_cd = CT.iso_country_cd
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER ON CT.curr_cd = FER.tgt_curr_cd
  WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
   AND FER.active_fg
  GROUP BY MAIN.country_org_cd,
   STORE.sales_company_sid,
   MAIN.store_sid,
   MAIN.cashier_nr,
   MAIN.scenario_id,
   MAIN.bus_dt,
   MAIN.event_end_hr,
   curr_cd,
   FER.tgt_curr_cd), CTE_STATISTICS_BY_STORE_DAY_CASHIER AS (SELECT ORG.country_org_cd,
   ORG.sales_company_sid,
   MAIN.int_org_sid AS store_sid,
   MAIN.bus_dt,
   MAIN.event_end_hr,
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
    MAIN.sales_net_val / FER.exchange_rate AS sales_net_val,
    MAIN.return_net_val / FER.exchange_rate AS return_net_val,
   MAIN.event_cnt,
   MAIN.event_line_cnt,
   MAIN.return_cnt,
   MAIN.cancelled_line_cnt,
    MAIN.cancelled_net_val / FER.exchange_rate AS cancelled_net_val,
   MAIN.discount_line_cnt,
    MAIN.discount_net_val / FER.exchange_rate AS discount_net_val,
   MAIN.abort_cnt,
    MAIN.abort_net_val / FER.exchange_rate AS abort_net_val,
   MAIN.suspended_unresolved_cnt,
    MAIN.suspended_unresolved_net_val / FER.exchange_rate AS suspended_unresolved_net_val,
   MAIN.price_info_cnt,
   MAIN.return_without_receipt_cnt,
    MAIN.return_without_receipt_net_val / FER.exchange_rate AS return_without_receipt_net_val,
    MAIN.deposit_sales_net_val / FER.exchange_rate AS deposit_sales_net_val,
    MAIN.deposit_return_net_val / FER.exchange_rate AS deposit_return_net_val,
    MAIN.deposit_return_manual_input_net_val / FER.exchange_rate AS deposit_return_manual_input_net_val,
    MAIN.deposit_return_manual_input_gross_val / FER.exchange_rate AS deposit_return_manual_input_gross_val,
    MAIN.deposit_only_return_net_val / FER.exchange_rate AS deposit_only_return_net_val,
   MAIN.small_sales_cnt,
   MAIN.login_cnt,
   MAIN.logoff_cnt
  FROM ldl_data_core_app_fraud_detection.t_statistics_by_store_hour_cashier AS MAIN
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization AS ORG ON MAIN.int_org_sid = ORG.int_org_sid AND ORG.dwh_valid_fg
    
   INNER JOIN ldl_data_core_dim.t_dim_country AS CT ON ORG.country_org_cd = CT.iso_country_cd
   INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER ON CT.curr_cd = FER.tgt_curr_cd
  WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
   AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
   AND FER.active_fg), CTE_CASHIER_SCENARIO AS (SELECT country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id
  FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
  GROUP BY country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id), CTE_STORES_IN_RV AS (SELECT ORG.country_org_cd,
   ORG.int_org_sid AS store_sid,
   ORD.analysis_period_start_dt AS from_bus_dt,
   ORD.analysis_period_end_dt AS until_bus_dt
  FROM ldl_data_core_dim.t_dim_internal_organization AS ORG
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_order AS ORD ON ORG.int_org_sid = ORD.int_org_sid OR
     ORG.sales_company_sid = ORD.int_org_sid
  WHERE ORG.dwh_valid_fg), CTE_STORES_AGG_VALUES AS (SELECT t26.bus_dt,
   t26.dm__operand AS event_end_hr,
   t26.country_org_cd,
   t26.store_sid,
   t26.curr_cd,
   t26.curr_group_fg,
   t26.curr_local_fg,
   t26.scenario_id,
   t26.cash_register_event_cnt
  FROM (SELECT t21.bus_dt,
     EXTRACT(HOUR FROM t21.event_start_tmsp) AS dm__operand,
     STORES.country_org_cd,
     STORES.store_sid,
     FER0.src_curr_cd AS curr_cd,
      CASE
      WHEN t21.flag_name = 'DEPOSIT_AND_ONE_PROD_FG'
      THEN 1
      WHEN t21.flag_name = 'DEPOSIT_SAME_EAN_FG'
      THEN 2
      WHEN t21.flag_name = 'DEPOSIT_ONLY_MANUAL_INPUT_FG'
      THEN 4
      WHEN t21.flag_name = 'PRICE_INFO_MULT_FG'
      THEN 5
      WHEN t21.flag_name = 'PRICE_INFO_AND_LOGOFF_FG' OR t21.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG'
      THEN 6
      WHEN t21.flag_name = 'RETURN_WITHOUT_AUTH_FG'
      THEN 7
      WHEN t21.flag_name = 'RETURN_SAME_RECEIPT_FG'
      THEN 8
      WHEN t21.flag_name = 'RETURN_SAME_PROD_FG'
      THEN 9
      WHEN t21.flag_name = 'RETURN_NOT_ON_RECEIPT_FG' OR t21.flag_name = 'RETURN_QTY_INVALID_FG'
      THEN 10
      WHEN t21.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' OR t21.flag_name =
        'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG'
      THEN 11
      WHEN t21.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG'
      THEN 12
      WHEN t21.flag_name = 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG'
      THEN 13
      WHEN t21.flag_name = 'RETURN_MULT_PROD_FG'
      THEN 14
      WHEN t21.flag_name = 'SUSPEND_AND_ABORT_FG' OR t21.flag_name = 'SUSPEND_AND_EXTEND_FG' OR t21.flag_name =
        'SUSPEND_AND_LINE_CANCEL_FG'
      THEN 15
      WHEN t21.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' OR t21.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
      THEN 16 -- WHEN FLAG_NAME = 'ABORT_AND_SALE_FG'

      -- OR FLAG_NAME = 'ABORT_AND_LOGOFF_FG'                     THEN 17

      WHEN t21.flag_name = 'CANCEL_LAST_POS_FG'
      THEN 18
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_FG'
      THEN 19
      WHEN t21.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG'
      THEN 60100
      WHEN t21.flag_name = 'PRICE_INFO_AND_LOGOFF_FG'
      THEN 60200
      WHEN t21.flag_name = 'RETURN_NOT_ON_RECEIPT_FG'
      THEN 100100
      WHEN t21.flag_name = 'RETURN_QTY_INVALID_FG'
      THEN 100200
      WHEN t21.flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG'
      THEN 110100
      WHEN t21.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG'
      THEN 110200
      WHEN t21.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG'
      THEN 120100
      WHEN t21.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG'
      THEN 120200
      WHEN t21.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG'
      THEN 120300
      WHEN t21.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG'
      THEN 120400
      WHEN t21.flag_name = 'RETURN_SAME_CASHIER_DIFF_DAY_FG'
      THEN 120600
      WHEN t21.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG'
      THEN 120700 -- WHEN FLAG_NAME = 'RETURN_SAME_CASHIER_AND_DAY_FG'                   THEN 120800

      -- TO BE CHECKED: PROBABLY NOT NEEDED BECAUSE IT IS USED FOR THE MAIN SCENARIO (12)

      WHEN t21.flag_name = 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG'
      THEN 130100
      WHEN t21.flag_name = 'RETURN_WITHOUT_RECEIPT_FG'
      THEN 130200
      WHEN t21.flag_name = 'RETURN_MULT_PROD_FULL_QTY_FG'
      THEN 140100
      WHEN t21.flag_name = 'SUSPEND_AND_ABORT_FG'
      THEN 150100
      WHEN t21.flag_name = 'SUSPEND_AND_EXTEND_FG'
      THEN 150200
      WHEN t21.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG'
      THEN 150300
      WHEN t21.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
      THEN 160100
      WHEN t21.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG'
      THEN 160200
      WHEN t21.flag_name = 'ABORT_AND_SALE_FG'
      THEN 170100
      WHEN t21.flag_name = 'ABORT_AND_LOGOFF_FG'
      THEN 170200
      WHEN t21.flag_name = 'CANCEL_LAST_POS_EXACT_PAYM_FG'
      THEN 180100
      WHEN t21.flag_name = 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG'
      THEN 180200
      WHEN t21.flag_name = 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG'
      THEN 180300
      WHEN t21.flag_name = 'CANCEL_LAST_POS_HIGHEST_POS_FG'
      THEN 180400
      WHEN t21.flag_name = 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG'
      THEN 180500
      WHEN t21.flag_name = 'CANCEL_LAST_AND_OTHER_POS_FG'
      THEN 180600
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG'
      THEN 190100
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG'
      THEN 190200
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG'
      THEN 190300
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG'
      THEN 190400
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG'
      THEN 190600
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG'
      THEN 190700
      WHEN t21.flag_name = 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG'
      THEN 190800
      ELSE - 1
      END AS scenario_id,
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
     SUM(1) AS cash_register_event_cnt
    FROM (SELECT *
FROM ldl_data_core_dim.t_fact_fraud_detection_by_cash_register_event AS FACT 
UNPIVOT EXCLUDE NULLS (flag_value FOR flag_name IN (
  deposit_and_one_prod_fg AS 'DEPOSIT_AND_ONE_PROD_FG', 
  deposit_same_ean_fg AS 'DEPOSIT_SAME_EAN_FG', 
  deposit_only_manual_input_fg AS 'DEPOSIT_ONLY_MANUAL_INPUT_FG', 
  price_info_mult_fg AS 'PRICE_INFO_MULT_FG', 
  price_info_and_small_sale_fg AS 'PRICE_INFO_AND_SMALL_SALE_FG', 
  price_info_and_logoff_fg AS 'PRICE_INFO_AND_LOGOFF_FG', 
  return_without_auth_fg AS 'RETURN_WITHOUT_AUTH_FG', 
  return_same_receipt_fg AS 'RETURN_SAME_RECEIPT_FG', 
  return_same_prod_fg AS 'RETURN_SAME_PROD_FG', 
  return_not_on_receipt_fg AS 'RETURN_NOT_ON_RECEIPT_FG', 
  return_qty_invalid_fg AS 'RETURN_QTY_INVALID_FG',
  return_at_higher_than_sales_price_fg AS 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG',
  return_at_higher_than_official_price_fg AS 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG',
  return_same_cashier_and_day_fg AS 'RETURN_SAME_CASHIER_AND_DAY_FG', 
  return_without_receipt_ke_input_fg AS 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG', 
  return_mult_prod_fg AS 'RETURN_MULT_PROD_FG', 
  suspend_and_abort_fg AS 'SUSPEND_AND_ABORT_FG', 
  suspend_and_line_cancel_fg AS 'SUSPEND_AND_LINE_CANCEL_FG', 
  suspend_and_extend_fg AS 'SUSPEND_AND_EXTEND_FG', 
  suspend_unresolved_and_logoff_fg AS 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG',
  suspend_unresolved_and_sale_fg AS 'SUSPEND_UNRESOLVED_AND_SALE_FG', 
  abort_and_sale_fg AS 'ABORT_AND_SALE_FG',
  abort_and_logoff_fg AS 'ABORT_AND_LOGOFF_FG', 
  cancel_last_pos_fg AS 'CANCEL_LAST_POS_FG', 
  cancel_in_favour_fg AS 'CANCEL_IN_FAVOUR_FG', 
  

  
  return_same_cashier_and_day_manual_fg AS 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG', 
  return_same_cashier_and_day_without_auth_fg AS 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG', 
  return_same_cashier_and_day_cash_paym_fg AS 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG', 
  return_same_cashier_and_day_card_paym_fg AS 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG', 
  return_same_cashier_diff_day_fg AS 'RETURN_SAME_CASHIER_DIFF_DAY_FG', 
  return_same_cashier_and_day_display_sel_fg AS 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG', 
  return_without_receipt_dv_input_fg AS 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG',
  return_without_receipt_fg AS 'RETURN_WITHOUT_RECEIPT_FG', 
  return_mult_prod_full_qty_fg AS 'RETURN_MULT_PROD_FULL_QTY_FG', 
  cancel_last_pos_exact_paym_fg AS 'CANCEL_LAST_POS_EXACT_PAYM_FG',
  cancel_last_pos_after_subtotal_fg AS 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG', 
  cancel_last_pos_alcohol_tobacco_fg AS 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG', 
  cancel_last_pos_highest_pos_fg AS 'CANCEL_LAST_POS_HIGHEST_POS_FG',
  cancel_last_pos_outside_opening_hr_fg AS 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG', 
  cancel_last_and_other_pos_fg AS 'CANCEL_LAST_AND_OTHER_POS_FG', 
  cancel_in_favour_exact_paym_fg AS 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG',
  cancel_in_favour_after_subtotal_fg AS 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG', 
  cancel_in_favour_manual_discount_fg AS 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG', 
  cancel_in_favour_without_auth_fg AS 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG',
  cancel_in_favour_alcohol_tobacco_fg AS 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG', 
  cancel_in_favour_outside_opening_hr_fg AS 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG', 
  cancel_in_favour_lidl_plus_fg AS 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG'
)))
     AS t21
     INNER JOIN CTE_STORES_IN_RV AS STORES ON t21.bus_dt BETWEEN STORES.from_bus_dt AND STORES.until_bus_dt AND t21.store_sid
        = STORES.store_sid
     INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER0 ON t21.curr_cd = FER0.tgt_curr_cd
    WHERE FER0.exchange_rate_type_cd = 'BEW_ISK'
     AND (FER0.src_curr_cd = 'EUR' OR FER0.src_curr_cd = FER0.tgt_curr_cd)
     AND FER0.active_fg
     AND t21.flag_value
    GROUP BY t21.bus_dt,
     dm__operand,
     STORES.country_org_cd,
     STORES.store_sid,
     curr_cd,
     scenario_id,
     curr_group_fg,
     curr_local_fg) AS t26) (SELECT *
  FROM (SELECT MAIN.store_sid,
      MAIN.bus_dt,
      MAIN.event_end_hr,
      MAIN.cashier_nr,
      MAIN.scenario_id,
      MAIN.country_org_cd,
      M.metric_id,
      M.calculation_type_cd,
      MAIN.cash_register_event_affected_net_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      MAIN.curr_cd,
      MAIN.curr_group_fg,
      MAIN.curr_local_fg
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S ON MAIN.scenario_id = S.scenario_id
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS M ON S.scenario_id = M.scenario_id
     WHERE S.scenario_type_cd = 'AUTO'
      AND M.calculation_type_cd = 'SUM'
      AND MOD(CAST(M.metric_id AS BIGNUMERIC), 100) = 10
     UNION ALL
     SELECT store_sid,
      bus_dt,
      event_end_hr,
      cashier_nr,
      - 1 AS scenario_id,
      country_org_cd,
      - 100 AS metric_id,
      'SUM' AS calculation_type_cd,
       sales_net_val - return_net_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      curr_cd,
      curr_group_fg,
      curr_local_fg
     FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
     WHERE sales_net_val - return_net_val <> 0
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE_FACT.bus_dt,
      STORE_FACT.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
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
        M.metric_id,
        M.calculation_type_cd
       FROM CTE_CASHIER_SCENARIO AS FACT
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S ON FACT.scenario_id = S.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS M ON S.scenario_id = M.scenario_id
         
       WHERE S.scenario_type_cd = 'AUTO'
        AND M.calculation_type_cd = 'LEVELAVG') AS CASHIER
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.bus_dt,
        MAIN.scenario_id,
        MAIN.event_end_hr,
        MAIN.country_org_cd,
        M0.metric_id,
        SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg
       FROM CTE_STORES_AGG_VALUES AS MAIN
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S0 ON MAIN.scenario_id = S0.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS M0 ON S0.scenario_id = M0.scenario_id
         
       WHERE S0.scenario_type_cd = 'AUTO'
        AND M0.calculation_type_cd = 'LEVELAVG'
       GROUP BY MAIN.bus_dt,
        MAIN.event_end_hr,
        MAIN.country_org_cd,
        MAIN.store_sid,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg,
        MAIN.scenario_id,
        M0.metric_id) AS STORE_FACT ON CASHIER.store_sid = STORE_FACT.store_sid AND CASHIER.metric_id = STORE_FACT.metric_id
        
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.cashier_nr,
        MAIN.bus_dt,
        MAIN.event_end_hr,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        M1.metric_id,
        MAIN.cash_register_event_cnt,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S1 ON MAIN.scenario_id = S1.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS M1 ON S1.scenario_id = M1.scenario_id
         
       WHERE S1.scenario_type_cd = 'AUTO'
        AND M1.calculation_type_cd = 'LEVELAVG') AS CASHIER_FACT ON CASHIER.cashier_nr = CASHIER_FACT.cashier_nr AND
            STORE_FACT.store_sid = CASHIER_FACT.store_sid AND STORE_FACT.metric_id = CASHIER_FACT.metric_id AND
          STORE_FACT.bus_dt = CASHIER_FACT.bus_dt AND STORE_FACT.curr_cd = CASHIER_FACT.curr_cd AND STORE_FACT.event_end_hr
         = CASHIER_FACT.event_end_hr
     UNION ALL
     SELECT MAIN.store_sid,
      MAIN.bus_dt,
      MAIN.event_end_hr,
      MAIN.cashier_nr,
      MAIN.scenario_id,
      MAIN.country_org_cd,
      M.metric_id,
      M.calculation_type_cd,
       CASE
       WHEN M.metric_id IN (2100, 2200, 3200)
       THEN MAIN.cash_register_event_affected_net_val
       WHEN M.metric_id = 4005
       THEN CAST(MAIN.cust_sid_dst_cnt AS BIGNUMERIC)
       WHEN MOD(CAST(M.metric_id AS BIGNUMERIC), 100) = 15
       THEN 1
       ELSE MAIN.cash_register_event_cnt
       END AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      MAIN.curr_cd,
      MAIN.curr_group_fg,
      MAIN.curr_local_fg
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS S ON MAIN.scenario_id = S.scenario_id
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS M ON S.scenario_id = M.scenario_id
     WHERE S.scenario_type_cd = 'AUTO' AND M.calculation_type_cd = 'SUM' AND MOD(CAST(M.metric_id AS BIGNUMERIC), 100)
        <> 10
      OR M.metric_id IN (2100, 2200, 2500, 2600, 2700, 3000, 3100, 3200, 3300, 3600, 3700, 3800, 4000, 4005, 4100, 4200
        )
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3110 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.suspended_unresolved_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE suspended_unresolved_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 31
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3120 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.suspended_unresolved_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE suspended_unresolved_cnt > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 31
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3210 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.abort_net_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_net_val) AS abort_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE abort_net_val > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 32
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3220 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.abort_net_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_net_val) AS abort_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE abort_net_val > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 32
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3310 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.abort_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_cnt) AS abort_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE abort_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 33
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3320 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.abort_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_cnt) AS abort_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE abort_cnt > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 33
     UNION ALL
     SELECT DIM.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      3400 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.cancelled_line_cnt * 100 AS scenario_value_1,
      CAST(CSH.event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        cashier_nr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE event_line_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        cashier_nr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CSH ON DIM.store_sid = CSH.store_sid AND DIM.cashier_nr = CSH.cashier_nr
     WHERE DIM.scenario_id = 34
     UNION ALL
     SELECT DIM.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      3410 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.cancelled_line_cnt * 100 AS scenario_value_1,
      CAST(CSH.event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE event_line_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CSH ON DIM.store_sid = CSH.store_sid
     WHERE DIM.scenario_id = 34
     UNION ALL
     SELECT DIM.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      3420 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.cancelled_line_cnt * 100 AS scenario_value_1,
      CAST(CSH.event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE event_line_cnt > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CSH ON DIM.sales_company_sid = CSH.sales_company_sid
     WHERE DIM.scenario_id = 34
     UNION ALL
     SELECT CSH.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      CSH.cashier_nr,
      CL.scenario_id,
      CL.country_org_cd,
      3500 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.cancelled_net_val * 100 AS scenario_value_1,
      CAST(CSH.sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CL
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CSH ON CL.store_sid = CSH.store_sid AND CL.cashier_nr = CSH.cashier_nr
        
     WHERE CL.scenario_id = 35
     UNION ALL
     SELECT DIM.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      3510 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.cancelled_net_val * 100 AS scenario_value_1,
      CAST(CSH.sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_net_val) AS cancelled_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE sales_net_val <> 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CSH ON DIM.store_sid = CSH.store_sid
     WHERE DIM.scenario_id = 35
     UNION ALL
     SELECT DIM.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      3520 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.cancelled_net_val * 100 AS scenario_value_1,
      CAST(CSH.sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_net_val) AS cancelled_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE sales_net_val <> 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CSH ON DIM.sales_company_sid = CSH.sales_company_sid
     WHERE DIM.scenario_id = 35
     UNION ALL
     SELECT CSH.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      CSH.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      2900 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.return_net_val * 100 AS scenario_value_1,
      CAST(CSH.sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CSH ON DIM.store_sid = CSH.store_sid AND DIM.cashier_nr = CSH.cashier_nr
        
     WHERE DIM.scenario_id = 29
     UNION ALL
     SELECT DIM.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      2910 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CAST(CSH.return_net_val AS BIGNUMERIC) * 100 AS scenario_value_1,
      CAST(CSH.sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_net_val) AS return_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE sales_net_val <> 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CSH ON DIM.store_sid = CSH.store_sid
     WHERE DIM.scenario_id = 29
     UNION ALL
     SELECT DIM.store_sid,
      CSH.bus_dt,
      CSH.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      2920 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       CSH.return_net_val * 100 AS scenario_value_1,
      CAST(CSH.sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_net_val) AS return_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE sales_net_val <> 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CSH ON DIM.sales_company_sid = CSH.sales_company_sid
     WHERE DIM.scenario_id = 29
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2610 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.return_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_cnt) AS return_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE return_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 26
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2620 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.return_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_cnt) AS return_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE return_cnt > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 26
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2710 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.cash_register_event_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
       WHERE scenario_id = 27
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 27
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2720 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.cash_register_event_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
       WHERE scenario_id = 27
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 27
     UNION ALL
     SELECT store_sid,
      bus_dt,
      event_end_hr,
      cashier_nr,
      scenario_id,
      country_org_cd,
      2800 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      cash_register_event_affected_net_val AS scenario_value_1,
      CAST(cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      curr_cd,
      curr_group_fg,
      curr_local_fg
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL
     WHERE scenario_id = 28
     UNION ALL
     SELECT DIM.store_sid,
      CL.bus_dt,
      CL.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      2810 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      CL.cash_register_event_affected_net_val AS scenario_value_1,
      CAST(CL.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT store_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL
       WHERE scenario_id = 28
       GROUP BY store_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CL ON DIM.store_sid = CL.store_sid
     WHERE DIM.scenario_id = 28
     UNION ALL
     SELECT DIM.store_sid,
      CL.bus_dt,
      CL.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      2820 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      CL.cash_register_event_affected_net_val AS scenario_value_1,
      CAST(CL.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT sales_company_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL
       WHERE scenario_id = 28
       GROUP BY sales_company_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CL ON DIM.sales_company_sid = CL.sales_company_sid
     WHERE DIM.scenario_id = 28
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3010 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.return_without_receipt_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE return_without_receipt_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 30
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3020 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.return_without_receipt_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE return_without_receipt_cnt > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 30
     UNION ALL
     SELECT store_sid,
      bus_dt,
      event_end_hr,
      cashier_nr,
      scenario_id,
      country_org_cd,
      2400 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       cash_register_event_cnt / 2 AS scenario_value_1,
      1 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      curr_cd,
      curr_group_fg,
      curr_local_fg
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
     WHERE scenario_id = 24
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2110 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.deposit_only_return_net_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_only_return_net_val) AS deposit_only_return_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE deposit_only_return_net_val > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 21
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2120 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.deposit_only_return_net_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_only_return_net_val) AS deposit_only_return_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE deposit_only_return_net_val > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 21
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2210 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.deposit_return_manual_input_gross_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE deposit_return_manual_input_gross_val > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 22
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      2220 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.deposit_return_manual_input_gross_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE deposit_return_manual_input_gross_val > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 22
     UNION ALL
     SELECT CL.store_sid,
      FACT.bus_dt,
      FACT.event_end_hr,
      CL.cashier_nr,
      CL.scenario_id,
      CL.country_org_cd,
      2300 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      FACT.deposit_return_net_val AS scenario_value_1,
      FACT.deposit_sales_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      FACT.curr_cd,
      FACT.curr_group_fg,
      FACT.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CL
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT ON CL.cashier_nr = FACT.cashier_nr AND CL.store_sid = FACT
        .store_sid
     WHERE CL.scenario_id = 23
     UNION ALL
     SELECT DIM.store_sid,
      CL.bus_dt,
      CL.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      2310 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      CL.deposit_return_net_val AS scenario_value_1,
      CAST(CL.deposit_sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_net_val) AS deposit_return_net_val,
        SUM(deposit_sales_net_val) AS deposit_sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CL ON DIM.store_sid = CL.store_sid
     WHERE DIM.scenario_id = 23
     UNION ALL
     SELECT DIM.store_sid,
      CL.bus_dt,
      CL.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      2320 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      CL.deposit_return_net_val AS scenario_value_1,
      CAST(CL.deposit_sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_net_val) AS deposit_return_net_val,
        SUM(deposit_sales_net_val) AS deposit_sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS CL ON DIM.sales_company_sid = CL.sales_company_sid
     WHERE DIM.scenario_id = 23
     UNION ALL
     SELECT DIM.store_sid,
      CL.bus_dt,
      CL.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      420 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      DIM.cash_register_event_affected_net_val AS scenario_value_1,
      CL.deposit_return_manual_input_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      DIM.curr_cd,
      DIM.curr_group_fg,
      DIM.curr_local_fg
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS DIM
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL ON DIM.store_sid = CL.store_sid AND DIM.cashier_nr = CL.cashier_nr
            AND DIM.bus_dt = CL.bus_dt AND DIM.curr_cd = CL.curr_cd AND DIM.event_end_hr = CL.event_end_hr
     WHERE DIM.scenario_id = 4
     UNION ALL
     SELECT DIM.store_sid,
      CL.bus_dt,
      CL.event_end_hr,
      DIM.cashier_nr,
      DIM.scenario_id,
      DIM.country_org_cd,
      430 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
      DIM.cash_register_event_affected_net_val AS scenario_value_1,
      CL.deposit_only_return_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      DIM.curr_cd,
      DIM.curr_group_fg,
      DIM.curr_local_fg
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS DIM
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL ON DIM.store_sid = CL.store_sid AND DIM.cashier_nr = CL.cashier_nr
            AND DIM.bus_dt = CL.bus_dt AND DIM.curr_cd = CL.curr_cd AND DIM.event_end_hr = CL.event_end_hr
     WHERE DIM.scenario_id = 4
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3610 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.price_info_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(price_info_cnt) AS price_info_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE price_info_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 36
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3620 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.price_info_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(price_info_cnt) AS price_info_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE price_info_cnt > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 36
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3810 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.discount_line_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_line_cnt) AS discount_line_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE discount_line_cnt > 0
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 38
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3820 AS metric_id,
      'SUM' AS calculation_type_cd,
      STORE.discount_line_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_line_cnt) AS discount_line_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       WHERE discount_line_cnt > 0
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 38
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3910 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       STORE.discount_net_val * 100 AS scenario_value_1,
      STORE.total_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_net_val) AS discount_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 39
     UNION ALL
     SELECT CASHIER.store_sid,
      STORE.bus_dt,
      STORE.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3920 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       STORE.discount_net_val * 100 AS scenario_value_1,
      STORE.total_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      STORE.curr_cd,
      STORE.curr_group_fg,
      STORE.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_net_val) AS discount_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 39
     UNION ALL
     SELECT CASHIER.store_sid,
      FACT.bus_dt,
      FACT.event_end_hr,
      CASHIER.cashier_nr,
      CASHIER.scenario_id,
      CASHIER.country_org_cd,
      3900 AS metric_id,
      'SMARTAVG' AS calculation_type_cd,
       FACT.discount_net_val * 100 AS scenario_value_1,
       FACT.sales_net_val - FACT.return_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      FACT.curr_cd,
      FACT.curr_group_fg,
      FACT.curr_local_fg
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT ON CASHIER.store_sid = FACT.store_sid AND CASHIER.cashier_nr
         = FACT.cashier_nr
     WHERE CASHIER.scenario_id = 39
     UNION ALL
     SELECT CLS.store_sid,
      CLR.rel_bus_dt,
      CLS.event_end_hr,
      CLS.cashier_nr,
      CLS.scenario_id,
      CLS.country_org_cd,
      820 AS metric_id,
      'SUM' AS calculation_type_cd,
      COUNT(DISTINCT CLR.rel_cash_register_event_sid) AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      FER.src_curr_cd AS curr_cd,
      MAX(CASE
        WHEN FER.src_curr_cd = 'EUR'
        THEN 1
        ELSE 0
        END) AS curr_group_fg,
      MAX(CASE
        WHEN FER.src_curr_cd = FER.tgt_curr_cd
        THEN 1
        ELSE 0
        END) AS curr_local_fg
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification AS CLS
      INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_relationship AS CLR ON CLS.bus_dt = CLR.bus_dt
        AND CLS.country_org_cd = CLR.country_org_cd AND CLS.cash_register_event_sid = CLR.cash_register_event_sid
      INNER JOIN ldl_data_core_dim.t_dim_country AS CT ON CLS.country_org_cd = CT.iso_country_cd
      INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER ON CT.curr_cd = FER.tgt_curr_cd
     WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
      AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
      AND FER.active_fg
      AND CLS.scenario_id = 8
      AND CLR.cash_register_event_rel_type_cd = 'ORIGINAL'
     GROUP BY CLS.store_sid,
      CLS.event_end_hr,
      CLR.rel_bus_dt,
      CLS.cashier_nr,
      CLS.scenario_id,
      CLS.country_org_cd,
      curr_cd));

