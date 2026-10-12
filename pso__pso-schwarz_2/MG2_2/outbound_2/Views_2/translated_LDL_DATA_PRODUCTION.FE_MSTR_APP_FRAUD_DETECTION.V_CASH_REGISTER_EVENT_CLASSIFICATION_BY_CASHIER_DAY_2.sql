CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_event_classification_by_cashier_day_2
AS WITH cte_cash_register_event_classification AS (SELECT main.country_org_cd,
   store.sales_company_sid,
   main.store_sid,
   main.cashier_nr,
   main.scenario_id,
   main.bus_dt,
   main.event_end_hr,
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
   SUM(main.cash_register_event_cnt) AS cash_register_event_cnt,
   SUM(main.cash_register_event_affected_line_cnt) AS cash_register_event_affected_line_cnt,
   SUM(main.cash_register_event_affected_line_cnt) AS cash_register_event_affected_net_val,
   COUNT(DISTINCT main.cust_sid) AS cust_sid_dst_cnt
  FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS main
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS store ON main.store_sid = store.int_org_sid
    AND store.dwh_valid_fg
   INNER JOIN ldl_data_production_core_dim.t_dim_country_2 AS ct ON main.country_org_cd = ct.iso_country_cd
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON ct.curr_cd = fer.tgt_curr_cd
  WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
   AND fer.active_fg
  GROUP BY main.country_org_cd,
   store.sales_company_sid,
   main.store_sid,
   main.cashier_nr,
   main.scenario_id,
   main.bus_dt,
   main.event_end_hr,
   curr_cd,
   fer.tgt_curr_cd), cte_statistics_by_store_day_cashier AS (SELECT org.country_org_cd,
   org.sales_company_sid,
   main.int_org_sid AS store_sid,
   main.bus_dt,
   main.event_end_hr,
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
    main.sales_net_val / fer.exchange_rate AS sales_net_val,
    main.return_net_val / fer.exchange_rate AS return_net_val,
   main.event_cnt,
   main.event_line_cnt,
   main.return_cnt,
   main.cancelled_line_cnt,
    main.cancelled_net_val / fer.exchange_rate AS cancelled_net_val,
   main.discount_line_cnt,
    main.discount_net_val / fer.exchange_rate AS discount_net_val,
   main.abort_cnt,
    main.abort_net_val / fer.exchange_rate AS abort_net_val,
   main.suspended_unresolved_cnt,
    main.suspended_unresolved_net_val / fer.exchange_rate AS suspended_unresolved_net_val,
   main.price_info_cnt,
   main.return_without_receipt_cnt,
    main.return_without_receipt_net_val / fer.exchange_rate AS return_without_receipt_net_val,
    main.deposit_sales_net_val / fer.exchange_rate AS deposit_sales_net_val,
    main.deposit_return_net_val / fer.exchange_rate AS deposit_return_net_val,
    main.deposit_return_manual_input_net_val / fer.exchange_rate AS deposit_return_manual_input_net_val,
    main.deposit_return_manual_input_gross_val / fer.exchange_rate AS deposit_return_manual_input_gross_val,
    main.deposit_only_return_net_val / fer.exchange_rate AS deposit_only_return_net_val,
   main.small_sales_cnt,
   main.login_cnt,
   main.logoff_cnt
  FROM ldl_data_production_core_app_fraud_detection.t_statistics_by_store_hour_cashier_2 AS main
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS org ON main.int_org_sid = org.int_org_sid AND
    org.dwh_valid_fg
   INNER JOIN ldl_data_production_core_dim.t_dim_country_2 AS ct ON org.country_org_cd = ct.iso_country_cd
   INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON ct.curr_cd = fer.tgt_curr_cd
  WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
   AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
   AND fer.active_fg), cte_cashier_scenario AS (SELECT country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id
  FROM cte_cash_register_event_classification AS FACT
  GROUP BY country_org_cd,
   sales_company_sid,
   store_sid,
   cashier_nr,
   scenario_id), cte_stores_in_rv AS (SELECT org.country_org_cd,
   org.int_org_sid AS store_sid,
   ord.analysis_period_start_dt AS from_bus_dt,
   ord.analysis_period_end_dt AS until_bus_dt
  FROM ldl_data_production_core_dim.t_dim_internal_organization_2 AS org
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_2 AS ord ON org.int_org_sid = ord.int_org_sid
      OR org.sales_company_sid = ord.int_org_sid
  WHERE org.dwh_valid_fg), cte_stores_agg_values AS (SELECT t26.bus_dt,
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
     fer0.src_curr_cd AS curr_cd,
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
      THEN 16
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
      THEN 120700
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
      WHEN fer0.src_curr_cd = 'EUR'
      THEN 1
      ELSE 0
      END AS curr_group_fg,
      CASE
      WHEN fer0.src_curr_cd = fer0.tgt_curr_cd
      THEN 1
      ELSE 0
      END AS curr_local_fg,
     SUM(1) AS cash_register_event_cnt
    FROM (SELECT cash_register_event_sid,
       cash_register_event_nr,
       event_start_tmsp,
       bus_dt,
       cash_register_sid,
       cash_register_nr,
       store_sid,
       cashier_hash,
       txn_net_val,
       txn_gross_val,
       cancel_in_favour_gross_val,
       curr_cd,
       cancel_in_favour_line_cnt,
       cancel_in_favour_highest_pos_fg,
       return_same_receipt_full_qty_fg,
       return_same_receipt_same_cashier_fg,
       return_same_cashier_fg,
       small_sale_fg,
       dwh_created_tmsp,
       dwh_updated_tmsp,
       dwh_load_id,
       dwh_node_cd,
       cust_sid,
       cust_ident_type_cd,
       event_end_tmsp,
       cancel_last_pos_without_auth_fg,
       cancel_last_pos_single_pos_fg,
       cancel_in_favour_single_pos_fg,
       cancel_last_pos_gross_val,
       cancel_last_pos_line_cnt,
       return_mult_prod_same_cashier_fg,
       deposit_same_ean_gross_val,
       deposit_same_ean_line_cnt,
       event_outside_exact_opening_hr_fg,
       receipt_outside_opening_hr_fg,
       receipt_outside_opening_hr_cancel_fg,
       receipt_outside_opening_hr_return_fg,
       receipt_outside_opening_hr_suspend_fg,
       receipt_outside_opening_hr_abort_fg,
       receipt_outside_opening_hr_deposit_only_fg,
       receipt_outside_opening_hr_manual_deposit_fg,
       receipt_outside_opening_hr_manual_discount_fg,
       deposit_same_val_man_fg,
       deposit_same_val_scan_fg,
       flag_name,
       CAST(flag_value AS BOOL) AS flag_value
      FROM (SELECT fact.cash_register_event_sid,
         fact.cash_register_event_nr,
         fact.event_start_tmsp,
         fact.bus_dt,
         fact.cash_register_sid,
         fact.cash_register_nr,
         fact.store_sid,
         fact.cashier_hash,
         fact.txn_net_val,
         fact.txn_gross_val,
         fact.cancel_in_favour_gross_val,
         fact.curr_cd,
         fact.cancel_in_favour_line_cnt,
         fact.cancel_in_favour_highest_pos_fg,
         fact.return_same_receipt_full_qty_fg,
         fact.return_same_receipt_same_cashier_fg,
         fact.return_same_cashier_fg,
         fact.small_sale_fg,
         fact.dwh_created_tmsp,
         fact.dwh_updated_tmsp,
         fact.dwh_load_id,
         fact.dwh_node_cd,
         fact.cust_sid,
         fact.cust_ident_type_cd,
         fact.event_end_tmsp,
         fact.cancel_last_pos_without_auth_fg,
         fact.cancel_last_pos_single_pos_fg,
         fact.cancel_in_favour_single_pos_fg,
         fact.cancel_last_pos_gross_val,
         fact.cancel_last_pos_line_cnt,
         fact.return_mult_prod_same_cashier_fg,
         fact.deposit_same_ean_gross_val,
         fact.deposit_same_ean_line_cnt,
         fact.event_outside_exact_opening_hr_fg,
         fact.receipt_outside_opening_hr_fg,
         fact.receipt_outside_opening_hr_cancel_fg,
         fact.receipt_outside_opening_hr_return_fg,
         fact.receipt_outside_opening_hr_suspend_fg,
         fact.receipt_outside_opening_hr_abort_fg,
         fact.receipt_outside_opening_hr_deposit_only_fg,
         fact.receipt_outside_opening_hr_manual_deposit_fg,
         fact.receipt_outside_opening_hr_manual_discount_fg,
         fact.deposit_same_val_man_fg,
         fact.deposit_same_val_scan_fg,
         t18.flag_name,
                t18.flag_name = 'deposit_and_one_prod_fg' AND fact.deposit_and_one_prod_fg OR (t18.flag_name =
                   'deposit_same_ean_fg' AND fact.deposit_same_ean_fg AND t18.flag_name <> 'deposit_and_one_prod_fg' OR
                    t18.flag_name = 'deposit_only_manual_input_fg' AND fact.deposit_only_manual_input_fg AND t18.flag_name
                    <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') OR (t18.flag_name =
                     'price_info_mult_fg' AND fact.price_info_mult_fg AND t18.flag_name <> 'deposit_and_one_prod_fg' AND
                   t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' OR t18.flag_name
                       = 'price_info_and_small_sale_fg' AND fact.price_info_and_small_sale_fg AND t18.flag_name <>
                     'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                   'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' OR (t18.flag_name =
                        'price_info_and_logoff_fg' AND fact.price_info_and_logoff_fg AND t18.flag_name <>
                       'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                     'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                   'price_info_and_small_sale_fg' OR t18.flag_name = 'return_without_auth_fg' AND fact.return_without_auth_fg
                         AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND
                      t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18
                    .flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg')) OR (t18
                         .flag_name = 'return_same_receipt_fg' AND fact.return_same_receipt_fg AND t18.flag_name <>
                        'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                      'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                    'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name <>
                  'return_without_auth_fg' OR t18.flag_name = 'return_same_prod_fg' AND fact.return_same_prod_fg AND t18
                         .flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name
                        <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                     'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name <>
                   'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' OR (t18.flag_name =
                            'return_not_on_receipt_fg' AND fact.return_not_on_receipt_fg AND t18.flag_name <>
                           'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                         'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                       'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                     <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name <>
                   'return_same_prod_fg' OR t18.flag_name = 'return_qty_invalid_fg' AND fact.return_qty_invalid_fg AND
                            t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND
                          t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND
                        t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                     AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND t18
                    .flag_name <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg') OR (t18.flag_name
                               = 'return_at_higher_than_sales_price_fg' AND fact.return_at_higher_than_sales_price_fg
                            AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg'
                          AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg'
                        AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <>
                        'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                      'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <>
                    'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' OR t18.flag_name =
                               'return_at_higher_than_official_price_fg' AND fact.return_at_higher_than_official_price_fg
                               AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg'
                              AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <>
                           'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <>
                         'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                       'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <>
                     'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                   'return_at_higher_than_sales_price_fg' OR (t18.flag_name = 'return_same_cashier_and_day_fg' AND fact
                                .return_same_cashier_and_day_fg AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name
                                <> 'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name
                              <> 'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name
                            <> 'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name
                          <> 'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <>
                       'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                     'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                    'return_at_higher_than_official_price_fg' OR t18.flag_name = 'return_without_receipt_ke_input_fg'
                                 AND fact.return_without_receipt_ke_input_fg AND t18.flag_name <>
                                 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name
                               <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name
                              <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND t18
                           .flag_name <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND t18
                         .flag_name <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name
                        <> 'return_qty_invalid_fg' AND t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name
                      <> 'return_at_higher_than_official_price_fg' AND t18.flag_name <> 'return_same_cashier_and_day_fg'
                    ))) OR (t18.flag_name = 'return_mult_prod_fg' AND fact.return_mult_prod_fg AND t18.flag_name <>
                               'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                             'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name
                           <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                          <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name <>
                       'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name <>
                     'return_qty_invalid_fg' AND t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name
                    <> 'return_at_higher_than_official_price_fg' AND t18.flag_name <> 'return_same_cashier_and_day_fg'
                AND t18.flag_name <> 'return_without_receipt_ke_input_fg' OR (t18.flag_name = 'suspend_and_abort_fg' AND
                                  fact.suspend_and_abort_fg AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name
                                  <> 'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name
                                <> 'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name
                              <> 'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name
                            <> 'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <>
                         'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                       'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                      'return_at_higher_than_official_price_fg' AND t18.flag_name <> 'return_same_cashier_and_day_fg'
                   AND t18.flag_name <> 'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg'
                 OR t18.flag_name = 'suspend_and_line_cancel_fg' AND fact.suspend_and_line_cancel_fg AND t18.flag_name
                                   <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name
                                  <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name
                                <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND
                             t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND
                           t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND
                         t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                        'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                       'return_at_higher_than_official_price_fg' AND t18.flag_name <> 'return_same_cashier_and_day_fg'
                    AND t18.flag_name <> 'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg'
                     AND t18.flag_name <> 'suspend_and_abort_fg') OR (t18.flag_name = 'suspend_and_extend_fg' AND fact.suspend_and_extend_fg
                                     AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                   'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name
                                  <> 'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name
                                <> 'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name
                              <> 'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                           <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                         <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                        'return_at_higher_than_official_price_fg' AND t18.flag_name <> 'return_same_cashier_and_day_fg'
                     AND t18.flag_name <> 'return_without_receipt_ke_input_fg' AND t18.flag_name <>
                     'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <>
                   'suspend_and_line_cancel_fg' OR t18.flag_name = 'suspend_unresolved_and_logoff_fg' AND fact.suspend_unresolved_and_logoff_fg
                                      AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                    'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name
                                   <> 'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name
                                 <> 'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name
                               <> 'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                            <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                           <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                         'return_at_higher_than_official_price_fg' AND t18.flag_name <> 'return_same_cashier_and_day_fg'
                         AND t18.flag_name <> 'return_without_receipt_ke_input_fg' AND t18.flag_name <>
                      'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <>
                    'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' OR (t18.flag_name =
                                        'suspend_unresolved_and_sale_fg' AND fact.suspend_unresolved_and_sale_fg AND t18
                                       .flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                      'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18
                                    .flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                   'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND
                                 t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg'
                                 AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <>
                              'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                            <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                           'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                          'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg' AND
                        t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name
                       <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name <>
                    'suspend_unresolved_and_logoff_fg' OR t18.flag_name = 'abort_and_sale_fg' AND fact.abort_and_sale_fg
                                         AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                       'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND t18
                                     .flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                    'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND
                                  t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                 'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                               <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                              <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                            'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                        AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name
                        <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name
                     <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <> 'suspend_unresolved_and_sale_fg')) OR (t18
                                         .flag_name = 'abort_and_logoff_fg' AND fact.abort_and_logoff_fg AND t18.flag_name
                                         <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND t18
                                      .flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <>
                                     'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name
                                    <> 'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND t18
                                 .flag_name <> 'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND
                               t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg'
                            AND t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                            'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                        AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name
                        <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name
                     <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <> 'suspend_unresolved_and_sale_fg' AND t18
                   .flag_name <> 'abort_and_sale_fg' OR t18.flag_name = 'cancel_last_pos_fg' AND fact.cancel_last_pos_fg
                                          AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                        'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                      t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                     'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND
                                   t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                  'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                               <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                             'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                            'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                         AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND t18
                        .flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18
                      .flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                     'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name <>
                   'abort_and_logoff_fg' OR (t18.flag_name = 'cancel_in_favour_fg' AND fact.cancel_in_favour_fg AND t18
                                           .flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                          'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                        t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                       'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                    AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                    'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                   <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                                 <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                               'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                              AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND
                          t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND
                        t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                       'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name <>
                     'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' OR t18.flag_name =
                                             'price_info_and_small_sale_fg' AND fact.price_info_and_small_sale_fg AND
                                            t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                           'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                         t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                        'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                     AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                     'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                    <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                                  <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                               'return_same_cashier_and_day_fg' AND t18.flag_name <>
                              'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                             <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name
                           <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                         <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                      <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                    'cancel_in_favour_fg') OR (t18.flag_name = 'price_info_and_logoff_fg' AND fact.price_info_and_logoff_fg
                                             AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                           'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                         t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                        'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                     AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                     'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                    <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                                  <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                               'return_same_cashier_and_day_fg' AND t18.flag_name <>
                              'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                             <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name
                           <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                         <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                      <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                    'cancel_in_favour_fg' OR t18.flag_name = 'return_not_on_receipt_fg' AND fact.return_not_on_receipt_fg
                                             AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                           'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                         t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                        'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                     AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                     'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                    <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                                  <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                               'return_same_cashier_and_day_fg' AND t18.flag_name <>
                              'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                             <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name
                           <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                         <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                      <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                    'cancel_in_favour_fg' OR (t18.flag_name = 'return_qty_invalid_fg' AND fact.return_qty_invalid_fg AND
                                             t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                            'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg'
                                         AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                         'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                      AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                      'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                     <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18
                                  .flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                 'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                'return_same_cashier_and_day_fg' AND t18.flag_name <>
                               'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                              <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name
                            <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                          <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                        <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                     'cancel_in_favour_fg' OR t18.flag_name = 'return_at_higher_than_sales_price_fg' AND fact.return_at_higher_than_sales_price_fg
                                              AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                            'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg'
                                         AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                         'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                      AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                      'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                     <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18
                                  .flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                 'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                'return_same_cashier_and_day_fg' AND t18.flag_name <>
                               'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                              <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name
                            <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                          <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                        <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                     'cancel_in_favour_fg')))) OR (t18.flag_name = 'return_at_higher_than_official_price_fg' AND fact.return_at_higher_than_official_price_fg
                                          AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                        'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                      t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                     'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg' AND
                                   t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                  'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                               <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                             'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                            'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                         AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND t18
                        .flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18
                      .flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                     'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name <>
                   'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                 'cancel_in_favour_fg' OR (t18.flag_name = 'return_same_cashier_and_day_manual_fg' AND fact.return_same_cashier_and_day_manual_fg
                                            AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                          'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                        t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                       'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                    AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                    'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                   <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                                 <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                               'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                              AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg' AND
                          t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND
                        t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                       'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name <>
                     'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                   'cancel_in_favour_fg' OR t18.flag_name = 'return_same_cashier_and_day_without_auth_fg' AND fact.return_same_cashier_and_day_without_auth_fg
                                             AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                           'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg' AND
                                         t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                        'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                     AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                     'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                    <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                                  <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                               'return_same_cashier_and_day_fg' AND t18.flag_name <>
                              'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                             <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name
                           <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                         <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                      <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                    'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg') OR (t18.flag_name
                                               = 'return_same_cashier_and_day_cash_paym_fg' AND fact.return_same_cashier_and_day_cash_paym_fg
                                              AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                            'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg'
                                         AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                         'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                      AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                      'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                     <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18
                                  .flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                 'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                'return_same_cashier_and_day_fg' AND t18.flag_name <>
                               'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                              <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name
                            <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                          <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                        <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                     'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                    <> 'return_same_cashier_and_day_without_auth_fg' OR t18.flag_name =
                                               'return_same_cashier_and_day_card_paym_fg' AND fact.return_same_cashier_and_day_card_paym_fg
                                               AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                             'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg'
                                          AND t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name <>
                                          'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg'
                                          AND t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <>
                                       'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                                      <> 'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18
                                   .flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                  'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                 'return_same_cashier_and_day_fg' AND t18.flag_name <>
                                'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND t18
                              .flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND
                            t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name <>
                           'suspend_unresolved_and_logoff_fg' AND t18.flag_name <> 'suspend_unresolved_and_sale_fg' AND
                         t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name <> 'abort_and_logoff_fg' AND t18.flag_name
                        <> 'cancel_last_pos_fg' AND t18.flag_name <> 'cancel_in_favour_fg' AND t18.flag_name <>
                     'return_same_cashier_and_day_manual_fg' AND t18.flag_name <>
                    'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                   'return_same_cashier_and_day_cash_paym_fg' OR (t18.flag_name = 'return_same_cashier_diff_day_fg' AND
                                                fact.return_same_cashier_diff_day_fg AND t18.flag_name <>
                                                'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg' AND
                                              t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <>
                                             'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg'
                                          AND t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name <>
                                          'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND t18
                                        .flag_name <> 'return_same_prod_fg' AND t18.flag_name <>
                                       'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name
                                      <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                    'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                   'return_same_cashier_and_day_fg' AND t18.flag_name <>
                                  'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND
                                t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <>
                               'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name
                              <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                            'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                          <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                        'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                       <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                     'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                    'return_same_cashier_and_day_card_paym_fg' OR t18.flag_name =
                                                  'return_same_cashier_and_day_display_sel_fg' AND fact.return_same_cashier_and_day_display_sel_fg
                                                  AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                                'deposit_same_ean_fg' AND t18.flag_name <>
                                               'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg'
                                            AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <>
                                            'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND
                                          t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name <>
                                         'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name
                                        <> 'return_qty_invalid_fg' AND t18.flag_name <>
                                      'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                     'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                    'return_same_cashier_and_day_fg' AND t18.flag_name <>
                                   'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND
                                 t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <>
                                'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name
                               <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                             'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                            <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                         'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                        <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                      'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                     'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <> 'return_same_cashier_diff_day_fg')
               ) OR (t18.flag_name = 'return_same_cashier_and_day_fg' AND fact.return_same_cashier_and_day_fg AND t18.flag_name
                                                  <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                                'deposit_same_ean_fg' AND t18.flag_name <>
                                               'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg'
                                            AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <>
                                            'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND
                                          t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name <>
                                         'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name
                                        <> 'return_qty_invalid_fg' AND t18.flag_name <>
                                      'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                     'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                    'return_same_cashier_and_day_fg' AND t18.flag_name <>
                                   'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND
                                 t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <>
                                'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name
                               <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                             'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                            <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                         'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                        <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                      'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                     'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <> 'return_same_cashier_diff_day_fg'
                  AND t18.flag_name <> 'return_same_cashier_and_day_display_sel_fg' OR t18.flag_name =
                                                  'return_without_receipt_dv_input_fg' AND fact.return_without_receipt_dv_input_fg
                                                  AND t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                                'deposit_same_ean_fg' AND t18.flag_name <>
                                               'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg'
                                            AND t18.flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <>
                                            'price_info_and_logoff_fg' AND t18.flag_name <> 'return_without_auth_fg' AND
                                          t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name <>
                                         'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name
                                        <> 'return_qty_invalid_fg' AND t18.flag_name <>
                                      'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                     'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                    'return_same_cashier_and_day_fg' AND t18.flag_name <>
                                   'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND
                                 t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <>
                                'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name
                               <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                             'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                            <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                         'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                        <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                      'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                     'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <> 'return_same_cashier_diff_day_fg'
                  AND t18.flag_name <> 'return_same_cashier_and_day_display_sel_fg' OR (t18.flag_name =
                                                    'return_without_receipt_fg' AND fact.return_without_receipt_fg AND
                                                   t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <>
                                                  'deposit_same_ean_fg' AND t18.flag_name <>
                                                 'deposit_only_manual_input_fg' AND t18.flag_name <>
                                                'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg'
                                                AND t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name <>
                                             'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND
                                           t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <>
                                          'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg' AND
                                        t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                                       'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                                      'return_same_cashier_and_day_fg' AND t18.flag_name <>
                                     'return_without_receipt_ke_input_fg' AND t18.flag_name <> 'return_mult_prod_fg' AND
                                   t18.flag_name <> 'suspend_and_abort_fg' AND t18.flag_name <>
                                  'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND t18.flag_name
                                 <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                               'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                              <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                           'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                          <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                        'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                       'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <> 'return_same_cashier_diff_day_fg'
                       AND t18.flag_name <> 'return_same_cashier_and_day_display_sel_fg' AND t18.flag_name <>
                    'return_without_receipt_dv_input_fg' OR t18.flag_name = 'return_mult_prod_full_qty_fg' AND fact.return_mult_prod_full_qty_fg
                        AND (t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND
                      (t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18
                          .flag_name <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg')
                      ) AND (t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg' AND
                        (t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg') AND (t18
                          .flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                          'return_at_higher_than_sales_price_fg' AND (t18.flag_name <>
                           'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                           )))) AND (t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg'
                       AND (t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg')
                      AND (t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                          'suspend_unresolved_and_sale_fg' AND (t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                             <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg'))) AND (t18.flag_name <>
                          'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND (t18.flag_name
                            <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_cash_paym_fg') AND (t18.flag_name <>
                           'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <>
                           'return_same_cashier_diff_day_fg' AND (t18.flag_name <>
                            'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                              'return_without_receipt_dv_input_fg' AND t18.flag_name <> 'return_without_receipt_fg'))))
                    )) OR (t18.flag_name = 'suspend_and_abort_fg' AND fact.suspend_and_abort_fg AND (t18.flag_name <>
                         'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                         'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                          'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                             <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                          <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name <>
                          'return_qty_invalid_fg') AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18
                          .flag_name <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                            AND t18.flag_name <> 'return_mult_prod_fg')))) AND (t18.flag_name <> 'suspend_and_abort_fg'
                        AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <> 'suspend_and_extend_fg'
                         AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg') AND (t18.flag_name <>
                          'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                           <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                             'cancel_in_favour_fg'))) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                          t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_card_paym_fg') AND (t18.flag_name <>
                           'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                            'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                              t18.flag_name <> 'return_mult_prod_full_qty_fg'))))) OR t18.flag_name =
                        'suspend_and_extend_fg' AND fact.suspend_and_extend_fg AND (t18.flag_name <>
                         'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                         'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                          'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                             <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                          <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name <>
                          'return_qty_invalid_fg') AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18
                          .flag_name <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                            AND t18.flag_name <> 'return_mult_prod_fg')))) AND (t18.flag_name <> 'suspend_and_abort_fg'
                        AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <> 'suspend_and_extend_fg'
                         AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg') AND (t18.flag_name <>
                          'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                           <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                             'cancel_in_favour_fg'))) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                          t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_card_paym_fg') AND (t18.flag_name <>
                           'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                            'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                              t18.flag_name <> 'return_mult_prod_full_qty_fg'))))) OR (t18.flag_name =
                         'suspend_and_line_cancel_fg' AND fact.suspend_and_line_cancel_fg AND (t18.flag_name <>
                          'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                          'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                           'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                              <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                           <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name
                           <> 'return_qty_invalid_fg') AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND
                           t18.flag_name <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                            'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                             AND t18.flag_name <> 'return_mult_prod_fg')))) AND (t18.flag_name <> 'suspend_and_abort_fg'
                           AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <>
                           'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg') AND (t18.flag_name
                            <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                             <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                              'cancel_in_favour_fg'))) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                           t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                            'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                            'return_same_cashier_and_day_card_paym_fg') AND (t18.flag_name <>
                            'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                            'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                             'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                               t18.flag_name <> 'return_mult_prod_full_qty_fg'))))) OR t18.flag_name =
                         'suspend_unresolved_and_sale_fg' AND fact.suspend_unresolved_and_sale_fg AND (t18.flag_name <>
                          'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                          'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                           'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                              <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                           <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name
                           <> 'return_qty_invalid_fg') AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND
                           t18.flag_name <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                            'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                             AND t18.flag_name <> 'return_mult_prod_fg')))) AND (t18.flag_name <> 'suspend_and_abort_fg'
                           AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <>
                           'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg') AND (t18.flag_name
                            <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                             <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                              'cancel_in_favour_fg'))) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                           t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                            'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                            'return_same_cashier_and_day_card_paym_fg') AND (t18.flag_name <>
                            'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                            'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                             'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                               t18.flag_name <> 'return_mult_prod_full_qty_fg')))))))) OR (t18.flag_name =
                      'suspend_unresolved_and_logoff_fg' AND fact.suspend_unresolved_and_logoff_fg AND (t18.flag_name <>
                       'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                       'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                        'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                           <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                        <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name <>
                        'return_qty_invalid_fg') AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name
                         <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                         'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg' AND
                           t18.flag_name <> 'return_mult_prod_fg')))) AND (t18.flag_name <> 'suspend_and_abort_fg' AND
                       t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <> 'suspend_and_extend_fg' AND
                        t18.flag_name <> 'suspend_unresolved_and_logoff_fg') AND (t18.flag_name <>
                        'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name <>
                         'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                           'cancel_in_favour_fg'))) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                        t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                         'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                         'return_same_cashier_and_day_card_paym_fg') AND (t18.flag_name <>
                         'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                         'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                          'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND t18
                            .flag_name <> 'return_mult_prod_full_qty_fg'))))) OR (t18.flag_name =
                        'cancel_last_pos_exact_paym_fg' AND fact.cancel_last_pos_exact_paym_fg AND (t18.flag_name <>
                         'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                         'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                          'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                             <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                          <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name <>
                          'return_qty_invalid_fg') AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18
                          .flag_name <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                            AND t18.flag_name <> 'return_mult_prod_fg')))) AND (t18.flag_name <> 'suspend_and_abort_fg'
                        AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <> 'suspend_and_extend_fg'
                         AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg') AND (t18.flag_name <>
                          'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                           <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                             'cancel_in_favour_fg'))) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                          t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_card_paym_fg') AND (t18.flag_name <>
                           'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                           'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                            'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                              t18.flag_name <> 'return_mult_prod_full_qty_fg'))))) OR t18.flag_name =
                        'cancel_last_pos_after_subtotal_fg' AND fact.cancel_last_pos_after_subtotal_fg AND (t18.flag_name
                          <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                         'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                          'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                             <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                          <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND t18.flag_name <>
                          'return_qty_invalid_fg') AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18
                          .flag_name <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                            AND t18.flag_name <> 'return_mult_prod_fg')))) AND (t18.flag_name <> 'suspend_and_abort_fg'
                        AND t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <> 'suspend_and_extend_fg'
                         AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg') AND (t18.flag_name <>
                          'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                           <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                             'cancel_in_favour_fg'))) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                          t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_cash_paym_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <>
                             'return_same_cashier_diff_day_fg')) AND (t18.flag_name <>
                           'return_same_cashier_and_day_display_sel_fg' AND t18.flag_name <>
                           'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND (t18
                              .flag_name <> 'return_mult_prod_full_qty_fg' AND t18.flag_name <>
                              'cancel_last_pos_exact_paym_fg')))))) OR (t18.flag_name =
                        'cancel_last_pos_alcohol_tobacco_fg' AND fact.cancel_last_pos_alcohol_tobacco_fg AND (t18.flag_name
                          <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND (t18.flag_name <>
                         'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name <>
                          'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                             <> 'return_without_auth_fg'))) AND (t18.flag_name <> 'return_same_receipt_fg' AND t18.flag_name
                          <> 'return_same_prod_fg' AND (t18.flag_name <> 'return_not_on_receipt_fg' AND (t18.flag_name
                            <> 'return_qty_invalid_fg' AND t18.flag_name <> 'return_at_higher_than_sales_price_fg')) AND
                       (t18.flag_name <> 'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                          'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                          AND (t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg'))))
                   AND (t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND (t18
                          .flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                          'suspend_unresolved_and_sale_fg') AND (t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                          <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND (t18.flag_name <>
                             'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg'))) AND (t18
                          .flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                          'return_same_cashier_and_day_cash_paym_fg' AND (t18.flag_name <>
                           'return_same_cashier_and_day_card_paym_fg' AND (t18.flag_name <>
                             'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                             'return_same_cashier_and_day_display_sel_fg')) AND (t18.flag_name <>
                           'return_without_receipt_dv_input_fg' AND t18.flag_name <> 'return_without_receipt_fg' AND (t18
                            .flag_name <> 'return_mult_prod_full_qty_fg' AND (t18.flag_name <>
                              'cancel_last_pos_exact_paym_fg' AND t18.flag_name <> 'cancel_last_pos_after_subtotal_fg')
                          )))) OR t18.flag_name = 'cancel_last_pos_highest_pos_fg' AND fact.cancel_last_pos_highest_pos_fg
                        AND (t18.flag_name <> 'deposit_and_one_prod_fg' AND t18.flag_name <> 'deposit_same_ean_fg') AND
                      (t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg' AND (t18
                          .flag_name <> 'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg'
                           AND t18.flag_name <> 'return_without_auth_fg'))) AND (t18.flag_name <>
                         'return_same_receipt_fg' AND t18.flag_name <> 'return_same_prod_fg' AND (t18.flag_name <>
                          'return_not_on_receipt_fg' AND (t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                            'return_at_higher_than_sales_price_fg')) AND (t18.flag_name <>
                          'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                          'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                          AND (t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name <> 'suspend_and_abort_fg'))))
                   AND (t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg' AND (t18
                          .flag_name <> 'suspend_unresolved_and_logoff_fg' AND (t18.flag_name <>
                            'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg')) AND (t18.flag_name
                           <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg' AND (t18.flag_name <>
                           'cancel_in_favour_fg' AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                              <> 'return_same_cashier_and_day_without_auth_fg'))) AND (t18.flag_name <>
                          'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                          'return_same_cashier_and_day_card_paym_fg' AND (t18.flag_name <>
                           'return_same_cashier_diff_day_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_display_sel_fg' AND t18.flag_name <>
                             'return_without_receipt_dv_input_fg')) AND (t18.flag_name <> 'return_without_receipt_fg'
                          AND t18.flag_name <> 'return_mult_prod_full_qty_fg' AND (t18.flag_name <>
                            'cancel_last_pos_exact_paym_fg' AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg'
                             AND t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg'))))) OR (t18.flag_name =
                         'cancel_last_pos_outside_opening_hr_fg' AND fact.cancel_last_pos_outside_opening_hr_fg AND (t18
                          .flag_name <> 'deposit_and_one_prod_fg' AND (t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name
                             <> 'deposit_only_manual_input_fg')) AND (t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name
                           <> 'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND (t18.flag_name
                              <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg'))) AND (t18.flag_name
                           <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND (t18.flag_name
                           <> 'return_qty_invalid_fg' AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND
                             t18.flag_name <> 'return_at_higher_than_official_price_fg')) AND (t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                         AND (t18.flag_name <> 'return_mult_prod_fg' AND (t18.flag_name <> 'suspend_and_abort_fg' AND
                              t18.flag_name <> 'suspend_and_line_cancel_fg')))) AND (t18.flag_name <>
                          'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND (t18.flag_name
                            <> 'suspend_unresolved_and_sale_fg' AND (t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                              <> 'abort_and_logoff_fg')) AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                           'cancel_in_favour_fg' AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND (t18
                              .flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_cash_paym_fg'))) AND (t18.flag_name <>
                           'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <>
                           'return_same_cashier_diff_day_fg' AND (t18.flag_name <>
                            'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                              'return_without_receipt_dv_input_fg' AND t18.flag_name <> 'return_without_receipt_fg'))
                        AND (t18.flag_name <> 'return_mult_prod_full_qty_fg' AND t18.flag_name <>
                            'cancel_last_pos_exact_paym_fg' AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg'
                            AND (t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg' AND t18.flag_name <>
                               'cancel_last_pos_highest_pos_fg'))))) OR t18.flag_name = 'cancel_last_and_other_pos_fg'
                        AND fact.cancel_last_and_other_pos_fg AND (t18.flag_name <> 'deposit_and_one_prod_fg' AND (t18.flag_name
                             <> 'deposit_same_ean_fg' AND t18.flag_name <> 'deposit_only_manual_input_fg')) AND (t18.flag_name
                           <> 'price_info_mult_fg' AND t18.flag_name <> 'price_info_and_small_sale_fg' AND (t18.flag_name
                            <> 'price_info_and_logoff_fg' AND (t18.flag_name <> 'return_without_auth_fg' AND t18.flag_name
                              <> 'return_same_receipt_fg'))) AND (t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                           <> 'return_not_on_receipt_fg' AND (t18.flag_name <> 'return_qty_invalid_fg' AND (t18.flag_name
                              <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name <>
                             'return_at_higher_than_official_price_fg')) AND (t18.flag_name <>
                           'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                         AND (t18.flag_name <> 'return_mult_prod_fg' AND (t18.flag_name <> 'suspend_and_abort_fg' AND
                              t18.flag_name <> 'suspend_and_line_cancel_fg')))) AND (t18.flag_name <>
                          'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND (t18.flag_name
                            <> 'suspend_unresolved_and_sale_fg' AND (t18.flag_name <> 'abort_and_sale_fg' AND t18.flag_name
                              <> 'abort_and_logoff_fg')) AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name <>
                           'cancel_in_favour_fg' AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND (t18
                              .flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_cash_paym_fg'))) AND (t18.flag_name <>
                           'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <>
                           'return_same_cashier_diff_day_fg' AND (t18.flag_name <>
                            'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                              'return_without_receipt_dv_input_fg' AND t18.flag_name <> 'return_without_receipt_fg'))
                        AND (t18.flag_name <> 'return_mult_prod_full_qty_fg' AND (t18.flag_name <>
                              'cancel_last_pos_exact_paym_fg' AND t18.flag_name <> 'cancel_last_pos_after_subtotal_fg')
                          AND (t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg' AND (t18.flag_name <>
                               'cancel_last_pos_highest_pos_fg' AND t18.flag_name <>
                               'cancel_last_pos_outside_opening_hr_fg'))))))) OR (t18.flag_name =
                        'cancel_in_favour_exact_paym_fg' AND fact.cancel_in_favour_exact_paym_fg AND (t18.flag_name <>
                         'deposit_and_one_prod_fg' AND (t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                           'deposit_only_manual_input_fg')) AND (t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name
                          <> 'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND (t18.flag_name
                             <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg'))) AND (t18.flag_name
                          <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND (t18.flag_name <>
                          'return_qty_invalid_fg' AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name
                             <> 'return_at_higher_than_official_price_fg')) AND (t18.flag_name <>
                          'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                           AND t18.flag_name <> 'return_mult_prod_fg') AND (t18.flag_name <> 'suspend_and_abort_fg' AND
                           (t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg')
                         ))) AND (t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                         'suspend_unresolved_and_sale_fg' AND (t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                            <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg')) AND (t18.flag_name <>
                          'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND (t18.flag_name
                            <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                             'return_same_cashier_and_day_card_paym_fg'))) AND (t18.flag_name <>
                          'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                          'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                           'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                             t18.flag_name <> 'return_mult_prod_full_qty_fg')) AND (t18.flag_name <>
                           'cancel_last_pos_exact_paym_fg' AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg' AND
                             t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg') AND (t18.flag_name <>
                            'cancel_last_pos_highest_pos_fg' AND (t18.flag_name <>
                              'cancel_last_pos_outside_opening_hr_fg' AND t18.flag_name <>
                              'cancel_last_and_other_pos_fg'))))) OR t18.flag_name =
                        'cancel_in_favour_after_subtotal_fg' AND fact.cancel_in_favour_after_subtotal_fg AND (t18.flag_name
                          <> 'deposit_and_one_prod_fg' AND (t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                           'deposit_only_manual_input_fg')) AND (t18.flag_name <> 'price_info_mult_fg' AND t18.flag_name
                          <> 'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND (t18.flag_name
                             <> 'return_without_auth_fg' AND t18.flag_name <> 'return_same_receipt_fg'))) AND (t18.flag_name
                          <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg' AND (t18.flag_name <>
                          'return_qty_invalid_fg' AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND t18.flag_name
                             <> 'return_at_higher_than_official_price_fg')) AND (t18.flag_name <>
                          'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                           AND t18.flag_name <> 'return_mult_prod_fg') AND (t18.flag_name <> 'suspend_and_abort_fg' AND
                           (t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <> 'suspend_and_extend_fg')
                         ))) AND (t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name <>
                         'suspend_unresolved_and_sale_fg' AND (t18.flag_name <> 'abort_and_sale_fg' AND (t18.flag_name
                            <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg')) AND (t18.flag_name <>
                          'cancel_in_favour_fg' AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND t18.flag_name
                             <> 'return_same_cashier_and_day_without_auth_fg') AND (t18.flag_name <>
                           'return_same_cashier_and_day_cash_paym_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <>
                             'return_same_cashier_diff_day_fg'))) AND (t18.flag_name <>
                          'return_same_cashier_and_day_display_sel_fg' AND t18.flag_name <>
                          'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND (t18
                             .flag_name <> 'return_mult_prod_full_qty_fg' AND t18.flag_name <>
                             'cancel_last_pos_exact_paym_fg')) AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg'
                            AND (t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg' AND t18.flag_name <>
                             'cancel_last_pos_highest_pos_fg') AND (t18.flag_name <>
                            'cancel_last_pos_outside_opening_hr_fg' AND (t18.flag_name <> 'cancel_last_and_other_pos_fg'
                               AND t18.flag_name <> 'cancel_in_favour_exact_paym_fg'))))) OR (t18.flag_name =
                         'cancel_in_favour_manual_discount_fg' AND fact.cancel_in_favour_manual_discount_fg AND (t18.flag_name
                           <> 'deposit_and_one_prod_fg' AND (t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                            'deposit_only_manual_input_fg')) AND (t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name
                             <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg') AND (t18
                           .flag_name <> 'return_without_auth_fg' AND (t18.flag_name <> 'return_same_receipt_fg' AND t18
                             .flag_name <> 'return_same_prod_fg'))) AND (t18.flag_name <> 'return_not_on_receipt_fg' AND
                          t18.flag_name <> 'return_qty_invalid_fg' AND (t18.flag_name <>
                           'return_at_higher_than_sales_price_fg' AND (t18.flag_name <>
                             'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                             'return_same_cashier_and_day_fg')) AND (t18.flag_name <>
                           'return_without_receipt_ke_input_fg' AND (t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                              <> 'suspend_and_abort_fg') AND (t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name
                               <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg'))))
                    AND (t18.flag_name <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND
                         (t18.flag_name <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name
                              <> 'cancel_in_favour_fg')) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg'
                          AND (t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                             'return_same_cashier_and_day_cash_paym_fg') AND (t18.flag_name <>
                            'return_same_cashier_and_day_card_paym_fg' AND (t18.flag_name <>
                              'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_display_sel_fg'))) AND (t18.flag_name <>
                           'return_without_receipt_dv_input_fg' AND t18.flag_name <> 'return_without_receipt_fg' AND (t18
                            .flag_name <> 'return_mult_prod_full_qty_fg' AND (t18.flag_name <>
                              'cancel_last_pos_exact_paym_fg' AND t18.flag_name <> 'cancel_last_pos_after_subtotal_fg')
                          ) AND (t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg' AND (t18.flag_name <>
                              'cancel_last_pos_highest_pos_fg' AND t18.flag_name <>
                              'cancel_last_pos_outside_opening_hr_fg') AND (t18.flag_name <>
                             'cancel_last_and_other_pos_fg' AND (t18.flag_name <> 'cancel_in_favour_exact_paym_fg' AND
                               t18.flag_name <> 'cancel_in_favour_after_subtotal_fg'))))) OR t18.flag_name =
                         'cancel_in_favour_without_auth_fg' AND fact.cancel_in_favour_without_auth_fg AND (t18.flag_name
                           <> 'deposit_and_one_prod_fg' AND (t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                            'deposit_only_manual_input_fg')) AND (t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name
                             <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg') AND (t18
                           .flag_name <> 'return_without_auth_fg' AND (t18.flag_name <> 'return_same_receipt_fg' AND t18
                             .flag_name <> 'return_same_prod_fg'))) AND (t18.flag_name <> 'return_not_on_receipt_fg' AND
                          t18.flag_name <> 'return_qty_invalid_fg' AND (t18.flag_name <>
                           'return_at_higher_than_sales_price_fg' AND (t18.flag_name <>
                             'return_at_higher_than_official_price_fg' AND t18.flag_name <>
                             'return_same_cashier_and_day_fg')) AND (t18.flag_name <>
                           'return_without_receipt_ke_input_fg' AND (t18.flag_name <> 'return_mult_prod_fg' AND t18.flag_name
                              <> 'suspend_and_abort_fg') AND (t18.flag_name <> 'suspend_and_line_cancel_fg' AND (t18.flag_name
                               <> 'suspend_and_extend_fg' AND t18.flag_name <> 'suspend_unresolved_and_logoff_fg'))))
                    AND (t18.flag_name <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg' AND
                         (t18.flag_name <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND t18.flag_name
                              <> 'cancel_in_favour_fg')) AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg'
                          AND (t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                             'return_same_cashier_and_day_cash_paym_fg') AND (t18.flag_name <>
                            'return_same_cashier_and_day_card_paym_fg' AND (t18.flag_name <>
                              'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_display_sel_fg'))) AND (t18.flag_name <>
                           'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                             t18.flag_name <> 'return_mult_prod_full_qty_fg') AND (t18.flag_name <>
                            'cancel_last_pos_exact_paym_fg' AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg'
                             AND t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg')) AND (t18.flag_name <>
                            'cancel_last_pos_highest_pos_fg' AND (t18.flag_name <>
                              'cancel_last_pos_outside_opening_hr_fg' AND t18.flag_name <>
                              'cancel_last_and_other_pos_fg') AND (t18.flag_name <> 'cancel_in_favour_exact_paym_fg' AND
                             (t18.flag_name <> 'cancel_in_favour_after_subtotal_fg' AND t18.flag_name <>
                               'cancel_in_favour_manual_discount_fg')))))) OR (t18.flag_name =
                         'cancel_in_favour_alcohol_tobacco_fg' AND fact.cancel_in_favour_alcohol_tobacco_fg AND (t18.flag_name
                           <> 'deposit_and_one_prod_fg' AND (t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name <>
                            'deposit_only_manual_input_fg')) AND (t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name
                             <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg') AND (t18
                           .flag_name <> 'return_without_auth_fg' AND (t18.flag_name <> 'return_same_receipt_fg' AND t18
                             .flag_name <> 'return_same_prod_fg'))) AND (t18.flag_name <> 'return_not_on_receipt_fg' AND
                          (t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                            'return_at_higher_than_sales_price_fg') AND (t18.flag_name <>
                           'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                           )) AND (t18.flag_name <> 'return_mult_prod_fg' AND (t18.flag_name <> 'suspend_and_abort_fg'
                            AND t18.flag_name <> 'suspend_and_line_cancel_fg') AND (t18.flag_name <>
                            'suspend_and_extend_fg' AND (t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                               <> 'suspend_unresolved_and_sale_fg')))) AND (t18.flag_name <> 'abort_and_sale_fg' AND t18
                          .flag_name <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg' AND (t18.flag_name
                              <> 'cancel_in_favour_fg' AND t18.flag_name <> 'return_same_cashier_and_day_manual_fg'))
                       AND (t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                             'return_same_cashier_and_day_card_paym_fg') AND (t18.flag_name <>
                            'return_same_cashier_diff_day_fg' AND (t18.flag_name <>
                              'return_same_cashier_and_day_display_sel_fg' AND t18.flag_name <>
                              'return_without_receipt_dv_input_fg'))) AND (t18.flag_name <> 'return_without_receipt_fg'
                          AND (t18.flag_name <> 'return_mult_prod_full_qty_fg' AND t18.flag_name <>
                             'cancel_last_pos_exact_paym_fg') AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg'
                           AND (t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg' AND t18.flag_name <>
                              'cancel_last_pos_highest_pos_fg')) AND (t18.flag_name <>
                            'cancel_last_pos_outside_opening_hr_fg' AND (t18.flag_name <> 'cancel_last_and_other_pos_fg'
                               AND t18.flag_name <> 'cancel_in_favour_exact_paym_fg') AND (t18.flag_name <>
                             'cancel_in_favour_after_subtotal_fg' AND (t18.flag_name <>
                               'cancel_in_favour_manual_discount_fg' AND t18.flag_name <>
                               'cancel_in_favour_without_auth_fg'))))) OR t18.flag_name =
                         'cancel_in_favour_outside_opening_hr_fg' AND fact.cancel_in_favour_outside_opening_hr_fg AND (t18
                          .flag_name <> 'deposit_and_one_prod_fg' AND (t18.flag_name <> 'deposit_same_ean_fg' AND t18.flag_name
                             <> 'deposit_only_manual_input_fg')) AND (t18.flag_name <> 'price_info_mult_fg' AND (t18.flag_name
                             <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_and_logoff_fg') AND (t18
                           .flag_name <> 'return_without_auth_fg' AND (t18.flag_name <> 'return_same_receipt_fg' AND t18
                             .flag_name <> 'return_same_prod_fg'))) AND (t18.flag_name <> 'return_not_on_receipt_fg' AND
                          (t18.flag_name <> 'return_qty_invalid_fg' AND t18.flag_name <>
                            'return_at_higher_than_sales_price_fg') AND (t18.flag_name <>
                           'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_fg' AND t18.flag_name <> 'return_without_receipt_ke_input_fg'
                           )) AND (t18.flag_name <> 'return_mult_prod_fg' AND (t18.flag_name <> 'suspend_and_abort_fg'
                            AND t18.flag_name <> 'suspend_and_line_cancel_fg') AND (t18.flag_name <>
                            'suspend_and_extend_fg' AND (t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND t18.flag_name
                               <> 'suspend_unresolved_and_sale_fg')))) AND (t18.flag_name <> 'abort_and_sale_fg' AND (t18
                            .flag_name <> 'abort_and_logoff_fg' AND t18.flag_name <> 'cancel_last_pos_fg') AND (t18.flag_name
                            <> 'cancel_in_favour_fg' AND (t18.flag_name <> 'return_same_cashier_and_day_manual_fg' AND
                             t18.flag_name <> 'return_same_cashier_and_day_without_auth_fg')) AND (t18.flag_name <>
                           'return_same_cashier_and_day_cash_paym_fg' AND (t18.flag_name <>
                             'return_same_cashier_and_day_card_paym_fg' AND t18.flag_name <>
                             'return_same_cashier_diff_day_fg') AND (t18.flag_name <>
                            'return_same_cashier_and_day_display_sel_fg' AND (t18.flag_name <>
                              'return_without_receipt_dv_input_fg' AND t18.flag_name <> 'return_without_receipt_fg')))
                      AND (t18.flag_name <> 'return_mult_prod_full_qty_fg' AND (t18.flag_name <>
                             'cancel_last_pos_exact_paym_fg' AND t18.flag_name <> 'cancel_last_pos_after_subtotal_fg')
                         AND (t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg' AND (t18.flag_name <>
                              'cancel_last_pos_highest_pos_fg' AND t18.flag_name <>
                              'cancel_last_pos_outside_opening_hr_fg')) AND (t18.flag_name <>
                            'cancel_last_and_other_pos_fg' AND (t18.flag_name <> 'cancel_in_favour_exact_paym_fg' AND
                              t18.flag_name <> 'cancel_in_favour_after_subtotal_fg') AND (t18.flag_name <>
                             'cancel_in_favour_manual_discount_fg' AND (t18.flag_name <>
                               'cancel_in_favour_without_auth_fg' AND t18.flag_name <>
                               'cancel_in_favour_alcohol_tobacco_fg'))))) OR (t18.flag_name =
                          'cancel_in_favour_lidl_plus_fg' AND (fact.cancel_in_favour_lidl_plus_fg AND t18.flag_name <>
                            'deposit_and_one_prod_fg') AND (t18.flag_name <> 'deposit_same_ean_fg' AND (t18.flag_name <>
                             'deposit_only_manual_input_fg' AND t18.flag_name <> 'price_info_mult_fg')) AND (t18.flag_name
                            <> 'price_info_and_small_sale_fg' AND (t18.flag_name <> 'price_info_and_logoff_fg' AND t18.flag_name
                              <> 'return_without_auth_fg') AND (t18.flag_name <> 'return_same_receipt_fg' AND (t18.flag_name
                               <> 'return_same_prod_fg' AND t18.flag_name <> 'return_not_on_receipt_fg'))) AND (t18.flag_name
                            <> 'return_qty_invalid_fg' AND (t18.flag_name <> 'return_at_higher_than_sales_price_fg' AND
                             t18.flag_name <> 'return_at_higher_than_official_price_fg') AND (t18.flag_name <>
                            'return_same_cashier_and_day_fg' AND (t18.flag_name <> 'return_without_receipt_ke_input_fg'
                             AND t18.flag_name <> 'return_mult_prod_fg')) AND (t18.flag_name <> 'suspend_and_abort_fg'
                           AND (t18.flag_name <> 'suspend_and_line_cancel_fg' AND t18.flag_name <>
                              'suspend_and_extend_fg') AND (t18.flag_name <> 'suspend_unresolved_and_logoff_fg' AND (t18
                               .flag_name <> 'suspend_unresolved_and_sale_fg' AND t18.flag_name <> 'abort_and_sale_fg')
                           ))) AND (t18.flag_name <> 'abort_and_logoff_fg' AND (t18.flag_name <> 'cancel_last_pos_fg'
                            AND t18.flag_name <> 'cancel_in_favour_fg') AND (t18.flag_name <>
                            'return_same_cashier_and_day_manual_fg' AND (t18.flag_name <>
                              'return_same_cashier_and_day_without_auth_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_cash_paym_fg')) AND (t18.flag_name <>
                            'return_same_cashier_and_day_card_paym_fg' AND (t18.flag_name <>
                              'return_same_cashier_diff_day_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_display_sel_fg') AND (t18.flag_name <>
                             'return_without_receipt_dv_input_fg' AND (t18.flag_name <> 'return_without_receipt_fg' AND
                               t18.flag_name <> 'return_mult_prod_full_qty_fg'))) AND (t18.flag_name <>
                            'cancel_last_pos_exact_paym_fg' AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg'
                             AND t18.flag_name <> 'cancel_last_pos_alcohol_tobacco_fg') AND (t18.flag_name <>
                             'cancel_last_pos_highest_pos_fg' AND (t18.flag_name <>
                               'cancel_last_pos_outside_opening_hr_fg' AND t18.flag_name <>
                               'cancel_last_and_other_pos_fg')) AND (t18.flag_name <> 'cancel_in_favour_exact_paym_fg'
                            AND (t18.flag_name <> 'cancel_in_favour_after_subtotal_fg' AND t18.flag_name <>
                               'cancel_in_favour_manual_discount_fg') AND (t18.flag_name <>
                              'cancel_in_favour_without_auth_fg' AND (t18.flag_name <>
                                'cancel_in_favour_alcohol_tobacco_fg' AND t18.flag_name <>
                                'cancel_in_favour_outside_opening_hr_fg'))))) OR NULL AND (t18.flag_name <>
                            'abort_and_logoff_fg' AND t18.flag_name <> 'abort_and_sale_fg') AND (t18.flag_name <>
                           'cancel_in_favour_after_subtotal_fg' AND (t18.flag_name <>
                             'cancel_in_favour_alcohol_tobacco_fg' AND t18.flag_name <> 'cancel_in_favour_exact_paym_fg'
                             )) AND (t18.flag_name <> 'cancel_in_favour_fg' AND (t18.flag_name <>
                             'cancel_in_favour_lidl_plus_fg' AND t18.flag_name <> 'cancel_in_favour_manual_discount_fg'
                           ) AND (t18.flag_name <> 'cancel_in_favour_outside_opening_hr_fg' AND (t18.flag_name <>
                              'cancel_in_favour_without_auth_fg' AND t18.flag_name <> 'cancel_last_and_other_pos_fg')))
                      AND (t18.flag_name <> 'cancel_last_pos_after_subtotal_fg' AND (t18.flag_name <>
                             'cancel_last_pos_alcohol_tobacco_fg' AND t18.flag_name <> 'cancel_last_pos_exact_paym_fg')
                         AND (t18.flag_name <> 'cancel_last_pos_fg' AND (t18.flag_name <>
                              'cancel_last_pos_highest_pos_fg' AND t18.flag_name <>
                              'cancel_last_pos_outside_opening_hr_fg')) AND (t18.flag_name <> 'deposit_and_one_prod_fg'
                           AND (t18.flag_name <> 'deposit_only_manual_input_fg' AND t18.flag_name <>
                              'deposit_same_ean_fg') AND (t18.flag_name <> 'price_info_and_logoff_fg' AND (t18.flag_name
                                <> 'price_info_and_small_sale_fg' AND t18.flag_name <> 'price_info_mult_fg')))) AND (t18
                           .flag_name <> 'return_at_higher_than_official_price_fg' AND (t18.flag_name <>
                             'return_at_higher_than_sales_price_fg' AND t18.flag_name <> 'return_mult_prod_fg') AND (t18
                            .flag_name <> 'return_mult_prod_full_qty_fg' AND (t18.flag_name <>
                              'return_not_on_receipt_fg' AND t18.flag_name <> 'return_qty_invalid_fg')) AND (t18.flag_name
                             <> 'return_same_cashier_and_day_card_paym_fg' AND (t18.flag_name <>
                              'return_same_cashier_and_day_cash_paym_fg' AND t18.flag_name <>
                              'return_same_cashier_and_day_display_sel_fg') AND (t18.flag_name <>
                             'return_same_cashier_and_day_fg' AND (t18.flag_name <>
                               'return_same_cashier_and_day_manual_fg' AND t18.flag_name <>
                               'return_same_cashier_and_day_without_auth_fg'))) AND (t18.flag_name <>
                            'return_same_cashier_diff_day_fg' AND (t18.flag_name <> 'return_same_prod_fg' AND t18.flag_name
                               <> 'return_same_receipt_fg') AND (t18.flag_name <> 'return_without_auth_fg' AND (t18.flag_name
                                <> 'return_without_receipt_dv_input_fg' AND t18.flag_name <> 'return_without_receipt_fg'
                               )) AND (t18.flag_name <> 'return_without_receipt_ke_input_fg' AND (t18.flag_name <>
                               'suspend_and_abort_fg' AND t18.flag_name <> 'suspend_and_extend_fg') AND (t18.flag_name
                              <> 'suspend_and_line_cancel_fg' AND (t18.flag_name <> 'suspend_unresolved_and_logoff_fg'
                               AND t18.flag_name <> 'suspend_unresolved_and_sale_fg')))))))))) AS flag_value
        FROM ldl_data_production_core_dim.t_fact_fraud_detection_by_cash_register_event_2 AS fact
         INNER JOIN (SELECT 'deposit_and_one_prod_fg' AS flag_name
           UNION ALL
           SELECT 'deposit_same_ean_fg' AS flag_name
           UNION ALL
           SELECT 'deposit_only_manual_input_fg' AS flag_name
           UNION ALL
           SELECT 'price_info_mult_fg' AS flag_name
           UNION ALL
           SELECT 'price_info_and_small_sale_fg' AS flag_name
           UNION ALL
           SELECT 'price_info_and_logoff_fg' AS flag_name
           UNION ALL
           SELECT 'return_without_auth_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_receipt_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_prod_fg' AS flag_name
           UNION ALL
           SELECT 'return_not_on_receipt_fg' AS flag_name
           UNION ALL
           SELECT 'return_qty_invalid_fg' AS flag_name
           UNION ALL
           SELECT 'return_at_higher_than_sales_price_fg' AS flag_name
           UNION ALL
           SELECT 'return_at_higher_than_official_price_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_and_day_fg' AS flag_name
           UNION ALL
           SELECT 'return_without_receipt_ke_input_fg' AS flag_name
           UNION ALL
           SELECT 'return_mult_prod_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_and_abort_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_and_line_cancel_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_and_extend_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_unresolved_and_logoff_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_unresolved_and_sale_fg' AS flag_name
           UNION ALL
           SELECT 'abort_and_sale_fg' AS flag_name
           UNION ALL
           SELECT 'abort_and_logoff_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_last_pos_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_fg' AS flag_name
           UNION ALL
           SELECT 'price_info_and_small_sale_fg' AS flag_name
           UNION ALL
           SELECT 'price_info_and_logoff_fg' AS flag_name
           UNION ALL
           SELECT 'return_not_on_receipt_fg' AS flag_name
           UNION ALL
           SELECT 'return_qty_invalid_fg' AS flag_name
           UNION ALL
           SELECT 'return_at_higher_than_sales_price_fg' AS flag_name
           UNION ALL
           SELECT 'return_at_higher_than_official_price_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_and_day_manual_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_and_day_without_auth_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_and_day_cash_paym_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_and_day_card_paym_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_diff_day_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_and_day_display_sel_fg' AS flag_name
           UNION ALL
           SELECT 'return_same_cashier_and_day_fg' AS flag_name
           UNION ALL
           SELECT 'return_without_receipt_dv_input_fg' AS flag_name
           UNION ALL
           SELECT 'return_without_receipt_fg' AS flag_name
           UNION ALL
           SELECT 'return_mult_prod_full_qty_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_and_abort_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_and_extend_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_and_line_cancel_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_unresolved_and_sale_fg' AS flag_name
           UNION ALL
           SELECT 'suspend_unresolved_and_logoff_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_last_pos_exact_paym_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_last_pos_after_subtotal_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_last_pos_alcohol_tobacco_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_last_pos_highest_pos_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_last_pos_outside_opening_hr_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_last_and_other_pos_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_exact_paym_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_after_subtotal_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_manual_discount_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_without_auth_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_alcohol_tobacco_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_outside_opening_hr_fg' AS flag_name
           UNION ALL
           SELECT 'cancel_in_favour_lidl_plus_fg' AS flag_name) AS t18 ON TRUE) AS t19
      WHERE t19.flag_value IS NOT NULL) AS t21
     INNER JOIN cte_stores_in_rv AS STORES ON t21.bus_dt BETWEEN STORES.from_bus_dt AND STORES.until_bus_dt AND t21.store_sid
        = STORES.store_sid
     INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer0 ON t21.curr_cd = fer0.tgt_curr_cd
    WHERE fer0.exchange_rate_type_cd = 'BEW_ISK'
     AND (fer0.src_curr_cd = 'EUR' OR fer0.src_curr_cd = fer0.tgt_curr_cd)
     AND fer0.active_fg
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
      m.metric_id,
      m.calculation_type_cd,
      MAIN.cash_register_event_affected_net_val AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      MAIN.curr_cd,
      MAIN.curr_group_fg,
      MAIN.curr_local_fg
     FROM cte_cash_register_event_classification AS MAIN
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s ON MAIN.scenario_id = s.scenario_id
       
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m ON s.scenario_id = m.scenario_id
       
     WHERE s.scenario_type_cd = 'AUTO'
      AND m.calculation_type_cd = 'SUM'
      AND MOD(m.metric_id, 100) = 10
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
     FROM cte_statistics_by_store_day_cashier AS FACT
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
        MAIN.event_end_hr,
        MAIN.country_org_cd,
        m0.metric_id,
        SUM(MAIN.cash_register_event_cnt) AS cash_register_event_cnt,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg
       FROM cte_stores_agg_values AS MAIN
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_2 AS s0 ON MAIN.scenario_id =
         s0.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS m0 ON s0.scenario_id =
         m0.scenario_id
       WHERE s0.scenario_type_cd = 'AUTO'
        AND m0.calculation_type_cd = 'LEVELAVG'
       GROUP BY MAIN.bus_dt,
        MAIN.event_end_hr,
        MAIN.country_org_cd,
        MAIN.store_sid,
        MAIN.curr_cd,
        MAIN.curr_group_fg,
        MAIN.curr_local_fg,
        MAIN.scenario_id,
        m0.metric_id) AS STORE_FACT ON CASHIER.store_sid = STORE_FACT.store_sid AND CASHIER.metric_id = STORE_FACT.metric_id
        
      LEFT JOIN (SELECT MAIN.store_sid,
        MAIN.cashier_nr,
        MAIN.bus_dt,
        MAIN.event_end_hr,
        MAIN.scenario_id,
        MAIN.country_org_cd,
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
          STORE_FACT.bus_dt = CASHIER_FACT.bus_dt AND STORE_FACT.curr_cd = CASHIER_FACT.curr_cd AND STORE_FACT.event_end_hr
         = CASHIER_FACT.event_end_hr
     UNION ALL
     SELECT MAIN.store_sid,
      MAIN.bus_dt,
      MAIN.event_end_hr,
      MAIN.cashier_nr,
      MAIN.scenario_id,
      MAIN.country_org_cd,
      m.metric_id,
      m.calculation_type_cd,
       CASE
       WHEN m.metric_id IN (2100, 2200, 3200)
       THEN MAIN.cash_register_event_affected_net_val
       WHEN m.metric_id = 4005
       THEN CAST(MAIN.cust_sid_dst_cnt AS INTEGER)
       WHEN MOD(m.metric_id, 100) = 15
       THEN 1
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
       
     WHERE s.scenario_type_cd = 'AUTO' AND m.calculation_type_cd = 'SUM' AND MOD(m.metric_id, 100) <> 10
      OR m.metric_id IN (2100, 2200, 2500, 2600, 2700, 3000, 3100, 3200, 3300, 3600, 3700, 3800, 4000, 4005, 4100, 4200
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_net_val) AS abort_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_net_val) AS abort_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_cnt) AS abort_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(abort_cnt) AS abort_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
      CAST(CSH.event_cnt AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        cashier_nr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
      CAST(CSH.event_cnt AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
      CAST(CSH.event_cnt AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_line_cnt) AS cancelled_line_cnt,
        SUM(event_cnt) AS event_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
      CAST(CSH.sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS CL
      INNER JOIN cte_statistics_by_store_day_cashier AS CSH ON CL.store_sid = CSH.store_sid AND CL.cashier_nr = CSH.cashier_nr
        
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
      CAST(CSH.sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_net_val) AS cancelled_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
      CAST(CSH.sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cancelled_net_val) AS cancelled_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
      CAST(CSH.sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN cte_statistics_by_store_day_cashier AS CSH ON DIM.store_sid = CSH.store_sid AND DIM.cashier_nr = CSH.cashier_nr
        
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
       CAST(CSH.return_net_val AS NUMERIC) * 100 AS scenario_value_1,
      CAST(CSH.sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_net_val) AS return_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
      CAST(CSH.sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CSH.curr_cd,
      CSH.curr_group_fg,
      CSH.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_net_val) AS return_net_val,
        SUM(sales_net_val) AS sales_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_cnt) AS return_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_cnt) AS return_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM cte_cash_register_event_classification AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM cte_cash_register_event_classification AS FACT
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
      CAST(cash_register_event_cnt AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      curr_cd,
      curr_group_fg,
      curr_local_fg
     FROM cte_cash_register_event_classification AS CL
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
      CAST(CL.cash_register_event_cnt AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT store_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM cte_cash_register_event_classification AS CL
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
      CAST(CL.cash_register_event_cnt AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT sales_company_sid,
        scenario_id,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
        SUM(cash_register_event_cnt) AS cash_register_event_cnt
       FROM cte_cash_register_event_classification AS CL
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cash_register_event_classification AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_only_return_net_val) AS deposit_only_return_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_only_return_net_val) AS deposit_only_return_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CL
      INNER JOIN cte_statistics_by_store_day_cashier AS FACT ON CL.cashier_nr = FACT.cashier_nr AND CL.store_sid = FACT
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
      CAST(CL.deposit_sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT store_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_net_val) AS deposit_return_net_val,
        SUM(deposit_sales_net_val) AS deposit_sales_net_val
       FROM cte_statistics_by_store_day_cashier AS CL
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
      CAST(CL.deposit_sales_net_val AS NUMERIC) AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      CL.curr_cd,
      CL.curr_group_fg,
      CL.curr_local_fg
     FROM cte_cashier_scenario AS DIM
      INNER JOIN (SELECT sales_company_sid,
        bus_dt,
        event_end_hr,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(deposit_return_net_val) AS deposit_return_net_val,
        SUM(deposit_sales_net_val) AS deposit_sales_net_val
       FROM cte_statistics_by_store_day_cashier AS CL
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
     FROM cte_cash_register_event_classification AS DIM
      INNER JOIN cte_statistics_by_store_day_cashier AS CL ON DIM.store_sid = CL.store_sid AND DIM.cashier_nr = CL.cashier_nr
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
     FROM cte_cash_register_event_classification AS DIM
      INNER JOIN cte_statistics_by_store_day_cashier AS CL ON DIM.store_sid = CL.store_sid AND DIM.cashier_nr = CL.cashier_nr
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(price_info_cnt) AS price_info_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(price_info_cnt) AS price_info_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_line_cnt) AS discount_line_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_line_cnt) AS discount_line_cnt
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        store_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_net_val) AS discount_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN (SELECT bus_dt,
        event_end_hr,
        sales_company_sid,
        curr_cd,
        curr_group_fg,
        curr_local_fg,
        SUM(discount_net_val) AS discount_net_val,
        SUM(sales_net_val - return_net_val) AS total_net_val
       FROM cte_statistics_by_store_day_cashier AS FACT
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
     FROM cte_cashier_scenario AS CASHIER
      INNER JOIN cte_statistics_by_store_day_cashier AS FACT ON CASHIER.store_sid = FACT.store_sid AND CASHIER.cashier_nr
         = FACT.cashier_nr
     WHERE CASHIER.scenario_id = 39
     UNION ALL
     SELECT cls.store_sid,
      clr.rel_bus_dt,
      cls.event_end_hr,
      cls.cashier_nr,
      cls.scenario_id,
      cls.country_org_cd,
      820 AS metric_id,
      'SUM' AS calculation_type_cd,
      COUNT(DISTINCT clr.rel_cash_register_event_sid) AS scenario_value_1,
      0 AS scenario_value_2,
      0 AS scenario_value_3,
      0 AS scenario_value_4,
      fer.src_curr_cd AS curr_cd,
      MAX(CASE
        WHEN fer.src_curr_cd = 'EUR'
        THEN 1
        ELSE 0
        END) AS curr_group_fg,
      MAX(CASE
        WHEN fer.src_curr_cd = fer.tgt_curr_cd
        THEN 1
        ELSE 0
        END) AS curr_local_fg
     FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS cls
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_2 AS clr ON cls.bus_dt =
         clr.bus_dt AND cls.country_org_cd = clr.country_org_cd AND cls.cash_register_event_sid = clr.cash_register_event_sid
        
      INNER JOIN ldl_data_production_core_dim.t_dim_country_2 AS ct ON cls.country_org_cd = ct.iso_country_cd
      INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON ct.curr_cd = fer.tgt_curr_cd
     WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
      AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
      AND fer.active_fg
      AND cls.scenario_id = 8
      AND clr.cash_register_event_rel_type_cd = 'ORIGINAL'
     GROUP BY cls.store_sid,
      cls.event_end_hr,
      clr.rel_bus_dt,
      cls.cashier_nr,
      cls.scenario_id,
      cls.country_org_cd,
      curr_cd));