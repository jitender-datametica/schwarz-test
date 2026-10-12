CREATE OR REPLACE VIEW ldl_data_core_app_fraud_detection.v_mat_fraud_detection_metric_by_cashier_hour_2 (store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED CASH REGISTER EVENT HAPPENED.'),
cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
bus_dt OPTIONS(description='THE BUSINESS DATE ON WHICH THE RETAIL EVENT IS COUNTED.'), hr
OPTIONS(description='THE HOUR OF THE DAY OF WHICH THE METRICS ARE CALCULATED'), metric_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF MICROSTRATEY METRIC'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY_2 FOR WHICH THIS COUNTRY_2 ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY_2 IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
curr_cd OPTIONS(description='THE CURRENCY CODE FOR THE METRIC VALUES'), metric_val_1
OPTIONS(description='THE FIRST VALUE TO CALCULATE DEFINED BY MICROSTRATEGY METRIC'), metric_val_2
OPTIONS(description='THE SECOND VALUE TO CALCULATE DEFINED BY MICROSTRATEGY METRIC'), metric_val_3
OPTIONS(description='THE THIRD VALUE TO CALCULATE DEFINED BY MICROSTRATEGY METRIC'), metric_val_4
OPTIONS(description='THE FOURTH VALUE TO CALCULATE DEFINED BY MICROSTRATEGY METRIC'))
OPTIONS(DESCRIPTION = `THIS VIEW BRINGS THE VALUES IN A NORMALIZED FORM TO CALCULATE THE METRICS, WHICH WILL BE USED FOR DYNAMIC DASHBOARD`)
AS WITH CTE_STORE_SCENARIO_GROUPS AS (SELECT int_org_sid AS store_sid,
    CASE
    WHEN scenario_group = 'ABORT_SCENARIO_GRP_SUSPEND_FG'
    THEN 1
    WHEN scenario_group = 'RETURN_SCENARIO_GRP_FG'
    THEN 2
    WHEN scenario_group = 'DEPOSIT_SCENARIO_GRP_FG'
    THEN 3
    WHEN scenario_group = 'DISCOUNT_SCENARIO_GRP_FG'
    THEN 4
    WHEN scenario_group = 'CANCEL_SCENARIO_GRP_FG'
    THEN 5
    WHEN scenario_group = 'OTHER_SCENARIO_GRP_FG'
    THEN 6
    ELSE 0
    END AS scenario_grp_id,
   CAST(CASE
     WHEN scenario_group = 'ABORT_SCENARIO_GRP_SUSPEND_FG'
     THEN abort_scenario_grp_suspend_fg
     WHEN scenario_group = 'CANCEL_SCENARIO_GRP_FG'
     THEN cancel_scenario_grp_fg
     WHEN scenario_group = 'DEPOSIT_SCENARIO_GRP_FG'
     THEN deposit_scenario_grp_fg
     WHEN scenario_group = 'DISCOUNT_SCENARIO_GRP_FG'
     THEN discount_scenario_grp_fg
     WHEN scenario_group = 'OTHER_SCENARIO_GRP_FG'
     THEN other_scenario_grp_fg
     WHEN scenario_group = 'RETURN_SCENARIO_GRP_FG'
     THEN return_scenario_grp_fg
     ELSE NULL
     END AS BOOL) AS mat_flag
  FROM (SELECT *
    FROM ldl_data_core_app_fraud_detection.t_fraud_detection_order_2 AS MAIN0
     INNER JOIN (SELECT 'ABORT_SCENARIO_GRP_SUSPEND_FG' AS scenario_group
       UNION ALL
       SELECT 'CANCEL_SCENARIO_GRP_FG' AS scenario_group
       UNION ALL
       SELECT 'DEPOSIT_SCENARIO_GRP_FG' AS scenario_group
       UNION ALL
       SELECT 'DISCOUNT_SCENARIO_GRP_FG' AS scenario_group
       UNION ALL
       SELECT 'OTHER_SCENARIO_GRP_FG' AS scenario_group
       UNION ALL
       SELECT 'RETURN_SCENARIO_GRP_FG' AS scenario_group) AS t ON TRUE
    WHERE CASE
      WHEN t.scenario_group = 'ABORT_SCENARIO_GRP_SUSPEND_FG'
      THEN MAIN0.abort_scenario_grp_suspend_fg
      WHEN t.scenario_group = 'CANCEL_SCENARIO_GRP_FG'
      THEN MAIN0.cancel_scenario_grp_fg
      WHEN t.scenario_group = 'DEPOSIT_SCENARIO_GRP_FG'
      THEN MAIN0.deposit_scenario_grp_fg
      WHEN t.scenario_group = 'DISCOUNT_SCENARIO_GRP_FG'
      THEN MAIN0.discount_scenario_grp_fg
      WHEN t.scenario_group = 'OTHER_SCENARIO_GRP_FG'
      THEN MAIN0.other_scenario_grp_fg
      WHEN t.scenario_group = 'RETURN_SCENARIO_GRP_FG'
      THEN MAIN0.return_scenario_grp_fg
      ELSE NULL
      END IS NOT NULL) AS t0
  WHERE t0.int_org_type_cd = 'STORE'
   AND t0.order_parameter_status_cd IN ('LO', 'MT', 'RV')), CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS (SELECT MAIN.country_org_cd
   ,
   STORE.sales_company_sid,
   MAIN.store_sid,
   MAIN.cashier_nr,
   MAIN.scenario_id,
   MAIN.bus_dt,
   MAIN.event_end_hr,
   CT.curr_cd,
   SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
   SUM(MAIN.cash_register_event_affected_line_cnt) AS cash_register_event_affected_line_cnt,
   SUM(MAIN.cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
   SUM(MAIN.cash_register_event_affected_gross_val) AS cash_register_event_affected_gross_val,
   COUNT(DISTINCT MAIN.cust_sid) AS cust_sid_dst_cnt,
   SUM(1) AS cash_register_entry_cnt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_2 AS MAIN
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_2 AS STORE ON MAIN.store_sid = STORE.int_org_sid AND STORE.dwh_valid_fg
    
   INNER JOIN ldl_data_core_dim.t_dim_country_2 AS CT ON MAIN.country_org_cd = CT.iso_country_cd
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS SC_GRP ON MAIN.scenario_id = SC_GRP.scenario_id
    
   LEFT JOIN CTE_STORE_SCENARIO_GROUPS AS ST_SC_GRP ON MAIN.store_sid = ST_SC_GRP.store_sid AND SC_GRP.scenario_grp_id =
     ST_SC_GRP.scenario_grp_id
  WHERE ST_SC_GRP.mat_flag IS NULL
   OR ST_SC_GRP.mat_flag
  GROUP BY MAIN.country_org_cd,
   STORE.sales_company_sid,
   MAIN.store_sid,
   MAIN.cashier_nr,
   MAIN.scenario_id,
   MAIN.bus_dt,
   MAIN.event_end_hr,
   CT.curr_cd), CTE_STATISTICS_BY_STORE_DAY_CASHIER AS (SELECT ORG.country_org_cd,
   ORG.sales_company_sid,
   MAIN.int_org_sid AS store_sid,
   MAIN.bus_dt,
   MAIN.event_end_hr,
   MAIN.cashier_nr,
   CT.curr_cd,
   MAIN.sales_net_val,
   MAIN.return_net_val,
   MAIN.event_cnt,
   MAIN.event_line_cnt,
   MAIN.return_cnt,
   MAIN.cancelled_line_cnt,
   MAIN.cancelled_net_val,
   MAIN.discount_line_cnt,
   MAIN.discount_net_val,
   MAIN.abort_cnt,
   MAIN.abort_net_val,
   MAIN.suspended_unresolved_cnt,
   MAIN.suspended_unresolved_net_val,
   MAIN.price_info_cnt,
   MAIN.return_without_receipt_cnt,
   MAIN.return_without_receipt_net_val,
   MAIN.deposit_sales_net_val,
   MAIN.deposit_return_net_val,
   MAIN.deposit_return_manual_input_net_val,
   MAIN.deposit_return_manual_input_gross_val,
   MAIN.deposit_only_return_net_val,
   MAIN.small_sales_cnt,
   MAIN.login_cnt,
   MAIN.logoff_cnt,
   MAIN.is_outlier_day_return_fg,
   MAIN.sales_outside_work_hr_net_val,
   MAIN.return_outside_work_hr_net_val,
   MAIN.sales_outside_work_hr_cnt,
   MAIN.return_outside_work_hr_cnt
  FROM ldl_data_core_app_fraud_detection.t_statistics_by_store_hour_cashier_2 AS MAIN
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_2 AS ORG ON MAIN.int_org_sid = ORG.int_org_sid AND ORG.dwh_valid_fg
    
   INNER JOIN ldl_data_core_dim.t_dim_country_2 AS CT ON ORG.country_org_cd = CT.iso_country_cd
  WHERE MAIN.sales_net_val - MAIN.return_net_val <> 0), CTE_CASHIER_SCENARIO AS (SELECT FACT.country_org_cd,
   FACT.sales_company_sid,
   FACT.store_sid,
   FACT.cashier_nr,
   FACT.scenario_id,
    ((MAX(SC.scenario_type_cd) IN ('AUTO', 'GEN') OR FACT.scenario_id = 4000)) IS TRUE OR COALESCE(MAX(RNK.relevant_for_manual_report_fg
       ), FALSE) AND ((MAX(SC.scenario_type_cd) IN ('AUTO', 'GEN') OR FACT.scenario_id = 4000)) IS NOT TRUE AS
   relevant_for_report_fg
  FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS SC ON FACT.scenario_id = SC.scenario_id
   LEFT JOIN ldl_data_core_app_fraud_detection.t_cashier_ranking_by_fraud_scenario_2 AS RNK ON FACT.cashier_nr = RNK.cashier_nr
       AND FACT.store_sid = RNK.store_sid AND FACT.scenario_id = RNK.scenario_id
  GROUP BY FACT.country_org_cd,
   FACT.sales_company_sid,
   FACT.store_sid,
   FACT.cashier_nr,
   FACT.scenario_id), CTE_STORES_IN_RV AS (SELECT ORG.country_org_cd,
   ORG.int_org_sid AS store_sid,
   ORD.analysis_period_start_dt AS from_bus_dt,
   ORD.analysis_period_end_dt AS until_bus_dt
  FROM ldl_data_core_dim.t_dim_internal_organization_2 AS ORG
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_order_2 AS ORD ON ORG.int_org_sid = ORD.int_org_sid OR
     ORG.sales_company_sid = ORD.int_org_sid
  WHERE ORG.dwh_valid_fg
   AND ORD.order_parameter_status_cd NOT IN ('RM', 'END')), CTE_STORES_AGG_VALUES AS (SELECT t35.bus_dt,
   EXTRACT(HOUR FROM t35.event_end_tmsp) AS event_end_hr,
   STORES.country_org_cd,
   STORES.store_sid,
   t35.curr_cd,
    CASE
    WHEN t35.flag_name = 'DEPOSIT_AND_ONE_PROD_FG'
    THEN 1
    WHEN t35.flag_name = 'DEPOSIT_SAME_EAN_FG'
    THEN 2
    WHEN t35.flag_name = 'DEPOSIT_ONLY_MANUAL_INPUT_FG'
    THEN 4
    WHEN t35.flag_name = 'PRICE_INFO_MULT_FG'
    THEN 5
    WHEN t35.flag_name = 'RETURN_WITHOUT_AUTH_FG'
    THEN 7
    WHEN t35.flag_name = 'RETURN_SAME_RECEIPT_FG'
    THEN 8
    WHEN t35.flag_name = 'RETURN_SAME_PROD_FG'
    THEN 9
    WHEN t35.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG'
    THEN 11
    WHEN t35.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG'
    THEN 12
    WHEN t35.flag_name = 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG'
    THEN 13
    WHEN t35.flag_name = 'RETURN_MULT_PROD_FG'
    THEN 14
    WHEN t35.flag_name = 'SUSPEND_AND_ABORT_FG'
    THEN 150100
    WHEN t35.flag_name = 'SUSPEND_AND_EXTEND_FG'
    THEN 150200
    WHEN t35.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG'
    THEN 150300
    WHEN t35.flag_name = 'SUSPEND_AND_ABORT_FG' OR t35.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG'
    THEN 15
    WHEN t35.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
    THEN 160100
    WHEN t35.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG'
    THEN 160200
    WHEN t35.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' OR t35.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
    THEN 16
    WHEN t35.flag_name = 'CANCEL_LAST_POS_FG'
    THEN 18
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_FG'
    THEN 19
    WHEN t35.flag_name = 'DEPOSIT_SAME_VAL_SCAN_FG'
    THEN 75
    WHEN t35.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG'
    THEN 60100
    WHEN t35.flag_name = 'PRICE_INFO_AND_LOGOFF_FG'
    THEN 60200
    WHEN t35.flag_name = 'RETURN_NOT_ON_RECEIPT_FG'
    THEN 100100
    WHEN t35.flag_name = 'RETURN_QTY_INVALID_FG'
    THEN 100200
    WHEN t35.flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG'
    THEN 110100
    WHEN t35.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG'
    THEN 110200
    WHEN t35.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG'
    THEN 120100
    WHEN t35.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG'
    THEN 120200
    WHEN t35.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG'
    THEN 120300
    WHEN t35.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG'
    THEN 120400
    WHEN t35.flag_name = 'RETURN_SAME_CASHIER_DIFF_DAY_FG'
    THEN 120600
    WHEN t35.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG'
    THEN 120700
    WHEN t35.flag_name = 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG'
    THEN 130100
    WHEN t35.flag_name = 'RETURN_WITHOUT_RECEIPT_FG'
    THEN 130200
    WHEN t35.flag_name = 'RETURN_MULT_PROD_FULL_QTY_FG'
    THEN 140100
    WHEN t35.flag_name = 'ABORT_AND_SALE_FG'
    THEN 170100
    WHEN t35.flag_name = 'ABORT_AND_LOGOFF_FG'
    THEN 170200
    WHEN t35.flag_name = 'CANCEL_LAST_POS_EXACT_PAYM_FG'
    THEN 180100
    WHEN t35.flag_name = 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG'
    THEN 180200
    WHEN t35.flag_name = 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG'
    THEN 180300
    WHEN t35.flag_name = 'CANCEL_LAST_POS_HIGHEST_POS_FG'
    THEN 180400
    WHEN t35.flag_name = 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG'
    THEN 180500
    WHEN t35.flag_name = 'CANCEL_LAST_AND_OTHER_POS_FG'
    THEN 180600
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG'
    THEN 190100
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG'
    THEN 190200
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG'
    THEN 190300
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG'
    THEN 190400
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG'
    THEN 190600
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG'
    THEN 190700
    WHEN t35.flag_name = 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG'
    THEN 190800
    ELSE - 1
    END AS scenario_id,
   SUM(1) AS cash_register_event_cnt
  FROM (SELECT FACT.cash_register_event_sid,
     FACT.cash_register_event_nr,
     FACT.event_start_tmsp,
     FACT.event_end_tmsp,
     FACT.bus_dt,
     FACT.cash_register_sid,
     FACT.cash_register_nr,
     FACT.store_sid,
     FACT.cashier_hash,
     FACT.cust_sid,
     FACT.cust_ident_type_cd,
     FACT.txn_net_val,
     FACT.txn_gross_val,
     FACT.cancel_last_pos_gross_val,
     FACT.cancel_in_favour_gross_val,
     FACT.deposit_same_ean_gross_val,
     FACT.curr_cd,
     FACT.cancel_last_pos_line_cnt,
     FACT.cancel_in_favour_line_cnt,
     FACT.deposit_same_ean_line_cnt,
     FACT.cancel_last_pos_single_pos_fg,
     FACT.cancel_last_pos_without_auth_fg,
     FACT.cancel_in_favour_highest_pos_fg,
     FACT.cancel_in_favour_single_pos_fg,
     FACT.return_mult_prod_same_cashier_fg,
     FACT.return_same_receipt_full_qty_fg,
     FACT.return_same_receipt_same_cashier_fg,
     FACT.return_same_cashier_fg,
     FACT.deposit_same_val_man_fg,
     FACT.small_sale_fg,
     FACT.event_outside_exact_opening_hr_fg,
     FACT.receipt_outside_opening_hr_fg,
     FACT.receipt_outside_opening_hr_cancel_fg,
     FACT.receipt_outside_opening_hr_return_fg,
     FACT.receipt_outside_opening_hr_suspend_fg,
     FACT.receipt_outside_opening_hr_abort_fg,
     FACT.receipt_outside_opening_hr_deposit_only_fg,
     FACT.receipt_outside_opening_hr_manual_deposit_fg,
     FACT.receipt_outside_opening_hr_manual_discount_fg,
     FACT.dwh_created_tmsp,
     FACT.dwh_updated_tmsp,
     FACT.dwh_load_id,
     FACT.dwh_node_cd,
     t32.flag_name,
     CAST(CASE
       WHEN t32.flag_name = 'DEPOSIT_AND_ONE_PROD_FG'
       THEN FACT.deposit_and_one_prod_fg
       WHEN t32.flag_name = 'DEPOSIT_SAME_EAN_FG'
       THEN FACT.deposit_same_ean_fg
       WHEN t32.flag_name = 'DEPOSIT_ONLY_MANUAL_INPUT_FG'
       THEN FACT.deposit_only_manual_input_fg
       WHEN t32.flag_name = 'PRICE_INFO_MULT_FG'
       THEN FACT.price_info_mult_fg
       WHEN t32.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG'
       THEN FACT.price_info_and_small_sale_fg
       WHEN t32.flag_name = 'PRICE_INFO_AND_LOGOFF_FG'
       THEN FACT.price_info_and_logoff_fg
       WHEN t32.flag_name = 'RETURN_WITHOUT_AUTH_FG'
       THEN FACT.return_without_auth_fg
       WHEN t32.flag_name = 'RETURN_SAME_RECEIPT_FG'
       THEN FACT.return_same_receipt_fg
       WHEN t32.flag_name = 'RETURN_SAME_PROD_FG'
       THEN FACT.return_same_prod_fg
       WHEN t32.flag_name = 'RETURN_NOT_ON_RECEIPT_FG'
       THEN FACT.return_not_on_receipt_fg
       WHEN t32.flag_name = 'RETURN_QTY_INVALID_FG'
       THEN FACT.return_qty_invalid_fg
       WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG'
       THEN FACT.return_at_higher_than_sales_price_fg
       WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG'
       THEN FACT.return_at_higher_than_official_price_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG'
       THEN FACT.return_same_cashier_and_day_fg
       WHEN t32.flag_name = 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG'
       THEN FACT.return_without_receipt_ke_input_fg
       WHEN t32.flag_name = 'RETURN_MULT_PROD_FG'
       THEN FACT.return_mult_prod_fg
       WHEN t32.flag_name = 'SUSPEND_AND_ABORT_FG'
       THEN FACT.suspend_and_abort_fg
       WHEN t32.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG'
       THEN FACT.suspend_and_line_cancel_fg
       WHEN t32.flag_name = 'SUSPEND_AND_EXTEND_FG'
       THEN FACT.suspend_and_extend_fg
       WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG'
       THEN FACT.suspend_unresolved_and_logoff_fg
       WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
       THEN FACT.suspend_unresolved_and_sale_fg
       WHEN t32.flag_name = 'ABORT_AND_SALE_FG'
       THEN FACT.abort_and_sale_fg
       WHEN t32.flag_name = 'ABORT_AND_LOGOFF_FG'
       THEN FACT.abort_and_logoff_fg
       WHEN t32.flag_name = 'CANCEL_LAST_POS_FG'
       THEN FACT.cancel_last_pos_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_FG'
       THEN FACT.cancel_in_favour_fg
       WHEN t32.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG'
       THEN FACT.price_info_and_small_sale_fg
       WHEN t32.flag_name = 'PRICE_INFO_AND_LOGOFF_FG'
       THEN FACT.price_info_and_logoff_fg
       WHEN t32.flag_name = 'RETURN_NOT_ON_RECEIPT_FG'
       THEN FACT.return_not_on_receipt_fg
       WHEN t32.flag_name = 'RETURN_QTY_INVALID_FG'
       THEN FACT.return_qty_invalid_fg
       WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG'
       THEN FACT.return_at_higher_than_sales_price_fg
       WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG'
       THEN FACT.return_at_higher_than_official_price_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG'
       THEN FACT.return_same_cashier_and_day_manual_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG'
       THEN FACT.return_same_cashier_and_day_without_auth_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG'
       THEN FACT.return_same_cashier_and_day_cash_paym_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG'
       THEN FACT.return_same_cashier_and_day_card_paym_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_DIFF_DAY_FG'
       THEN FACT.return_same_cashier_diff_day_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG'
       THEN FACT.return_same_cashier_and_day_display_sel_fg
       WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG'
       THEN FACT.return_same_cashier_and_day_fg
       WHEN t32.flag_name = 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG'
       THEN FACT.return_without_receipt_dv_input_fg
       WHEN t32.flag_name = 'RETURN_WITHOUT_RECEIPT_FG'
       THEN FACT.return_without_receipt_fg
       WHEN t32.flag_name = 'RETURN_MULT_PROD_FULL_QTY_FG'
       THEN FACT.return_mult_prod_full_qty_fg
       WHEN t32.flag_name = 'SUSPEND_AND_ABORT_FG'
       THEN FACT.suspend_and_abort_fg
       WHEN t32.flag_name = 'SUSPEND_AND_EXTEND_FG'
       THEN FACT.suspend_and_extend_fg
       WHEN t32.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG'
       THEN FACT.suspend_and_line_cancel_fg
       WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
       THEN FACT.suspend_unresolved_and_sale_fg
       WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG'
       THEN FACT.suspend_unresolved_and_logoff_fg
       WHEN t32.flag_name = 'CANCEL_LAST_POS_EXACT_PAYM_FG'
       THEN FACT.cancel_last_pos_exact_paym_fg
       WHEN t32.flag_name = 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG'
       THEN FACT.cancel_last_pos_after_subtotal_fg
       WHEN t32.flag_name = 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG'
       THEN FACT.cancel_last_pos_alcohol_tobacco_fg
       WHEN t32.flag_name = 'CANCEL_LAST_POS_HIGHEST_POS_FG'
       THEN FACT.cancel_last_pos_highest_pos_fg
       WHEN t32.flag_name = 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG'
       THEN FACT.cancel_last_pos_outside_opening_hr_fg
       WHEN t32.flag_name = 'CANCEL_LAST_AND_OTHER_POS_FG'
       THEN FACT.cancel_last_and_other_pos_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG'
       THEN FACT.cancel_in_favour_exact_paym_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG'
       THEN FACT.cancel_in_favour_after_subtotal_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG'
       THEN FACT.cancel_in_favour_manual_discount_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG'
       THEN FACT.cancel_in_favour_without_auth_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG'
       THEN FACT.cancel_in_favour_alcohol_tobacco_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG'
       THEN FACT.cancel_in_favour_outside_opening_hr_fg
       WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG'
       THEN FACT.cancel_in_favour_lidl_plus_fg
       WHEN t32.flag_name = 'DEPOSIT_SAME_VAL_SCAN_FG'
       THEN FACT.deposit_same_val_scan_fg
       ELSE NULL
       END AS BOOL) AS flag_value
    FROM ldl_data_core_dim.t_fact_fraud_detection_by_cash_register_event_2 AS FACT
     INNER JOIN (SELECT 'DEPOSIT_AND_ONE_PROD_FG' AS flag_name
       UNION ALL
       SELECT 'DEPOSIT_SAME_EAN_FG' AS flag_name
       UNION ALL
       SELECT 'DEPOSIT_ONLY_MANUAL_INPUT_FG' AS flag_name
       UNION ALL
       SELECT 'PRICE_INFO_MULT_FG' AS flag_name
       UNION ALL
       SELECT 'PRICE_INFO_AND_SMALL_SALE_FG' AS flag_name
       UNION ALL
       SELECT 'PRICE_INFO_AND_LOGOFF_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_WITHOUT_AUTH_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_RECEIPT_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_PROD_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_NOT_ON_RECEIPT_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_QTY_INVALID_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_AND_DAY_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_MULT_PROD_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_AND_ABORT_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_AND_LINE_CANCEL_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_AND_EXTEND_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_UNRESOLVED_AND_SALE_FG' AS flag_name
       UNION ALL
       SELECT 'ABORT_AND_SALE_FG' AS flag_name
       UNION ALL
       SELECT 'ABORT_AND_LOGOFF_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_LAST_POS_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_FG' AS flag_name
       UNION ALL
       SELECT 'PRICE_INFO_AND_SMALL_SALE_FG' AS flag_name
       UNION ALL
       SELECT 'PRICE_INFO_AND_LOGOFF_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_NOT_ON_RECEIPT_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_QTY_INVALID_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_DIFF_DAY_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_SAME_CASHIER_AND_DAY_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_WITHOUT_RECEIPT_FG' AS flag_name
       UNION ALL
       SELECT 'RETURN_MULT_PROD_FULL_QTY_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_AND_ABORT_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_AND_EXTEND_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_AND_LINE_CANCEL_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_UNRESOLVED_AND_SALE_FG' AS flag_name
       UNION ALL
       SELECT 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_LAST_POS_EXACT_PAYM_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_LAST_POS_HIGHEST_POS_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_LAST_AND_OTHER_POS_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG' AS flag_name
       UNION ALL
       SELECT 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG' AS flag_name
       UNION ALL
       SELECT 'DEPOSIT_SAME_VAL_SCAN_FG' AS flag_name) AS t32 ON TRUE
    WHERE CASE
      WHEN t32.flag_name = 'DEPOSIT_AND_ONE_PROD_FG'
      THEN FACT.deposit_and_one_prod_fg
      WHEN t32.flag_name = 'DEPOSIT_SAME_EAN_FG'
      THEN FACT.deposit_same_ean_fg
      WHEN t32.flag_name = 'DEPOSIT_ONLY_MANUAL_INPUT_FG'
      THEN FACT.deposit_only_manual_input_fg
      WHEN t32.flag_name = 'PRICE_INFO_MULT_FG'
      THEN FACT.price_info_mult_fg
      WHEN t32.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG'
      THEN FACT.price_info_and_small_sale_fg
      WHEN t32.flag_name = 'PRICE_INFO_AND_LOGOFF_FG'
      THEN FACT.price_info_and_logoff_fg
      WHEN t32.flag_name = 'RETURN_WITHOUT_AUTH_FG'
      THEN FACT.return_without_auth_fg
      WHEN t32.flag_name = 'RETURN_SAME_RECEIPT_FG'
      THEN FACT.return_same_receipt_fg
      WHEN t32.flag_name = 'RETURN_SAME_PROD_FG'
      THEN FACT.return_same_prod_fg
      WHEN t32.flag_name = 'RETURN_NOT_ON_RECEIPT_FG'
      THEN FACT.return_not_on_receipt_fg
      WHEN t32.flag_name = 'RETURN_QTY_INVALID_FG'
      THEN FACT.return_qty_invalid_fg
      WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG'
      THEN FACT.return_at_higher_than_sales_price_fg
      WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG'
      THEN FACT.return_at_higher_than_official_price_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG'
      THEN FACT.return_same_cashier_and_day_fg
      WHEN t32.flag_name = 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG'
      THEN FACT.return_without_receipt_ke_input_fg
      WHEN t32.flag_name = 'RETURN_MULT_PROD_FG'
      THEN FACT.return_mult_prod_fg
      WHEN t32.flag_name = 'SUSPEND_AND_ABORT_FG'
      THEN FACT.suspend_and_abort_fg
      WHEN t32.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG'
      THEN FACT.suspend_and_line_cancel_fg
      WHEN t32.flag_name = 'SUSPEND_AND_EXTEND_FG'
      THEN FACT.suspend_and_extend_fg
      WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG'
      THEN FACT.suspend_unresolved_and_logoff_fg
      WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
      THEN FACT.suspend_unresolved_and_sale_fg
      WHEN t32.flag_name = 'ABORT_AND_SALE_FG'
      THEN FACT.abort_and_sale_fg
      WHEN t32.flag_name = 'ABORT_AND_LOGOFF_FG'
      THEN FACT.abort_and_logoff_fg
      WHEN t32.flag_name = 'CANCEL_LAST_POS_FG'
      THEN FACT.cancel_last_pos_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_FG'
      THEN FACT.cancel_in_favour_fg
      WHEN t32.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG'
      THEN FACT.price_info_and_small_sale_fg
      WHEN t32.flag_name = 'PRICE_INFO_AND_LOGOFF_FG'
      THEN FACT.price_info_and_logoff_fg
      WHEN t32.flag_name = 'RETURN_NOT_ON_RECEIPT_FG'
      THEN FACT.return_not_on_receipt_fg
      WHEN t32.flag_name = 'RETURN_QTY_INVALID_FG'
      THEN FACT.return_qty_invalid_fg
      WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG'
      THEN FACT.return_at_higher_than_sales_price_fg
      WHEN t32.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG'
      THEN FACT.return_at_higher_than_official_price_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG'
      THEN FACT.return_same_cashier_and_day_manual_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG'
      THEN FACT.return_same_cashier_and_day_without_auth_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG'
      THEN FACT.return_same_cashier_and_day_cash_paym_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG'
      THEN FACT.return_same_cashier_and_day_card_paym_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_DIFF_DAY_FG'
      THEN FACT.return_same_cashier_diff_day_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG'
      THEN FACT.return_same_cashier_and_day_display_sel_fg
      WHEN t32.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG'
      THEN FACT.return_same_cashier_and_day_fg
      WHEN t32.flag_name = 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG'
      THEN FACT.return_without_receipt_dv_input_fg
      WHEN t32.flag_name = 'RETURN_WITHOUT_RECEIPT_FG'
      THEN FACT.return_without_receipt_fg
      WHEN t32.flag_name = 'RETURN_MULT_PROD_FULL_QTY_FG'
      THEN FACT.return_mult_prod_full_qty_fg
      WHEN t32.flag_name = 'SUSPEND_AND_ABORT_FG'
      THEN FACT.suspend_and_abort_fg
      WHEN t32.flag_name = 'SUSPEND_AND_EXTEND_FG'
      THEN FACT.suspend_and_extend_fg
      WHEN t32.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG'
      THEN FACT.suspend_and_line_cancel_fg
      WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG'
      THEN FACT.suspend_unresolved_and_sale_fg
      WHEN t32.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG'
      THEN FACT.suspend_unresolved_and_logoff_fg
      WHEN t32.flag_name = 'CANCEL_LAST_POS_EXACT_PAYM_FG'
      THEN FACT.cancel_last_pos_exact_paym_fg
      WHEN t32.flag_name = 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG'
      THEN FACT.cancel_last_pos_after_subtotal_fg
      WHEN t32.flag_name = 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG'
      THEN FACT.cancel_last_pos_alcohol_tobacco_fg
      WHEN t32.flag_name = 'CANCEL_LAST_POS_HIGHEST_POS_FG'
      THEN FACT.cancel_last_pos_highest_pos_fg
      WHEN t32.flag_name = 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG'
      THEN FACT.cancel_last_pos_outside_opening_hr_fg
      WHEN t32.flag_name = 'CANCEL_LAST_AND_OTHER_POS_FG'
      THEN FACT.cancel_last_and_other_pos_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG'
      THEN FACT.cancel_in_favour_exact_paym_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG'
      THEN FACT.cancel_in_favour_after_subtotal_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG'
      THEN FACT.cancel_in_favour_manual_discount_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG'
      THEN FACT.cancel_in_favour_without_auth_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG'
      THEN FACT.cancel_in_favour_alcohol_tobacco_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG'
      THEN FACT.cancel_in_favour_outside_opening_hr_fg
      WHEN t32.flag_name = 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG'
      THEN FACT.cancel_in_favour_lidl_plus_fg
      WHEN t32.flag_name = 'DEPOSIT_SAME_VAL_SCAN_FG'
      THEN FACT.deposit_same_val_scan_fg
      ELSE NULL
      END IS NOT NULL) AS t35
   INNER JOIN CTE_STORES_IN_RV AS STORES ON t35.bus_dt BETWEEN STORES.from_bus_dt AND STORES.until_bus_dt AND t35.store_sid
      = STORES.store_sid
  WHERE t35.flag_value
  GROUP BY t35.bus_dt,
   EXTRACT(HOUR FROM t35.event_end_tmsp),
   STORES.country_org_cd,
   STORES.store_sid,
   t35.curr_cd,
   scenario_id), CTE_COUNT_CUST_DST AS (SELECT MAIN.country_org_cd,
   STORE.sales_company_sid,
   MAIN.store_sid,
   MAIN.cashier_nr,
   MAIN.scenario_id,
   MIN(MAIN.bus_dt) AS bus_dt,
   MIN(MAIN.event_end_hr) AS event_end_hr,
   CT.curr_cd,
   1 AS cust_sid_dst_cnt
  FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_2 AS MAIN
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_2 AS STORE ON MAIN.store_sid = STORE.int_org_sid AND STORE.dwh_valid_fg
    
   INNER JOIN ldl_data_core_dim.t_dim_country_2 AS CT ON MAIN.country_org_cd = CT.iso_country_cd
   INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS SC_GRP ON MAIN.scenario_id = SC_GRP.scenario_id
    
   LEFT JOIN CTE_STORE_SCENARIO_GROUPS AS ST_SC_GRP ON MAIN.store_sid = ST_SC_GRP.store_sid AND SC_GRP.scenario_grp_id =
     ST_SC_GRP.scenario_grp_id
  WHERE (ST_SC_GRP.mat_flag IS NULL OR ST_SC_GRP.mat_flag)
   AND MAIN.scenario_id = 190800
  GROUP BY MAIN.scenario_id,
   MAIN.country_org_cd,
   MAIN.store_sid,
   MAIN.cashier_nr,
   MAIN.cust_sid,
   STORE.sales_company_sid,
   CT.curr_cd) (SELECT *
  FROM (SELECT MAIN.store_sid,
      MAIN.cashier_nr,
      MAIN.bus_dt,
      MAIN.event_end_hr,
      M.metric_id,
      MAIN.country_org_cd,
      MAIN.curr_cd,
       CASE
       WHEN M.metric_id IN (210, 410, 510, 610, 710, 810, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 170110, 170210
         , 1810, 1910, 410, 7510)
       THEN COALESCE(MAIN.cash_register_event_affected_gross_val, 0)
       ELSE COALESCE(MAIN.cash_register_event_affected_net_val, 0)
       END AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S.scenario_id = M.scenario_id
     WHERE S.scenario_type_cd = 'AUTO'
      AND M.calculation_type_cd = 'SUM'
      AND MOD(CAST(M.metric_id AS BIGNUMERIC), 100) = 10
     UNION ALL
     SELECT store_sid,
      cashier_nr,
      bus_dt,
      event_end_hr,
      - 100 AS metric_id,
      country_org_cd,
      curr_cd,
       sales_net_val - return_net_val AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
     UNION ALL
     SELECT store_sid,
      cashier_nr,
      bus_dt,
      event_end_hr,
      - 200 AS metric_id,
      country_org_cd,
      curr_cd,
       sales_outside_work_hr_net_val - return_outside_work_hr_net_val AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
     UNION ALL
     SELECT store_sid,
      cashier_nr,
      bus_dt,
      event_end_hr,
      - 300 AS metric_id,
      country_org_cd,
      curr_cd,
      sales_outside_work_hr_cnt AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      STORE_FACT.bus_dt,
      STORE_FACT.event_end_hr,
      CASHIER.metric_id,
      CASHIER.country_org_cd,
      STORE_FACT.curr_cd,
      COALESCE(CASHIER_FACT.cash_register_event_cnt, 0) AS metric_val_1,
      STORE_FACT.cash_register_event_cnt AS metric_val_2,
      1 AS metric_val_3,
      0 AS metric_val_4
     FROM (SELECT FACT.store_sid,
        FACT.cashier_nr,
        FACT.scenario_id,
        FACT.country_org_cd,
        M.metric_id,
        M.calculation_type_cd
       FROM CTE_CASHIER_SCENARIO AS FACT
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON FACT.scenario_id = S.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S.scenario_id = M.scenario_id
         
       WHERE S.scenario_type_cd = 'AUTO'
        AND M.calculation_type_cd = 'LEVELAVG') AS CASHIER
      INNER JOIN (SELECT MAIN.store_sid,
         MAIN.bus_dt,
         MAIN.scenario_id,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         M.metric_id,
         SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
         MAIN.curr_cd
        FROM CTE_STORES_AGG_VALUES AS MAIN
         INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
          
         INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S.scenario_id = M.scenario_id
          
        WHERE S.scenario_type_cd = 'AUTO'
         AND M.calculation_type_cd = 'LEVELAVG'
        GROUP BY MAIN.bus_dt,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         MAIN.store_sid,
         MAIN.curr_cd,
         MAIN.scenario_id,
         M.metric_id
        UNION ALL
        SELECT MAIN.store_sid,
         MAIN.bus_dt,
         6 AS scenario_id,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         601 AS metric_id,
         SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
         MAIN.curr_cd
        FROM CTE_STORES_AGG_VALUES AS MAIN
         INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
          
        WHERE MAIN.scenario_id IN (60100, 60200)
        GROUP BY MAIN.bus_dt,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         MAIN.store_sid,
         MAIN.curr_cd
        UNION ALL
        SELECT MAIN.store_sid,
         MAIN.bus_dt,
         15 AS scenario_id,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         1501 AS metric_id,
         SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
         MAIN.curr_cd
        FROM CTE_STORES_AGG_VALUES AS MAIN
         INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
          
        WHERE MAIN.scenario_id IN (150100, 150300)
        GROUP BY MAIN.bus_dt,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         MAIN.store_sid,
         MAIN.curr_cd
        UNION ALL
        SELECT MAIN.store_sid,
         MAIN.bus_dt,
         16 AS scenario_id,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         1601 AS metric_id,
         SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
         MAIN.curr_cd
        FROM CTE_STORES_AGG_VALUES AS MAIN
         INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
          
        WHERE MAIN.scenario_id IN (160100, 160200)
        GROUP BY MAIN.bus_dt,
         MAIN.event_end_hr,
         MAIN.country_org_cd,
         MAIN.store_sid,
         MAIN.curr_cd) AS STORE_FACT ON CASHIER.store_sid = STORE_FACT.store_sid AND CASHIER.metric_id = STORE_FACT.metric_id
        
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.cashier_nr,
        MAIN.bus_dt,
        MAIN.event_end_hr,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        M.metric_id,
        MAIN.cash_register_event_cnt,
        MAIN.curr_cd
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S0 ON MAIN.scenario_id = S0.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S0.scenario_id = M.scenario_id
         
       WHERE S0.scenario_type_cd = 'AUTO'
        AND M.calculation_type_cd = 'LEVELAVG') AS CASHIER_FACT ON CASHIER.cashier_nr = CASHIER_FACT.cashier_nr AND
            STORE_FACT.store_sid = CASHIER_FACT.store_sid AND STORE_FACT.metric_id = CASHIER_FACT.metric_id AND
          STORE_FACT.bus_dt = CASHIER_FACT.bus_dt AND STORE_FACT.curr_cd = CASHIER_FACT.curr_cd AND STORE_FACT.event_end_hr
         = CASHIER_FACT.event_end_hr
     UNION ALL
     SELECT MAIN.store_sid,
      MAIN.cashier_nr,
      MAIN.bus_dt,
      MAIN.event_end_hr,
      M.metric_id,
      MAIN.country_org_cd,
      MAIN.curr_cd,
       CASE
       WHEN M.metric_id IN (4005, 190805)
       THEN CAST(MAIN.cust_sid_dst_cnt AS BIGNUMERIC)
       WHEN MOD(CAST(M.metric_id AS BIGNUMERIC), 100) = 15
       THEN 1
       WHEN M.metric_id IN (2100, 2200, 3200)
       THEN COALESCE(MAIN.cash_register_event_affected_gross_val, 0)
       WHEN M.metric_id = 3800
       THEN MAIN.cash_register_event_affected_line_cnt
       WHEN M.metric_id IN (602, 60102, 60202)
       THEN CAST(MAIN.cash_register_entry_cnt AS BIGNUMERIC)
       ELSE MAIN.cash_register_event_cnt
       END AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S.scenario_id = M.scenario_id
      INNER JOIN CTE_CASHIER_SCENARIO AS CS ON MAIN.store_sid = CS.store_sid AND MAIN.cashier_nr = CS.cashier_nr AND
         MAIN.scenario_id = CS.scenario_id AND CS.relevant_for_report_fg
     WHERE S.scenario_type_cd = 'AUTO' AND M.calculation_type_cd = 'SUM' AND MOD(CAST(M.metric_id AS BIGNUMERIC), 100)
         <> 10 AND M.metric_id NOT IN (600, 60100, 60200, 60300, 820, 190805)
      OR M.metric_id IN (2100, 2200, 2500, 2600, 2700, 3000, 3100, 3200, 3300, 3600, 3700, 3800, 4000, 4005, 4100, 4200
        , 602, 60102, 60202)
     UNION ALL
     SELECT MAIN.store_sid,
      MAIN.cashier_nr,
      MAIN.bus_dt,
      MAIN.event_end_hr,
      M.metric_id,
      MAIN.country_org_cd,
      MAIN.curr_cd,
       CASE
       WHEN M.metric_id IN (190805)
       THEN MAIN.cust_sid_dst_cnt
       ELSE 0
       END AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_COUNT_CUST_DST AS MAIN
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S.scenario_id = M.scenario_id
      INNER JOIN CTE_CASHIER_SCENARIO AS CS ON MAIN.store_sid = CS.store_sid AND MAIN.cashier_nr = CS.cashier_nr AND
         MAIN.scenario_id = CS.scenario_id AND CS.relevant_for_report_fg
     WHERE S.scenario_type_cd = 'AUTO'
      AND M.metric_id IN (190805)
     UNION ALL
     SELECT MAIN.store_sid,
      MAIN.cashier_nr,
      MAIN.bus_dt,
      MAIN.event_end_hr,
      M.metric_id,
      MAIN.country_org_cd,
      MAIN.curr_cd,
       CASE
       WHEN M.metric_id IN (2830, 3830)
       THEN MAIN.cash_register_event_affected_net_val
       WHEN M.metric_id = 4005
       THEN CAST(MAIN.cust_sid_dst_cnt AS BIGNUMERIC)
       WHEN M.metric_id = 3850
       THEN MAIN.cash_register_event_affected_line_cnt
       WHEN MOD(CAST(M.metric_id AS BIGNUMERIC), 100) = 15
       THEN 1
       WHEN M.metric_id IN (2150, 3151, 3250, 3355, 3555, 2250, 5650, 5750, 3630, 3640)
       THEN COALESCE(MAIN.cash_register_event_affected_gross_val, 0)
       ELSE MAIN.cash_register_event_cnt
       END AS metric_val_1,
       CASE
       WHEN M.metric_id IN (3640)
       THEN MAIN.cash_register_event_cnt
       ELSE 0
       END AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON MAIN.scenario_id = S.scenario_id
      INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S.scenario_id = M.scenario_id
     WHERE M.metric_id IN (2150, 2250, 2550, 2650, 2750, 3050, 3150, 3151, 3250, 3350, 3355, 3452, 3555, 3650, 3750,
        3850, 4050, 4150, 4250, 2830, 3630, 3640, 3830, 3835, 4350, 4450, 4550, 4650, 4850, 4750, 4950, 5050, 5150, 5250
        , 5450, 5550, 5650, 5610, 5750, 5950, 6050, 6150, 6250, 6350, 6450, 6550, 6750, 6850, 6950, 7050, 7150, 7250,
        7350)
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t171.bus_dt,
      t171.event_end_hr,
      3110 AS metric_id,
      CASHIER.country_org_cd,
      t171.curr_cd,
      t171.suspended_unresolved_cnt AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t171 ON CASHIER.store_sid = t171.store_sid
     WHERE CASHIER.scenario_id = 31
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t188.bus_dt,
      t188.event_end_hr,
      3120 AS metric_id,
      CASHIER.country_org_cd,
      t188.curr_cd,
      t188.suspended_unresolved_cnt AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t188 ON CASHIER.sales_company_sid = t188.sales_company_sid
     WHERE CASHIER.scenario_id = 31
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t205.bus_dt,
      t205.event_end_hr,
      3210 AS metric_id,
      CASHIER.country_org_cd,
      t205.curr_cd,
      t205.abort_net_val AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(abort_net_val) AS abort_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t205 ON CASHIER.store_sid = t205.store_sid
     WHERE CASHIER.scenario_id = 32
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t222.bus_dt,
      t222.event_end_hr,
      3220 AS metric_id,
      CASHIER.country_org_cd,
      t222.curr_cd,
      t222.abort_net_val AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(abort_net_val) AS abort_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t222 ON CASHIER.sales_company_sid = t222.sales_company_sid
     WHERE CASHIER.scenario_id = 32
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t239.bus_dt,
      t239.event_end_hr,
      3310 AS metric_id,
      CASHIER.country_org_cd,
      t239.curr_cd,
      t239.abort_cnt AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(abort_cnt) AS abort_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t239 ON CASHIER.store_sid = t239.store_sid
     WHERE CASHIER.scenario_id = 33
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t256.bus_dt,
      t256.event_end_hr,
      3320 AS metric_id,
      CASHIER.country_org_cd,
      t256.curr_cd,
      t256.abort_cnt AS metric_val_1,
      0 AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(abort_cnt) AS abort_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t256 ON CASHIER.sales_company_sid = t256.sales_company_sid
     WHERE CASHIER.scenario_id = 33
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      t273.bus_dt,
      t273.event_end_hr,
      3400 AS metric_id,
      DIM.country_org_cd,
      t273.curr_cd,
       t273.cancelled_line_cnt * 100 AS metric_val_1,
      CAST(t273.event_cnt AS BIGNUMERIC) AS metric_val_2,
      0 AS metric_val_3,
      0 AS metric_val_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        cashier_nr,
        curr_cd,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        cashier_nr,
        curr_cd) AS t273 ON DIM.store_sid = t273.store_sid AND DIM.cashier_nr = t273.cashier_nr
     WHERE DIM.scenario_id = 34
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      t290.bus_dt,
      t290.event_end_hr,
      3450 AS metric_id,
      DIM.country_org_cd,
      t290.curr_cd,
       t290.cancelled_line_cnt * 100 AS scenario_value_1,
      CAST(t290.event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        cashier_nr,
        curr_cd,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        cashier_nr,
        curr_cd) AS t290 ON DIM.store_sid = t290.store_sid AND DIM.cashier_nr = t290.cashier_nr
     WHERE DIM.scenario_id = 34
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      t307.bus_dt,
      t307.event_end_hr,
      3451 AS metric_id,
      DIM.country_org_cd,
      t307.curr_cd,
      t307.cancelled_line_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        cashier_nr,
        curr_cd,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        cashier_nr,
        curr_cd) AS t307 ON DIM.store_sid = t307.store_sid AND DIM.cashier_nr = t307.cashier_nr
     WHERE DIM.scenario_id = 34
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      t324.bus_dt,
      t324.event_end_hr,
      3410 AS metric_id,
      DIM.country_org_cd,
      t324.curr_cd,
       t324.cancelled_line_cnt * 100 AS scenario_value_1,
      CAST(t324.event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t324 ON DIM.store_sid = t324.store_sid
     WHERE DIM.scenario_id = 34
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      t341.bus_dt,
      t341.event_end_hr,
      3420 AS metric_id,
      DIM.country_org_cd,
      t341.curr_cd,
       t341.cancelled_line_cnt * 100 AS scenario_value_1,
      CAST(t341.event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t341 ON DIM.sales_company_sid = t341.sales_company_sid
     WHERE DIM.scenario_id = 34
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT CSH.store_sid,
      CSH.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      3500 AS metric_id,
      CL.country_org_cd,
      CSH.curr_cd,
       CSH.cancelled_net_val * 100 AS scenario_value_1,
       COALESCE(CSH.sales_net_val, 0) - COALESCE(CSH.return_net_val, 0) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CL
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CSH ON CL.store_sid = CSH.store_sid AND CL.cashier_nr = CSH.cashier_nr
        
     WHERE CL.scenario_id = 35
      AND CL.relevant_for_report_fg
     UNION ALL
     SELECT CSH.store_sid,
      CSH.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      3550 AS metric_id,
      CL.country_org_cd,
      CSH.curr_cd,
       CSH.cancelled_net_val * 100 AS scenario_value_1,
       COALESCE(CSH.sales_net_val, 0) - COALESCE(CSH.return_net_val, 0) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CL
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CSH ON CL.store_sid = CSH.store_sid AND CL.cashier_nr = CSH.cashier_nr
        
     WHERE CL.scenario_id = 35
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      3510 AS metric_id,
      DIM.country_org_cd,
      CSH.curr_cd,
       CSH.cancelled_net_val * 100 AS scenario_value_1,
      CAST(CSH.total_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(cancelled_net_val) AS cancelled_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        store_sid,
        curr_cd) AS CSH ON DIM.store_sid = CSH.store_sid
     WHERE DIM.scenario_id = 35
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      3520 AS metric_id,
      DIM.country_org_cd,
      CSH.curr_cd,
       CSH.cancelled_net_val * 100 AS scenario_value_1,
      CSH.total_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(cancelled_net_val) AS cancelled_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd) AS CSH ON DIM.sales_company_sid = CSH.sales_company_sid
     WHERE DIM.scenario_id = 35
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT CSH.store_sid,
      CSH.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      2900 AS metric_id,
      DIM.country_org_cd,
      CSH.curr_cd,
       CSH.return_net_val * 100 AS scenario_value_1,
       COALESCE(CSH.sales_net_val, 0) - COALESCE(CSH.return_net_val, 0) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CSH ON DIM.store_sid = CSH.store_sid AND DIM.cashier_nr = CSH.cashier_nr
        
     WHERE DIM.scenario_id = 29
      AND DIM.relevant_for_report_fg
      AND NOT CSH.is_outlier_day_return_fg
     UNION ALL
     SELECT CSH.store_sid,
      CSH.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      2950 AS metric_id,
      DIM.country_org_cd,
      CSH.curr_cd,
       CSH.return_net_val * 100 AS scenario_value_1,
       COALESCE(CSH.sales_net_val, 0) - COALESCE(CSH.return_net_val, 0) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CSH ON DIM.store_sid = CSH.store_sid AND DIM.cashier_nr = CSH.cashier_nr
        
     WHERE DIM.scenario_id = 29
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      2910 AS metric_id,
      DIM.country_org_cd,
      CSH.curr_cd,
       CAST(CSH.return_net_val AS BIGNUMERIC) * 100 AS scenario_value_1,
      CSH.total_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(return_net_val) AS return_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        store_sid,
        curr_cd) AS CSH ON DIM.store_sid = CSH.store_sid
     WHERE DIM.scenario_id = 29
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CSH.bus_dt,
      CSH.event_end_hr,
      2920 AS metric_id,
      DIM.country_org_cd,
      CSH.curr_cd,
       CSH.return_net_val * 100 AS scenario_value_1,
      CSH.total_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(return_net_val) AS return_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd) AS CSH ON DIM.sales_company_sid = CSH.sales_company_sid
     WHERE DIM.scenario_id = 29
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t482.bus_dt,
      t482.event_end_hr,
      2610 AS metric_id,
      CASHIER.country_org_cd,
      t482.curr_cd,
      t482.return_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(return_cnt) AS return_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t482 ON CASHIER.store_sid = t482.store_sid
     WHERE CASHIER.scenario_id = 26
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t499.bus_dt,
      t499.event_end_hr,
      2620 AS metric_id,
      CASHIER.country_org_cd,
      t499.curr_cd,
      t499.return_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(return_cnt) AS return_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t499 ON CASHIER.sales_company_sid = t499.sales_company_sid
     WHERE CASHIER.scenario_id = 26
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t524.bus_dt,
      t524.event_end_hr,
      2710 AS metric_id,
      CASHIER.country_org_cd,
      t524.curr_cd,
      t524.cash_register_event_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT) AS t522
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t524 ON CASHIER.store_sid = t524.store_sid
     WHERE CASHIER.scenario_id = 27
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t549.bus_dt,
      t549.event_end_hr,
      2720 AS metric_id,
      CASHIER.country_org_cd,
      t549.curr_cd,
      t549.cash_register_event_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT) AS t547
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t549 ON CASHIER.sales_company_sid = t549.sales_company_sid
     WHERE CASHIER.scenario_id = 27
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CL.store_sid,
      CL.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      2800 AS metric_id,
      CL.country_org_cd,
      CL.curr_cd,
      CL.cash_register_event_affected_net_val AS scenario_value_1,
      CAST(CL.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL
      INNER JOIN CTE_CASHIER_SCENARIO AS CASHIER ON CL.store_sid = CASHIER.store_sid AND CL.cashier_nr = CASHIER.cashier_nr
          AND CL.scenario_id = CASHIER.scenario_id
     WHERE CL.scenario_id = 28
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CL.store_sid,
      CL.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      2850 AS metric_id,
      CL.country_org_cd,
      CL.curr_cd,
      CL.cash_register_event_affected_net_val AS scenario_value_1,
      CAST(CL.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL
      INNER JOIN CTE_CASHIER_SCENARIO AS CASHIER ON CL.store_sid = CASHIER.store_sid AND CL.cashier_nr = CASHIER.cashier_nr
          AND CL.scenario_id = CASHIER.scenario_id
     WHERE CL.scenario_id = 28
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      2810 AS metric_id,
      DIM.country_org_cd,
      CL.curr_cd,
      CL.cash_register_event_affected_net_val AS scenario_value_1,
      CAST(CL.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT store_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL) AS t616
       GROUP BY store_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd) AS CL ON DIM.store_sid = CL.store_sid
     WHERE DIM.scenario_id = 28
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      2820 AS metric_id,
      DIM.country_org_cd,
      CL.curr_cd,
      CL.cash_register_event_affected_net_val AS scenario_value_1,
      CAST(CL.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT sales_company_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL) AS t640
       GROUP BY sales_company_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd) AS CL ON DIM.sales_company_sid = CL.sales_company_sid
     WHERE DIM.scenario_id = 28
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t658.bus_dt,
      t658.event_end_hr,
      3010 AS metric_id,
      CASHIER.country_org_cd,
      t658.curr_cd,
      t658.return_without_receipt_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t658 ON CASHIER.store_sid = t658.store_sid
     WHERE CASHIER.scenario_id = 30
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t675.bus_dt,
      t675.event_end_hr,
      3020 AS metric_id,
      CASHIER.country_org_cd,
      t675.curr_cd,
      t675.return_without_receipt_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t675 ON CASHIER.sales_company_sid = t675.sales_company_sid
     WHERE CASHIER.scenario_id = 30
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT FACT.store_sid,
      FACT.cashier_nr,
      FACT.bus_dt,
      FACT.event_end_hr,
      2400 AS metric_id,
      FACT.country_org_cd,
      FACT.curr_cd,
       FACT.cash_register_event_cnt / 2 AS scenario_value_1,
      1 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
      INNER JOIN CTE_CASHIER_SCENARIO AS CASHIER ON FACT.store_sid = CASHIER.store_sid AND FACT.cashier_nr = CASHIER.cashier_nr
          AND FACT.scenario_id = CASHIER.scenario_id
     WHERE FACT.scenario_id = 24
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT store_sid,
      cashier_nr,
      bus_dt,
      event_end_hr,
      2450 AS metric_id,
      country_org_cd,
      curr_cd,
       cash_register_event_cnt / 2 AS scenario_value_1,
      1 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
     UNION ALL
     SELECT store_sid,
      cashier_nr,
      bus_dt,
      event_end_hr,
      2451 AS metric_id,
      country_org_cd,
      curr_cd,
       cash_register_event_cnt / 2 AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
     UNION ALL
     SELECT store_sid,
      cashier_nr,
      bus_dt,
      event_end_hr,
      2452 AS metric_id,
      country_org_cd,
      curr_cd,
       cash_register_event_cnt / 2 AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t755.bus_dt,
      t755.event_end_hr,
      2110 AS metric_id,
      CASHIER.country_org_cd,
      t755.curr_cd,
      t755.deposit_only_return_gross_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(cash_register_event_affected_gross_val) AS deposit_only_return_gross_val
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT) AS t753
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t755 ON CASHIER.store_sid = t755.store_sid
     WHERE CASHIER.scenario_id = 21
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t780.bus_dt,
      t780.event_end_hr,
      2120 AS metric_id,
      CASHIER.country_org_cd,
      t780.curr_cd,
      t780.deposit_only_return_gross_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(cash_register_event_affected_gross_val) AS deposit_only_return_gross_val
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT) AS t778
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t780 ON CASHIER.sales_company_sid = t780.sales_company_sid
     WHERE CASHIER.scenario_id = 21
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t797.bus_dt,
      t797.event_end_hr,
      2210 AS metric_id,
      CASHIER.country_org_cd,
      t797.curr_cd,
      t797.deposit_return_manual_input_gross_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t797 ON CASHIER.store_sid = t797.store_sid
     WHERE CASHIER.scenario_id = 22
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t814.bus_dt,
      t814.event_end_hr,
      2220 AS metric_id,
      CASHIER.country_org_cd,
      t814.curr_cd,
      t814.deposit_return_manual_input_gross_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t814 ON CASHIER.sales_company_sid = t814.sales_company_sid
     WHERE CASHIER.scenario_id = 22
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CL.store_sid,
      CL.cashier_nr,
      FACT.bus_dt,
      FACT.event_end_hr,
      2300 AS metric_id,
      CL.country_org_cd,
      FACT.curr_cd,
       FACT.deposit_return_net_val * 100 AS scenario_value_1,
      FACT.deposit_sales_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CL
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT ON CL.cashier_nr = FACT.cashier_nr AND CL.store_sid = FACT
        .store_sid
     WHERE CL.scenario_id = 23
      AND CL.relevant_for_report_fg
     UNION ALL
     SELECT CL.store_sid,
      CL.cashier_nr,
      FACT.bus_dt,
      FACT.event_end_hr,
      2350 AS metric_id,
      CL.country_org_cd,
      FACT.curr_cd,
       FACT.deposit_return_net_val * 100 AS scenario_value_1,
      FACT.deposit_sales_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CL
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT ON CL.cashier_nr = FACT.cashier_nr AND CL.store_sid = FACT
        .store_sid
     WHERE CL.scenario_id = 23
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      2310 AS metric_id,
      DIM.country_org_cd,
      CL.curr_cd,
       CL.deposit_return_net_val * 100 AS scenario_value_1,
      CAST(CL.deposit_sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        SUM(deposit_return_net_val) AS deposit_return_net_val,
        SUM(deposit_sales_net_val) AS deposit_sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS CL ON DIM.store_sid = CL.store_sid
     WHERE DIM.scenario_id = 23
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT DIM.store_sid,
      DIM.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      2320 AS metric_id,
      DIM.country_org_cd,
      CL.curr_cd,
       CL.deposit_return_net_val * 100 AS scenario_value_1,
      CAST(CL.deposit_sales_net_val AS BIGNUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS DIM
      INNER JOIN (SELECT sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        SUM(deposit_return_net_val) AS deposit_return_net_val,
        SUM(deposit_sales_net_val) AS deposit_sales_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS CL ON DIM.sales_company_sid = CL.sales_company_sid
     WHERE DIM.scenario_id = 23
      AND DIM.relevant_for_report_fg
     UNION ALL
     SELECT CL.store_sid,
      CL.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      420 AS metric_id,
      CL.country_org_cd,
      CL.curr_cd,
       COALESCE(DIM.cash_register_event_affected_net_val, 0) * 100 AS scenario_value_1,
      CL.deposit_return_manual_input_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL
      LEFT JOIN CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS DIM ON CL.store_sid = DIM.store_sid AND CL.cashier_nr = DIM.cashier_nr
             AND CL.bus_dt = DIM.bus_dt AND CL.curr_cd = DIM.curr_cd AND CL.event_end_hr = DIM.event_end_hr AND DIM.scenario_id
         = 4
     UNION ALL
     SELECT CL.store_sid,
      CL.cashier_nr,
      CL.bus_dt,
      CL.event_end_hr,
      430 AS metric_id,
      CL.country_org_cd,
      CL.curr_cd,
       COALESCE(DIM.cash_register_event_affected_net_val, 0) * 100 AS scenario_value_1,
      CL.deposit_only_return_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS CL
      LEFT JOIN CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS DIM ON CL.store_sid = DIM.store_sid AND CL.cashier_nr = DIM.cashier_nr
             AND CL.bus_dt = DIM.bus_dt AND CL.curr_cd = DIM.curr_cd AND CL.event_end_hr = DIM.event_end_hr AND DIM.scenario_id
         = 4
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t911.bus_dt,
      t911.event_end_hr,
      3610 AS metric_id,
      CASHIER.country_org_cd,
      t911.curr_cd,
      t911.price_info_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(price_info_cnt) AS price_info_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t911 ON CASHIER.store_sid = t911.store_sid
     WHERE CASHIER.scenario_id = 36
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t928.bus_dt,
      t928.event_end_hr,
      3620 AS metric_id,
      CASHIER.country_org_cd,
      t928.curr_cd,
      t928.price_info_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(price_info_cnt) AS price_info_cnt
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t928 ON CASHIER.sales_company_sid = t928.sales_company_sid
     WHERE CASHIER.scenario_id = 36
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t953.bus_dt,
      t953.event_end_hr,
      3810 AS metric_id,
      CASHIER.country_org_cd,
      t953.curr_cd,
      t953.discount_line_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(cash_register_event_affected_line_cnt) AS discount_line_cnt
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT) AS t951
       GROUP BY store_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t953 ON CASHIER.store_sid = t953.store_sid
     WHERE CASHIER.scenario_id = 38
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      t978.bus_dt,
      t978.event_end_hr,
      3820 AS metric_id,
      CASHIER.country_org_cd,
      t978.curr_cd,
      t978.discount_line_cnt AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(cash_register_event_affected_line_cnt) AS discount_line_cnt
       FROM (SELECT *
         FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS FACT) AS t976
       GROUP BY sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd) AS t978 ON CASHIER.sales_company_sid = t978.sales_company_sid
     WHERE CASHIER.scenario_id = 38
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      STORE.bus_dt,
      STORE.event_end_hr,
      3910 AS metric_id,
      CASHIER.country_org_cd,
      STORE.curr_cd,
       STORE.discount_net_val * 100 AS scenario_value_1,
      STORE.total_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        SUM(discount_net_val) AS discount_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        store_sid,
        curr_cd) AS STORE ON CASHIER.store_sid = STORE.store_sid
     WHERE CASHIER.scenario_id = 39
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      STORE.bus_dt,
      STORE.event_end_hr,
      3920 AS metric_id,
      CASHIER.country_org_cd,
      STORE.curr_cd,
       STORE.discount_net_val * 100 AS scenario_value_1,
      STORE.total_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        SUM(discount_net_val) AS discount_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT
       GROUP BY bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd) AS STORE ON CASHIER.sales_company_sid = STORE.sales_company_sid
     WHERE CASHIER.scenario_id = 39
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      FACT.bus_dt,
      FACT.event_end_hr,
      3900 AS metric_id,
      CASHIER.country_org_cd,
      FACT.curr_cd,
       FACT.discount_net_val * 100 AS scenario_value_1,
       FACT.sales_net_val - FACT.return_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT ON CASHIER.store_sid = FACT.store_sid AND CASHIER.cashier_nr
         = FACT.cashier_nr
     WHERE CASHIER.scenario_id = 39
      AND CASHIER.relevant_for_report_fg
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      FACT.bus_dt,
      FACT.event_end_hr,
      3950 AS metric_id,
      CASHIER.country_org_cd,
      FACT.curr_cd,
       FACT.discount_net_val * 100 AS scenario_value_1,
       FACT.sales_net_val - FACT.return_net_val AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASHIER_SCENARIO AS CASHIER
      INNER JOIN CTE_STATISTICS_BY_STORE_DAY_CASHIER AS FACT ON CASHIER.store_sid = FACT.store_sid AND CASHIER.cashier_nr
         = FACT.cashier_nr
     WHERE CASHIER.scenario_id = 39
     UNION ALL
     SELECT store_sid,
      cashier_nr,
      bus_dt,
      event_end_hr,
      5620 AS metric_id,
      country_org_cd,
      curr_cd,
       CASE
       WHEN scenario_id = 22
       THEN COALESCE(cash_register_event_affected_gross_val, 0) * 100
       ELSE 0
       END AS scenario_value_1,
       CASE
       WHEN scenario_id = 56
       THEN COALESCE(cash_register_event_affected_gross_val, 0)
       ELSE 0
       END AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS CL
     UNION ALL
     SELECT CLS.store_sid,
      CLS.cashier_nr,
      CLR.rel_bus_dt,
      CLS.event_end_hr,
      820 AS metric_id,
      CLS.country_org_cd,
      CT.curr_cd,
      COUNT(DISTINCT CLR.rel_cash_register_event_sid) AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_classification_2 AS CLS
      INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_2 AS CLR ON CLS.bus_dt = CLR.bus_dt
        AND CLS.country_org_cd = CLR.country_org_cd AND CLS.cash_register_event_sid = CLR.cash_register_event_sid
      INNER JOIN ldl_data_core_dim.t_dim_country_2 AS CT ON CLS.country_org_cd = CT.iso_country_cd
     WHERE CLS.scenario_id = 8
      AND CLR.cash_register_event_rel_type_cd = 'ORIGINAL'
     GROUP BY CLS.scenario_id,
      CLS.country_org_cd,
      CLS.store_sid,
      CLS.event_end_hr,
      CLS.cashier_nr,
      CLR.rel_bus_dt,
      CT.curr_cd
     UNION ALL
     SELECT CASHIER.store_sid,
      CASHIER.cashier_nr,
      STORE_FACT.bus_dt,
      STORE_FACT.event_end_hr,
      CASHIER.metric_id,
      CASHIER.country_org_cd,
      STORE_FACT.curr_cd,
      COALESCE(CASHIER_FACT.cash_register_event_cnt, 0) AS metric_val_1,
      STORE_FACT.cash_register_event_cnt AS metric_val_2,
      1 AS metric_val_3,
      0 AS metric_val_4
     FROM (SELECT FACT.store_sid,
        FACT.cashier_nr,
        FACT.scenario_id,
        FACT.country_org_cd,
        M.metric_id,
        M.calculation_type_cd
       FROM CTE_CASHIER_SCENARIO AS FACT
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S ON FACT.scenario_id = S.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M ON S.scenario_id = M.scenario_id
         
       WHERE S.scenario_type_cd = 'AUTO'
        AND M.calculation_type_cd = 'LEVELAVG'
        AND M.metric_id = 2001) AS CASHIER
      INNER JOIN (SELECT MAIN.store_sid,
        MAIN.bus_dt,
        MAIN.scenario_id,
        MAIN.event_end_hr,
        MAIN.country_org_cd,
        M0.metric_id,
        SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
        MAIN.curr_cd
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S1 ON MAIN.scenario_id = S1.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M0 ON S1.scenario_id = M0.scenario_id
         
       WHERE S1.scenario_type_cd = 'AUTO'
        AND M0.calculation_type_cd = 'LEVELAVG'
        AND M0.metric_id = 2001
       GROUP BY MAIN.country_org_cd,
        MAIN.store_sid,
        MAIN.scenario_id,
        MAIN.bus_dt,
        MAIN.event_end_hr,
        MAIN.curr_cd,
        M0.metric_id) AS STORE_FACT ON CASHIER.store_sid = STORE_FACT.store_sid AND CASHIER.metric_id = STORE_FACT.metric_id
        
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.cashier_nr,
        MAIN.bus_dt,
        MAIN.event_end_hr,
        MAIN.scenario_id,
        MAIN.country_org_cd,
        M1.metric_id,
        MAIN.cash_register_event_cnt,
        MAIN.curr_cd
       FROM CTE_CASH_REGISTER_EVENT_CLASSIFICATION AS MAIN
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S2 ON MAIN.scenario_id = S2.scenario_id
         
        INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS M1 ON S2.scenario_id = M1.scenario_id
         
       WHERE S2.scenario_type_cd = 'AUTO'
        AND M1.calculation_type_cd = 'LEVELAVG'
        AND M1.metric_id = 2001) AS CASHIER_FACT ON CASHIER.cashier_nr = CASHIER_FACT.cashier_nr AND STORE_FACT.metric_id
             = CASHIER_FACT.metric_id AND STORE_FACT.store_sid = CASHIER_FACT.store_sid AND STORE_FACT.bus_dt =
          CASHIER_FACT.bus_dt AND STORE_FACT.curr_cd = CASHIER_FACT.curr_cd AND STORE_FACT.event_end_hr = CASHIER_FACT.event_end_hr
        
     UNION ALL
     SELECT CLS.store_sid,
      CLS.cashier_nr,
      CLS.bus_dt,
      CLS.event_end_hr,
       CASE
       WHEN CLS.scenario_id = 6
       THEN 600
       ELSE CLS.scenario_id
       END AS metric_id,
      CLS.country_org_cd,
      CT.curr_cd,
      COUNT(DISTINCT REL.rel_cash_register_event_sid) AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4
     FROM ldl_data_core_app_fraud_detection.t_cash_register_event_relationship_2 AS REL
      INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_classification_2 AS CLS ON REL.bus_dt = CLS.bus_dt
          AND REL.country_org_cd = CLS.country_org_cd AND REL.cash_register_event_sid = CLS.cash_register_event_sid
      INNER JOIN ldl_data_core_dim.t_dim_country_2 AS CT ON CLS.country_org_cd = CT.iso_country_cd
     WHERE CLS.scenario_id IN (6, 60100, 60200, 60300)
      AND REL.cash_register_event_rel_type_cd IN ('SUCCESSOR')
     GROUP BY CLS.scenario_id,
      CLS.country_org_cd,
      CLS.store_sid,
      CLS.bus_dt,
      CLS.event_end_hr,
      CLS.cashier_nr,
      CT.curr_cd));