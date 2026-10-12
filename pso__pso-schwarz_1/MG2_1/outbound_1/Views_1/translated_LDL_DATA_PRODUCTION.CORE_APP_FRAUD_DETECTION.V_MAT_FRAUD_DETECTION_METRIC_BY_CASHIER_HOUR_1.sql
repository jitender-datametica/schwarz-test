CREATE OR REPLACE VIEW ldl_data_production_core_app_fraud_detection.v_mat_fraud_detection_metric_by_cashier_hour_1 
AS 
WITH cte_store_scenario_groups AS (
    SELECT 
        int_org_sid AS store_sid,
        CASE 
            WHEN scenario_group = 'ABORT_SCENARIO_GRP_SUSPEND_FG' THEN 1
            WHEN scenario_group = 'RETURN_SCENARIO_GRP_FG' THEN 2
            WHEN scenario_group = 'DEPOSIT_SCENARIO_GRP_FG' THEN 3
            WHEN scenario_group = 'DISCOUNT_SCENARIO_GRP_FG' THEN 4
            WHEN scenario_group = 'CANCEL_SCENARIO_GRP_FG' THEN 5
            WHEN scenario_group = 'OTHER_SCENARIO_GRP_FG' THEN 6
            ELSE 0
        END AS scenario_grp_id,
        mat_flag
    FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_1
    UNPIVOT(
        mat_flag FOR scenario_group IN (
            abort_scenario_grp_suspend_fg AS 'ABORT_SCENARIO_GRP_SUSPEND_FG',
            cancel_scenario_grp_fg AS 'CANCEL_SCENARIO_GRP_FG',
            deposit_scenario_grp_fg AS 'DEPOSIT_SCENARIO_GRP_FG',
            discount_scenario_grp_fg AS 'DISCOUNT_SCENARIO_GRP_FG',
            other_scenario_grp_fg AS 'OTHER_SCENARIO_GRP_FG',
            return_scenario_grp_fg AS 'RETURN_SCENARIO_GRP_FG'
        )
    )
    WHERE int_org_type_cd = 'STORE'
      AND order_parameter_status_cd IN ('LO', 'MT', 'RV')
),

cte_cash_register_event_classification AS (
    SELECT 
        main.country_org_cd,
        store.sales_company_sid,
        main.store_sid,
        main.cashier_nr,
        main.scenario_id,
        main.bus_dt,
        main.event_end_hr,
        ct.curr_cd,
        SUM(main.cash_register_event_cnt) AS cash_register_event_cnt,
        SUM(main.cash_register_event_affected_line_cnt) AS cash_register_event_affected_line_cnt,
        SUM(main.cash_register_event_affected_net_val) AS cash_register_event_affected_net_val,
        SUM(main.cash_register_event_affected_gross_val) AS cash_register_event_affected_gross_val,
        COUNT(DISTINCT main.cust_sid) AS cust_sid_dst_cnt,
        SUM(1) AS cash_register_entry_cnt
    FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_1 AS main
    INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_1 AS store 
        ON main.store_sid = store.int_org_sid AND store.dwh_valid_fg
    INNER JOIN ldl_data_production_core_dim.t_dim_country_1 AS ct 
        ON main.country_org_cd = ct.iso_country_cd
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS sc_grp 
        ON main.scenario_id = sc_grp.scenario_id
    LEFT JOIN cte_store_scenario_groups AS st_sc_grp 
        ON main.store_sid = st_sc_grp.store_sid AND sc_grp.scenario_grp_id = st_sc_grp.scenario_grp_id
    WHERE st_sc_grp.mat_flag IS NULL OR st_sc_grp.mat_flag = TRUE
    GROUP BY 
        main.country_org_cd,
        store.sales_company_sid,
        main.store_sid,
        main.cashier_nr,
        main.scenario_id,
        main.bus_dt,
        main.event_end_hr,
        ct.curr_cd
),

cte_statistics_by_store_day_cashier AS (
    SELECT 
        org.country_org_cd,
        org.sales_company_sid,
        main.int_org_sid AS store_sid,
        main.bus_dt,
        main.event_end_hr,
        main.cashier_nr,
        ct.curr_cd,
        main.sales_net_val,
        main.return_net_val,
        main.event_cnt,
        main.event_line_cnt,
        main.return_cnt,
        main.cancelled_line_cnt,
        main.cancelled_net_val,
        main.discount_line_cnt,
        main.discount_net_val,
        main.abort_cnt,
        main.abort_net_val,
        main.suspended_unresolved_cnt,
        main.suspended_unresolved_net_val,
        main.price_info_cnt,
        main.return_without_receipt_cnt,
        main.return_without_receipt_net_val,
        main.deposit_sales_net_val,
        main.deposit_return_net_val,
        main.deposit_return_manual_input_net_val,
        main.deposit_return_manual_input_gross_val,
        main.deposit_only_return_net_val,
        main.small_sales_cnt,
        main.login_cnt,
        main.logoff_cnt,
        main.is_outlier_day_return_fg
    FROM ldl_data_production_core_app_fraud_detection.t_statistics_by_store_hour_cashier_1 AS main
    INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_1 AS org 
        ON main.int_org_sid = org.int_org_sid AND org.dwh_valid_fg
    INNER JOIN ldl_data_production_core_dim.t_dim_country_1 AS ct 
        ON org.country_org_cd = ct.iso_country_cd
    WHERE main.sales_net_val - main.return_net_val <> 0
),

cte_cashier_scenario AS (
    SELECT 
        fact.country_org_cd,
        fact.sales_company_sid,
        fact.store_sid,
        fact.cashier_nr,
        fact.scenario_id,
        CASE 
            WHEN (MAX(sc.scenario_type_cd) IN ('AUTO', 'GEN') OR fact.scenario_id = 4000) THEN TRUE
            ELSE COALESCE(MAX(rnk.relevant_for_manual_report_fg), FALSE)
        END AS relevant_for_report_fg
    FROM cte_cash_register_event_classification AS fact
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS sc 
        ON fact.scenario_id = sc.scenario_id
    LEFT JOIN ldl_data_production_core_app_fraud_detection.t_cashier_ranking_by_fraud_scenario_1 AS rnk 
        ON fact.cashier_nr = rnk.cashier_nr 
        AND fact.store_sid = rnk.store_sid 
        AND fact.scenario_id = rnk.scenario_id
    GROUP BY 
        fact.country_org_cd,
        fact.sales_company_sid,
        fact.store_sid,
        fact.cashier_nr,
        fact.scenario_id
),

cte_stores_in_rv AS (
    SELECT 
        org.country_org_cd,
        org.int_org_sid AS store_sid,
        ord.analysis_period_start_dt AS from_bus_dt,
        ord.analysis_period_end_dt AS until_bus_dt
    FROM ldl_data_production_core_dim.t_dim_internal_organization_1 AS org
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_1 AS ord 
        ON org.int_org_sid = ord.int_org_sid OR org.sales_company_sid = ord.int_org_sid
    WHERE org.dwh_valid_fg
      AND ord.order_parameter_status_cd NOT IN ('RM', 'END')
),

cte_stores_agg_values AS (
    SELECT 
        unpivoted.bus_dt,
        EXTRACT(HOUR FROM unpivoted.event_end_tmsp) AS event_end_hr,
        stores.country_org_cd,
        stores.store_sid,
        unpivoted.curr_cd,
        CASE
            WHEN unpivoted.flag_name = 'DEPOSIT_AND_ONE_PROD_FG' THEN 1
            WHEN unpivoted.flag_name = 'DEPOSIT_SAME_EAN_FG' THEN 2
            WHEN unpivoted.flag_name = 'DEPOSIT_ONLY_MANUAL_INPUT_FG' THEN 4
            WHEN unpivoted.flag_name = 'PRICE_INFO_MULT_FG' THEN 5
            WHEN unpivoted.flag_name = 'RETURN_WITHOUT_AUTH_FG' THEN 7
            WHEN unpivoted.flag_name = 'RETURN_SAME_RECEIPT_FG' THEN 8
            WHEN unpivoted.flag_name = 'RETURN_SAME_PROD_FG' THEN 9
            WHEN unpivoted.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' THEN 11
            WHEN unpivoted.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG' THEN 12
            WHEN unpivoted.flag_name = 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG' THEN 13
            WHEN unpivoted.flag_name = 'RETURN_MULT_PROD_FG' THEN 14
            WHEN unpivoted.flag_name IN ('SUSPEND_AND_ABORT_FG', 'SUSPEND_AND_EXTEND_FG', 'SUSPEND_AND_LINE_CANCEL_FG') THEN 15
            WHEN unpivoted.flag_name = 'CANCEL_LAST_POS_FG' THEN 18
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_FG' THEN 19
            WHEN unpivoted.flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG' THEN 60100
            WHEN unpivoted.flag_name = 'PRICE_INFO_AND_LOGOFF_FG' THEN 60200
            WHEN unpivoted.flag_name = 'RETURN_NOT_ON_RECEIPT_FG' THEN 100100
            WHEN unpivoted.flag_name = 'RETURN_QTY_INVALID_FG' THEN 100200
            WHEN unpivoted.flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG' THEN 110100
            WHEN unpivoted.flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' THEN 110200
            WHEN unpivoted.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG' THEN 120100
            WHEN unpivoted.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG' THEN 120200
            WHEN unpivoted.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG' THEN 120300
            WHEN unpivoted.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG' THEN 120400
            WHEN unpivoted.flag_name = 'RETURN_SAME_CASHIER_DIFF_DAY_FG' THEN 120600
            WHEN unpivoted.flag_name = 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG' THEN 120700
            WHEN unpivoted.flag_name = 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG' THEN 130100
            WHEN unpivoted.flag_name = 'RETURN_WITHOUT_RECEIPT_FG' THEN 130200
            WHEN unpivoted.flag_name = 'RETURN_MULT_PROD_FULL_QTY_FG' THEN 140100
            WHEN unpivoted.flag_name = 'SUSPEND_AND_ABORT_FG' THEN 150100
            WHEN unpivoted.flag_name = 'SUSPEND_AND_EXTEND_FG' THEN 150200
            WHEN unpivoted.flag_name = 'SUSPEND_AND_LINE_CANCEL_FG' THEN 150300
            WHEN unpivoted.flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG' THEN 160100
            WHEN unpivoted.flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' THEN 160200
            WHEN unpivoted.flag_name = 'ABORT_AND_SALE_FG' THEN 170100
            WHEN unpivoted.flag_name = 'ABORT_AND_LOGOFF_FG' THEN 170200
            WHEN unpivoted.flag_name = 'CANCEL_LAST_POS_EXACT_PAYM_FG' THEN 180100
            WHEN unpivoted.flag_name = 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG' THEN 180200
            WHEN unpivoted.flag_name = 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG' THEN 180300
            WHEN unpivoted.flag_name = 'CANCEL_LAST_POS_HIGHEST_POS_FG' THEN 180400
            WHEN unpivoted.flag_name = 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG' THEN 180500
            WHEN unpivoted.flag_name = 'CANCEL_LAST_AND_OTHER_POS_FG' THEN 180600
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG' THEN 190100
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG' THEN 190200
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG' THEN 190300
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG' THEN 190400
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG' THEN 190600
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG' THEN 190700
            WHEN unpivoted.flag_name = 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG' THEN 190800
            ELSE -1
        END AS scenario_id,
        SUM(1) AS cash_register_event_cnt
    FROM ldl_data_production_core_dim.t_fact_fraud_detection_by_cash_register_event_1 AS fact
    UNPIVOT(
        flag_value FOR flag_name IN (
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
        )
    ) AS unpivoted
    INNER JOIN cte_stores_in_rv AS stores 
        ON unpivoted.bus_dt BETWEEN stores.from_bus_dt AND stores.until_bus_dt 
        AND unpivoted.store_sid = stores.store_sid
    WHERE unpivoted.flag_value = TRUE
    GROUP BY 
        unpivoted.bus_dt,
        EXTRACT(HOUR FROM unpivoted.event_end_tmsp),
        stores.country_org_cd,
        stores.store_sid,
        unpivoted.curr_cd,
        scenario_id
),

cte_count_cust_dst AS (
    SELECT 
        main.country_org_cd,
        store.sales_company_sid,
        main.store_sid,
        main.cashier_nr,
        main.scenario_id,
        MIN(main.bus_dt) AS bus_dt,
        MIN(main.event_end_hr) AS event_end_hr,
        ct.curr_cd,
        1 AS cust_sid_dst_cnt
    FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_1 AS main
    INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_1 AS store 
        ON main.store_sid = store.int_org_sid AND store.dwh_valid_fg
    INNER JOIN ldl_data_production_core_dim.t_dim_country_1 AS ct 
        ON main.country_org_cd = ct.iso_country_cd
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS sc_grp 
        ON main.scenario_id = sc_grp.scenario_id
    LEFT JOIN cte_store_scenario_groups AS st_sc_grp 
        ON main.store_sid = st_sc_grp.store_sid AND sc_grp.scenario_grp_id = st_sc_grp.scenario_grp_id
    WHERE (st_sc_grp.mat_flag IS NULL OR st_sc_grp.mat_flag = TRUE)
      AND main.scenario_id = 190800
    GROUP BY 
        main.scenario_id,
        main.country_org_cd,
        main.store_sid,
        main.cashier_nr,
        main.cust_sid,
        store.sales_company_sid,
        ct.curr_cd
)

SELECT * FROM (
    SELECT 
        main.store_sid,
        main.cashier_nr,
        main.bus_dt,
        main.event_end_hr,
        m.metric_id,
        main.country_org_cd,
        main.curr_cd,
        CASE
            WHEN m.metric_id IN (1710, 170110, 170210, 1810, 1910, 410)
            THEN COALESCE(main.cash_register_event_affected_gross_val, 0)
            ELSE COALESCE(main.cash_register_event_affected_net_val, 0)
        END AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cash_register_event_classification AS main
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
        ON main.scenario_id = s.scenario_id
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
        ON s.scenario_id = m.scenario_id
    WHERE s.scenario_type_cd = 'AUTO'
      AND m.calculation_type_cd = 'SUM'
      AND MOD(m.metric_id, 100) = 10

    UNION ALL

    SELECT 
        store_sid,
        cashier_nr,
        bus_dt,
        event_end_hr,
        -100 AS metric_id,
        country_org_cd,
        curr_cd,
        sales_net_val - return_net_val AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_statistics_by_store_day_cashier

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store_fact.bus_dt,
        store_fact.event_end_hr,
        cashier.metric_id,
        cashier.country_org_cd,
        store_fact.curr_cd,
        COALESCE(cashier_fact.cash_register_event_cnt, 0) AS metric_val_1,
        store_fact.cash_register_event_cnt AS metric_val_2,
        CAST(1 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM (
        SELECT 
            fact.store_sid,
            fact.cashier_nr,
            fact.scenario_id,
            fact.country_org_cd,
            m.metric_id,
            m.calculation_type_cd
        FROM cte_cashier_scenario AS fact
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
            ON fact.scenario_id = s.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
            ON s.scenario_id = m.scenario_id
        WHERE s.scenario_type_cd = 'AUTO'
          AND m.calculation_type_cd = 'LEVELAVG'
    ) AS cashier
    INNER JOIN (
        SELECT 
            main.store_sid,
            main.bus_dt,
            main.scenario_id,
            main.event_end_hr,
            main.country_org_cd,
            m.metric_id,
            SUM(main.cash_register_event_cnt) AS cash_register_event_cnt,
            main.curr_cd
        FROM cte_stores_agg_values AS main
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
            ON main.scenario_id = s.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
            ON s.scenario_id = m.scenario_id
        WHERE s.scenario_type_cd = 'AUTO'
          AND m.calculation_type_cd = 'LEVELAVG'
        GROUP BY 
            main.bus_dt,
            main.event_end_hr,
            main.country_org_cd,
            main.store_sid,
            main.curr_cd,
            main.scenario_id,
            m.metric_id
        
        UNION ALL
        
        SELECT 
            main.store_sid,
            main.bus_dt,
            6 AS scenario_id,
            main.event_end_hr,
            main.country_org_cd,
            601 AS metric_id,
            SUM(main.cash_register_event_cnt) AS cash_register_event_cnt,
            main.curr_cd
        FROM cte_stores_agg_values AS main
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
            ON main.scenario_id = s.scenario_id
        WHERE main.scenario_id IN (60100, 60200)
        GROUP BY 
            main.bus_dt,
            main.event_end_hr,
            main.country_org_cd,
            main.store_sid,
            main.curr_cd
        
        UNION ALL
        
        SELECT 
            main.store_sid,
            main.bus_dt,
            16 AS scenario_id,
            main.event_end_hr,
            main.country_org_cd,
            1601 AS metric_id,
            SUM(main.cash_register_event_cnt) AS cash_register_event_cnt,
            main.curr_cd
        FROM cte_stores_agg_values AS main
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
            ON main.scenario_id = s.scenario_id
        WHERE main.scenario_id IN (160100, 160200)
        GROUP BY 
            main.bus_dt,
            main.event_end_hr,
            main.country_org_cd,
            main.store_sid,
            main.curr_cd
    ) AS store_fact 
        ON cashier.store_sid = store_fact.store_sid AND cashier.metric_id = store_fact.metric_id
    LEFT JOIN (
        SELECT 
            main.store_sid,
            main.cashier_nr,
            main.bus_dt,
            main.event_end_hr,
            main.scenario_id,
            main.country_org_cd,
            m.metric_id,
            main.cash_register_event_cnt,
            main.curr_cd
        FROM cte_cash_register_event_classification AS main
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s0 
            ON main.scenario_id = s0.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
            ON s0.scenario_id = m.scenario_id
        WHERE s0.scenario_type_cd = 'AUTO'
          AND m.calculation_type_cd = 'LEVELAVG'
    ) AS cashier_fact 
        ON cashier.cashier_nr = cashier_fact.cashier_nr 
        AND store_fact.store_sid = cashier_fact.store_sid 
        AND store_fact.metric_id = cashier_fact.metric_id 
        AND store_fact.bus_dt = cashier_fact.bus_dt 
        AND store_fact.curr_cd = cashier_fact.curr_cd 
        AND store_fact.event_end_hr = cashier_fact.event_end_hr

    UNION ALL

    SELECT 
        main.store_sid,
        main.cashier_nr,
        main.bus_dt,
        main.event_end_hr,
        m.metric_id,
        main.country_org_cd,
        main.curr_cd,
        CASE
            WHEN m.metric_id IN (3200) THEN main.cash_register_event_affected_net_val
            WHEN m.metric_id IN (4005, 190805) THEN CAST(main.cust_sid_dst_cnt AS BIGNUMERIC)
            WHEN MOD(m.metric_id, 100) = 15 THEN 1
            WHEN m.metric_id IN (2100, 2200) THEN COALESCE(main.cash_register_event_affected_gross_val, 0)
            WHEN m.metric_id = 3800 THEN CAST(main.cash_register_event_affected_line_cnt AS BIGNUMERIC)
            WHEN m.metric_id IN (602, 60102, 60202) THEN CAST(main.cash_register_entry_cnt AS BIGNUMERIC)
            ELSE CAST(main.cash_register_event_cnt AS BIGNUMERIC)
        END AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cash_register_event_classification AS main
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
        ON main.scenario_id = s.scenario_id
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
        ON s.scenario_id = m.scenario_id
    INNER JOIN cte_cashier_scenario AS cs 
        ON main.store_sid = cs.store_sid 
        AND main.cashier_nr = cs.cashier_nr 
        AND main.scenario_id = cs.scenario_id 
        AND cs.relevant_for_report_fg
    WHERE s.scenario_type_cd = 'AUTO' 
      AND m.calculation_type_cd = 'SUM' 
      AND MOD(m.metric_id, 100) <> 10 
      AND m.metric_id NOT IN (820, 190805)
      OR m.metric_id IN (2100, 2200, 2500, 2600, 2700, 3000, 3100, 3200, 3300, 3600, 3700, 3800, 4000, 4005, 4100, 4200, 602, 60102, 60202)

    UNION ALL

    SELECT 
        main.store_sid,
        main.cashier_nr,
        main.bus_dt,
        main.event_end_hr,
        m.metric_id,
        main.country_org_cd,
        main.curr_cd,
        CASE
            WHEN m.metric_id IN (190805) THEN CAST(main.cust_sid_dst_cnt AS BIGNUMERIC)
            ELSE 0
        END AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_count_cust_dst AS main
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
        ON main.scenario_id = s.scenario_id
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
        ON s.scenario_id = m.scenario_id
    INNER JOIN cte_cashier_scenario AS cs 
        ON main.store_sid = cs.store_sid 
        AND main.cashier_nr = cs.cashier_nr 
        AND main.scenario_id = cs.scenario_id 
        AND cs.relevant_for_report_fg
    WHERE s.scenario_type_cd = 'AUTO'
      AND m.metric_id IN (190805)

    UNION ALL

    SELECT 
        main.store_sid,
        main.cashier_nr,
        main.bus_dt,
        main.event_end_hr,
        m.metric_id,
        main.country_org_cd,
        main.curr_cd,
        CASE
            WHEN m.metric_id IN (3250, 2830, 3830) THEN main.cash_register_event_affected_net_val
            WHEN m.metric_id = 4005 THEN CAST(main.cust_sid_dst_cnt AS BIGNUMERIC)
            WHEN MOD(m.metric_id, 100) = 15 THEN 1
            WHEN m.metric_id IN (2150, 2250, 5650, 5750, 3630, 3640) THEN COALESCE(main.cash_register_event_affected_gross_val, 0)
            ELSE CAST(main.cash_register_event_cnt AS BIGNUMERIC)
        END AS metric_val_1,
        CASE
            WHEN m.metric_id IN (3640) THEN CAST(main.cash_register_event_cnt AS BIGNUMERIC)
            ELSE 0
        END AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cash_register_event_classification AS main
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
        ON main.scenario_id = s.scenario_id
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
        ON s.scenario_id = m.scenario_id
    WHERE m.metric_id IN (2150, 2250, 2550, 2650, 2750, 3050, 3150, 3250, 3350, 3650, 3750, 3850, 4050, 4150, 4250, 2830, 3630, 3640, 3830, 4350, 4450, 4550, 4650, 4850, 4750, 4950, 5050, 5150, 5250, 5450, 5550, 5650, 5610, 5750)

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t151.bus_dt,
        t151.event_end_hr,
        3110 AS metric_id,
        cashier.country_org_cd,
        t151.curr_cd,
        t151.suspended_unresolved_cnt AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, curr_cd
    ) AS t151 ON cashier.store_sid = t151.store_sid
    WHERE cashier.scenario_id = 31
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t168.bus_dt,
        t168.event_end_hr,
        3120 AS metric_id,
        cashier.country_org_cd,
        t168.curr_cd,
        t168.suspended_unresolved_cnt AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(suspended_unresolved_cnt) AS suspended_unresolved_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY sales_company_sid, bus_dt, event_end_hr, curr_cd
    ) AS t168 ON cashier.sales_company_sid = t168.sales_company_sid
    WHERE cashier.scenario_id = 31
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t185.bus_dt,
        t185.event_end_hr,
        3210 AS metric_id,
        cashier.country_org_cd,
        t185.curr_cd,
        t185.abort_net_val AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(abort_net_val) AS abort_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, curr_cd
    ) AS t185 ON cashier.store_sid = t185.store_sid
    WHERE cashier.scenario_id = 32
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t202.bus_dt,
        t202.event_end_hr,
        3220 AS metric_id,
        cashier.country_org_cd,
        t202.curr_cd,
        t202.abort_net_val AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(abort_net_val) AS abort_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY sales_company_sid, bus_dt, event_end_hr, curr_cd
    ) AS t202 ON cashier.sales_company_sid = t202.sales_company_sid
    WHERE cashier.scenario_id = 32
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t219.bus_dt,
        t219.event_end_hr,
        3310 AS metric_id,
        cashier.country_org_cd,
        t219.curr_cd,
        t219.abort_cnt AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(abort_cnt) AS abort_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, curr_cd
    ) AS t219 ON cashier.store_sid = t219.store_sid
    WHERE cashier.scenario_id = 33
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t236.bus_dt,
        t236.event_end_hr,
        3320 AS metric_id,
        cashier.country_org_cd,
        t236.curr_cd,
        t236.abort_cnt AS metric_val_1,
        CAST(0 AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(abort_cnt) AS abort_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY sales_company_sid, bus_dt, event_end_hr, curr_cd
    ) AS t236 ON cashier.sales_company_sid = t236.sales_company_sid
    WHERE cashier.scenario_id = 33
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        t253.bus_dt,
        t253.event_end_hr,
        3400 AS metric_id,
        dim.country_org_cd,
        t253.curr_cd,
        t253.cancelled_line_cnt * 100 AS metric_val_1,
        CAST(t253.event_cnt AS BIGNUMERIC) AS metric_val_2,
        CAST(0 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, cashier_nr, curr_cd, SUM(cancelled_line_cnt) AS cancelled_line_cnt, SUM(event_cnt) AS event_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, cashier_nr, curr_cd
    ) AS t253 ON dim.store_sid = t253.store_sid AND dim.cashier_nr = t253.cashier_nr
    WHERE dim.scenario_id = 34
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        t270.bus_dt,
        t270.event_end_hr,
        3450 AS metric_id,
        dim.country_org_cd,
        t270.curr_cd,
        t270.cancelled_line_cnt * 100 AS scenario_value_1,
        CAST(t270.event_cnt AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, cashier_nr, curr_cd, SUM(cancelled_line_cnt) AS cancelled_line_cnt, SUM(event_cnt) AS event_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, cashier_nr, curr_cd
    ) AS t270 ON dim.store_sid = t270.store_sid AND dim.cashier_nr = t270.cashier_nr
    WHERE dim.scenario_id = 34

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        t287.bus_dt,
        t287.event_end_hr,
        3451 AS metric_id,
        dim.country_org_cd,
        t287.curr_cd,
        t287.cancelled_line_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, cashier_nr, curr_cd, SUM(cancelled_line_cnt) AS cancelled_line_cnt, SUM(event_cnt) AS event_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, cashier_nr, curr_cd
    ) AS t287 ON dim.store_sid = t287.store_sid AND dim.cashier_nr = t287.cashier_nr
    WHERE dim.scenario_id = 34

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        t304.bus_dt,
        t304.event_end_hr,
        3410 AS metric_id,
        dim.country_org_cd,
        t304.curr_cd,
        t304.cancelled_line_cnt * 100 AS scenario_value_1,
        CAST(t304.event_cnt AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(cancelled_line_cnt) AS cancelled_line_cnt, SUM(event_cnt) AS event_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, curr_cd
    ) AS t304 ON dim.store_sid = t304.store_sid
    WHERE dim.scenario_id = 34
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        t321.bus_dt,
        t321.event_end_hr,
        3420 AS metric_id,
        dim.country_org_cd,
        t321.curr_cd,
        t321.cancelled_line_cnt * 100 AS scenario_value_1,
        CAST(t321.event_cnt AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(cancelled_line_cnt) AS cancelled_line_cnt, SUM(event_cnt) AS event_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY sales_company_sid, bus_dt, event_end_hr, curr_cd
    ) AS t321 ON dim.sales_company_sid = t321.sales_company_sid
    WHERE dim.scenario_id = 34
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        csh.store_sid,
        csh.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        3500 AS metric_id,
        cl.country_org_cd,
        csh.curr_cd,
        csh.cancelled_net_val * 100 AS scenario_value_1,
        COALESCE(csh.sales_net_val, 0) - COALESCE(csh.return_net_val, 0) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cl
    INNER JOIN cte_statistics_by_store_day_cashier AS csh 
        ON cl.store_sid = csh.store_sid AND cl.cashier_nr = csh.cashier_nr
    WHERE cl.scenario_id = 35
      AND cl.relevant_for_report_fg

    UNION ALL

    SELECT 
        csh.store_sid,
        csh.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        3550 AS metric_id,
        cl.country_org_cd,
        csh.curr_cd,
        csh.cancelled_net_val * 100 AS scenario_value_1,
        COALESCE(csh.sales_net_val, 0) - COALESCE(csh.return_net_val, 0) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cl
    INNER JOIN cte_statistics_by_store_day_cashier AS csh 
        ON cl.store_sid = csh.store_sid AND cl.cashier_nr = csh.cashier_nr
    WHERE cl.scenario_id = 35

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        3510 AS metric_id,
        dim.country_org_cd,
        csh.curr_cd,
        csh.cancelled_net_val * 100 AS scenario_value_1,
        CAST(csh.total_net_val AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(cancelled_net_val) AS cancelled_net_val, SUM(sales_net_val - return_net_val) AS total_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS csh ON dim.store_sid = csh.store_sid
    WHERE dim.scenario_id = 35
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        3520 AS metric_id,
        dim.country_org_cd,
        csh.curr_cd,
        csh.cancelled_net_val * 100 AS scenario_value_1,
        csh.total_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(cancelled_net_val) AS cancelled_net_val, SUM(sales_net_val - return_net_val) AS total_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS csh ON dim.sales_company_sid = csh.sales_company_sid
    WHERE dim.scenario_id = 35
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        csh.store_sid,
        csh.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        2900 AS metric_id,
        dim.country_org_cd,
        csh.curr_cd,
        csh.return_net_val * 100 AS scenario_value_1,
        COALESCE(csh.sales_net_val, 0) - COALESCE(csh.return_net_val, 0) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN cte_statistics_by_store_day_cashier AS csh 
        ON dim.store_sid = csh.store_sid AND dim.cashier_nr = csh.cashier_nr
    WHERE dim.scenario_id = 29
      AND dim.relevant_for_report_fg
      AND NOT csh.is_outlier_day_return_fg

    UNION ALL

    SELECT 
        csh.store_sid,
        csh.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        2950 AS metric_id,
        dim.country_org_cd,
        csh.curr_cd,
        csh.return_net_val * 100 AS scenario_value_1,
        COALESCE(csh.sales_net_val, 0) - COALESCE(csh.return_net_val, 0) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN cte_statistics_by_store_day_cashier AS csh 
        ON dim.store_sid = csh.store_sid AND dim.cashier_nr = csh.cashier_nr
    WHERE dim.scenario_id = 29

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        2910 AS metric_id,
        dim.country_org_cd,
        csh.curr_cd,
        CAST(csh.return_net_val AS BIGNUMERIC) * 100 AS scenario_value_1,
        csh.total_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(return_net_val) AS return_net_val, SUM(sales_net_val - return_net_val) AS total_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS csh ON dim.store_sid = csh.store_sid
    WHERE dim.scenario_id = 29
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        csh.bus_dt,
        csh.event_end_hr,
        2920 AS metric_id,
        dim.country_org_cd,
        csh.curr_cd,
        csh.return_net_val * 100 AS scenario_value_1,
        csh.total_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(return_net_val) AS return_net_val, SUM(sales_net_val - return_net_val) AS total_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS csh ON dim.sales_company_sid = csh.sales_company_sid
    WHERE dim.scenario_id = 29
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2610 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.return_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(return_cnt) AS return_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS store ON cashier.store_sid = store.store_sid
    WHERE cashier.scenario_id = 26
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2620 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.return_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(return_cnt) AS return_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS store ON cashier.sales_company_sid = store.sales_company_sid
    WHERE cashier.scenario_id = 26
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2710 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.cash_register_event_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(cash_register_event_cnt) AS cash_register_event_cnt
        FROM (SELECT * FROM cte_cash_register_event_classification) AS t502
        GROUP BY store_sid, bus_dt, event_end_hr, curr_cd
    ) AS store ON cashier.store_sid = store.store_sid
    WHERE cashier.scenario_id = 27
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2720 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.cash_register_event_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(cash_register_event_cnt) AS cash_register_event_cnt
        FROM (SELECT * FROM cte_cash_register_event_classification) AS t527
        GROUP BY sales_company_sid, bus_dt, event_end_hr, curr_cd
    ) AS store ON cashier.sales_company_sid = store.sales_company_sid
    WHERE cashier.scenario_id = 27
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cl.store_sid,
        cl.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        2800 AS metric_id,
        cl.country_org_cd,
        cl.curr_cd,
        cl.cash_register_event_affected_net_val AS scenario_value_1,
        CAST(cl.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cash_register_event_classification AS cl
    INNER JOIN cte_cashier_scenario AS cashier 
        ON cl.store_sid = cashier.store_sid AND cl.cashier_nr = cashier.cashier_nr AND cl.scenario_id = cashier.scenario_id
    WHERE cl.scenario_id = 28
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cl.store_sid,
        cl.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        2850 AS metric_id,
        cl.country_org_cd,
        cl.curr_cd,
        cl.cash_register_event_affected_net_val AS scenario_value_1,
        CAST(cl.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cash_register_event_classification AS cl
    INNER JOIN cte_cashier_scenario AS cashier 
        ON cl.store_sid = cashier.store_sid AND cl.cashier_nr = cashier.cashier_nr AND cl.scenario_id = cashier.scenario_id
    WHERE cl.scenario_id = 28

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        2810 AS metric_id,
        dim.country_org_cd,
        cl.curr_cd,
        cl.cash_register_event_affected_net_val AS scenario_value_1,
        CAST(cl.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT store_sid, scenario_id, bus_dt, event_end_hr, curr_cd, SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val, SUM(cash_register_event_cnt) AS cash_register_event_cnt
        FROM cte_cash_register_event_classification
        WHERE scenario_id = 28
        GROUP BY store_sid, scenario_id, bus_dt, event_end_hr, curr_cd
    ) AS cl ON dim.store_sid = cl.store_sid
    WHERE dim.scenario_id = 28
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        2820 AS metric_id,
        dim.country_org_cd,
        cl.curr_cd,
        cl.cash_register_event_affected_net_val AS scenario_value_1,
        CAST(cl.cash_register_event_cnt AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT sales_company_sid, scenario_id, bus_dt, event_end_hr, curr_cd, SUM(cash_register_event_affected_net_val) AS cash_register_event_affected_net_val, SUM(cash_register_event_cnt) AS cash_register_event_cnt
        FROM cte_cash_register_event_classification
        WHERE scenario_id = 28
        GROUP BY sales_company_sid, scenario_id, bus_dt, event_end_hr, curr_cd
    ) AS cl ON dim.sales_company_sid = cl.sales_company_sid
    WHERE dim.scenario_id = 28
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        3010 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.return_without_receipt_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS store ON cashier.store_sid = store.store_sid
    WHERE cashier.scenario_id = 30
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        3020 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.return_without_receipt_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(return_without_receipt_cnt) AS return_without_receipt_cnt
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS store ON cashier.sales_company_sid = store.sales_company_sid
    WHERE cashier.scenario_id = 30
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        fact.store_sid,
        fact.cashier_nr,
        fact.bus_dt,
        fact.event_end_hr,
        2400 AS metric_id,
        fact.country_org_cd,
        fact.curr_cd,
        fact.cash_register_event_cnt / 2 AS scenario_value_1,
        CAST(1 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cash_register_event_classification AS fact
    INNER JOIN cte_cashier_scenario AS cashier 
        ON fact.store_sid = cashier.store_sid AND fact.cashier_nr = cashier.cashier_nr AND fact.scenario_id = cashier.scenario_id
    WHERE fact.scenario_id = 24
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        store_sid,
        cashier_nr,
        bus_dt,
        event_end_hr,
        2450 AS metric_id,
        country_org_cd,
        curr_cd,
        cash_register_event_cnt / 2 AS scenario_value_1,
        CAST(1 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cash_register_event_classification
    WHERE scenario_id = 24

    UNION ALL

    SELECT 
        store_sid,
        cashier_nr,
        bus_dt,
        event_end_hr,
        2451 AS metric_id,
        country_org_cd,
        curr_cd,
        cash_register_event_cnt / 2 AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cash_register_event_classification
    WHERE scenario_id = 24

    UNION ALL

    SELECT 
        store_sid,
        cashier_nr,
        bus_dt,
        event_end_hr,
        2452 AS metric_id,
        country_org_cd,
        curr_cd,
        cash_register_event_cnt / 2 AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cash_register_event_classification
    WHERE scenario_id = 24

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2110 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.deposit_only_return_gross_val AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(cash_register_event_affected_gross_val) AS deposit_only_return_gross_val
        FROM cte_cash_register_event_classification
        WHERE scenario_id = 21
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS store ON cashier.store_sid = store.store_sid
    WHERE cashier.scenario_id = 21
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2120 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.deposit_only_return_gross_val AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(cash_register_event_affected_gross_val) AS deposit_only_return_gross_val
        FROM cte_cash_register_event_classification
        WHERE scenario_id = 21
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS store ON cashier.sales_company_sid = store.sales_company_sid
    WHERE cashier.scenario_id = 21
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2210 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.deposit_return_manual_input_gross_val AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
        FROM cte_statistics_by_store_day_cashier
        WHERE deposit_return_manual_input_gross_val > 0
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS store ON cashier.store_sid = store.store_sid
    WHERE cashier.scenario_id = 22
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        2220 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.deposit_return_manual_input_gross_val AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(deposit_return_manual_input_gross_val) AS deposit_return_manual_input_gross_val
        FROM cte_statistics_by_store_day_cashier
        WHERE deposit_return_manual_input_gross_val > 0
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS store ON cashier.sales_company_sid = store.sales_company_sid
    WHERE cashier.scenario_id = 22
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cl.store_sid,
        cl.cashier_nr,
        fact.bus_dt,
        fact.event_end_hr,
        2300 AS metric_id,
        cl.country_org_cd,
        fact.curr_cd,
        fact.deposit_return_net_val * 100 AS scenario_value_1,
        fact.deposit_sales_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cl
    INNER JOIN cte_statistics_by_store_day_cashier AS fact 
        ON cl.cashier_nr = fact.cashier_nr AND cl.store_sid = fact.store_sid
    WHERE cl.scenario_id = 23
      AND cl.relevant_for_report_fg

    UNION ALL

    SELECT 
        cl.store_sid,
        cl.cashier_nr,
        fact.bus_dt,
        fact.event_end_hr,
        2350 AS metric_id,
        cl.country_org_cd,
        fact.curr_cd,
        fact.deposit_return_net_val * 100 AS scenario_value_1,
        fact.deposit_sales_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cl
    INNER JOIN cte_statistics_by_store_day_cashier AS fact 
        ON cl.cashier_nr = fact.cashier_nr AND cl.store_sid = fact.store_sid
    WHERE cl.scenario_id = 23

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        2310 AS metric_id,
        dim.country_org_cd,
        cl.curr_cd,
        cl.deposit_return_net_val * 100 AS scenario_value_1,
        CAST(cl.deposit_sales_net_val AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT store_sid, bus_dt, event_end_hr, curr_cd, SUM(deposit_return_net_val) AS deposit_return_net_val, SUM(deposit_sales_net_val) AS deposit_sales_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY store_sid, bus_dt, event_end_hr, curr_cd
    ) AS cl ON dim.store_sid = cl.store_sid
    WHERE dim.scenario_id = 23
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        dim.store_sid,
        dim.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        2320 AS metric_id,
        dim.country_org_cd,
        cl.curr_cd,
        cl.deposit_return_net_val * 100 AS scenario_value_1,
        CAST(cl.deposit_sales_net_val AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS dim
    INNER JOIN (
        SELECT sales_company_sid, bus_dt, event_end_hr, curr_cd, SUM(deposit_return_net_val) AS deposit_return_net_val, SUM(deposit_sales_net_val) AS deposit_sales_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY sales_company_sid, bus_dt, event_end_hr, curr_cd
    ) AS cl ON dim.sales_company_sid = cl.sales_company_sid
    WHERE dim.scenario_id = 23
      AND dim.relevant_for_report_fg

    UNION ALL

    SELECT 
        cl.store_sid,
        cl.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        420 AS metric_id,
        cl.country_org_cd,
        cl.curr_cd,
        COALESCE(dim.cash_register_event_affected_net_val, 0) AS scenario_value_1,
        cl.deposit_return_manual_input_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_statistics_by_store_day_cashier AS cl
    LEFT JOIN cte_cash_register_event_classification AS dim 
        ON cl.store_sid = dim.store_sid AND cl.cashier_nr = dim.cashier_nr AND cl.bus_dt = dim.bus_dt AND cl.curr_cd = dim.curr_cd AND cl.event_end_hr = dim.event_end_hr AND dim.scenario_id = 4

    UNION ALL

    SELECT 
        cl.store_sid,
        cl.cashier_nr,
        cl.bus_dt,
        cl.event_end_hr,
        430 AS metric_id,
        cl.country_org_cd,
        cl.curr_cd,
        COALESCE(dim.cash_register_event_affected_net_val, 0) AS scenario_value_1,
        cl.deposit_only_return_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_statistics_by_store_day_cashier AS cl
    LEFT JOIN cte_cash_register_event_classification AS dim 
        ON cl.store_sid = dim.store_sid AND cl.cashier_nr = dim.cashier_nr AND cl.bus_dt = dim.bus_dt AND cl.curr_cd = dim.curr_cd AND cl.event_end_hr = dim.event_end_hr AND dim.scenario_id = 4

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t891.bus_dt,
        t891.event_end_hr,
        3610 AS metric_id,
        cashier.country_org_cd,
        t891.curr_cd,
        t891.price_info_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(price_info_cnt) AS price_info_cnt
        FROM cte_statistics_by_store_day_cashier
        WHERE price_info_cnt > 0
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS t891 ON cashier.store_sid = t891.store_sid
    WHERE cashier.scenario_id = 36
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t908.bus_dt,
        t908.event_end_hr,
        3620 AS metric_id,
        cashier.country_org_cd,
        t908.curr_cd,
        t908.price_info_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(price_info_cnt) AS price_info_cnt
        FROM cte_statistics_by_store_day_cashier
        WHERE price_info_cnt > 0
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS t908 ON cashier.sales_company_sid = t908.sales_company_sid
    WHERE cashier.scenario_id = 36
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t933.bus_dt,
        t933.event_end_hr,
        3810 AS metric_id,
        cashier.country_org_cd,
        t933.curr_cd,
        t933.discount_line_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(cash_register_event_affected_line_cnt) AS discount_line_cnt
        FROM cte_cash_register_event_classification
        WHERE scenario_id = 38
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS t933 ON cashier.store_sid = t933.store_sid
    WHERE cashier.scenario_id = 38
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        t958.bus_dt,
        t958.event_end_hr,
        3820 AS metric_id,
        cashier.country_org_cd,
        t958.curr_cd,
        t958.discount_line_cnt AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(cash_register_event_affected_line_cnt) AS discount_line_cnt
        FROM cte_cash_register_event_classification
        WHERE scenario_id = 38
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS t958 ON cashier.sales_company_sid = t958.sales_company_sid
    WHERE cashier.scenario_id = 38
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        3910 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.discount_net_val * 100 AS scenario_value_1,
        store.total_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, store_sid, curr_cd, SUM(discount_net_val) AS discount_net_val, SUM(sales_net_val - return_net_val) AS total_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, store_sid, curr_cd
    ) AS store ON cashier.store_sid = store.store_sid
    WHERE cashier.scenario_id = 39
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store.bus_dt,
        store.event_end_hr,
        3920 AS metric_id,
        cashier.country_org_cd,
        store.curr_cd,
        store.discount_net_val * 100 AS scenario_value_1,
        store.total_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN (
        SELECT bus_dt, event_end_hr, sales_company_sid, curr_cd, SUM(discount_net_val) AS discount_net_val, SUM(sales_net_val - return_net_val) AS total_net_val
        FROM cte_statistics_by_store_day_cashier
        GROUP BY bus_dt, event_end_hr, sales_company_sid, curr_cd
    ) AS store ON cashier.sales_company_sid = store.sales_company_sid
    WHERE cashier.scenario_id = 39
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        fact.bus_dt,
        fact.event_end_hr,
        3900 AS metric_id,
        cashier.country_org_cd,
        fact.curr_cd,
        fact.discount_net_val * 100 AS scenario_value_1,
        fact.sales_net_val - fact.return_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN cte_statistics_by_store_day_cashier AS fact 
        ON cashier.store_sid = fact.store_sid AND cashier.cashier_nr = fact.cashier_nr
    WHERE cashier.scenario_id = 39
      AND cashier.relevant_for_report_fg

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        fact.bus_dt,
        fact.event_end_hr,
        3950 AS metric_id,
        cashier.country_org_cd,
        fact.curr_cd,
        fact.discount_net_val * 100 AS scenario_value_1,
        fact.sales_net_val - fact.return_net_val AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cashier_scenario AS cashier
    INNER JOIN cte_statistics_by_store_day_cashier AS fact 
        ON cashier.store_sid = fact.store_sid AND cashier.cashier_nr = fact.cashier_nr
    WHERE cashier.scenario_id = 39

    UNION ALL

    SELECT 
        store_sid,
        cashier_nr,
        bus_dt,
        event_end_hr,
        5620 AS metric_id,
        country_org_cd,
        curr_cd,
        CASE WHEN scenario_id = 22 THEN COALESCE(cash_register_event_affected_gross_val, 0) ELSE 0 END AS scenario_value_1,
        CASE WHEN scenario_id = 56 THEN COALESCE(cash_register_event_affected_gross_val, 0) ELSE 0 END AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM cte_cash_register_event_classification
    WHERE scenario_id IN (56, 22)

    UNION ALL

    SELECT 
        cls.store_sid,
        cls.cashier_nr,
        clr.rel_bus_dt,
        cls.event_end_hr,
        820 AS metric_id,
        cls.country_org_cd,
        ct.curr_cd,
        COUNT(DISTINCT clr.rel_cash_register_event_sid) AS scenario_value_1,
        CAST(0 AS BIGNUMERIC) AS scenario_value_2,
        CAST(0 AS BIGNUMERIC) AS scenario_value_3,
        CAST(0 AS BIGNUMERIC) AS scenario_value_4
    FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_1 AS cls
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_1 AS clr 
        ON cls.bus_dt = clr.bus_dt 
        AND cls.country_org_cd = clr.country_org_cd 
        AND cls.cash_register_event_sid = clr.cash_register_event_sid
    INNER JOIN ldl_data_production_core_dim.t_dim_country_1 AS ct 
        ON cls.country_org_cd = ct.iso_country_cd
    WHERE cls.scenario_id = 8
      AND clr.cash_register_event_rel_type_cd = 'ORIGINAL'
    GROUP BY 
        cls.scenario_id,
        cls.country_org_cd,
        cls.store_sid,
        cls.cashier_nr,
        cls.event_end_hr,
        clr.rel_bus_dt,
        ct.curr_cd

    UNION ALL

    SELECT 
        cashier.store_sid,
        cashier.cashier_nr,
        store_fact.bus_dt,
        store_fact.event_end_hr,
        cashier.metric_id,
        cashier.country_org_cd,
        store_fact.curr_cd,
        COALESCE(cashier_fact.cash_register_event_cnt, 0) AS metric_val_1,
        store_fact.cash_register_event_cnt AS metric_val_2,
        CAST(1 AS BIGNUMERIC) AS metric_val_3,
        CAST(0 AS BIGNUMERIC) AS metric_val_4
    FROM (
        SELECT 
            fact.store_sid,
            fact.cashier_nr,
            fact.scenario_id,
            fact.country_org_cd,
            m.metric_id,
            m.calculation_type_cd
        FROM cte_cashier_scenario AS fact
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s 
            ON fact.scenario_id = s.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m 
            ON s.scenario_id = m.scenario_id
        WHERE s.scenario_type_cd = 'AUTO'
          AND m.calculation_type_cd = 'LEVELAVG'
          AND m.metric_id = 2001
    ) AS cashier
    INNER JOIN (
        SELECT 
            main.store_sid,
            main.bus_dt,
            main.scenario_id,
            main.event_end_hr,
            main.country_org_cd,
            m0.metric_id,
            SUM(main.cash_register_event_cnt) AS cash_register_event_cnt,
            main.curr_cd
        FROM cte_cash_register_event_classification AS main
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s1 
            ON main.scenario_id = s1.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m0 
            ON s1.scenario_id = m0.scenario_id
        WHERE s1.scenario_type_cd = 'AUTO'
          AND m0.calculation_type_cd = 'LEVELAVG'
          AND m0.metric_id = 2001
        GROUP BY 
            main.country_org_cd,
            main.store_sid,
            main.scenario_id,
            main.bus_dt,
            main.event_end_hr,
            main.curr_cd,
            m0.metric_id
    ) AS store_fact 
        ON cashier.store_sid = store_fact.store_sid AND cashier.metric_id = store_fact.metric_id
    LEFT JOIN (
        SELECT 
            main.store_sid,
            main.cashier_nr,
            main.bus_dt,
            main.event_end_hr,
            main.scenario_id,
            main.country_org_cd,
            m1.metric_id,
            main.cash_register_event_cnt,
            main.curr_cd
        FROM cte_cash_register_event_classification AS main
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s2 
            ON main.scenario_id = s2.scenario_id
        INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS m1 
            ON s2.scenario_id = m1.scenario_id
        WHERE s2.scenario_type_cd = 'AUTO'
          AND m1.calculation_type_cd = 'LEVELAVG'
          AND m1.metric_id = 2001
    ) AS cashier_fact 
        ON cashier.cashier_nr = cashier_fact.cashier_nr 
        AND store_fact.store_sid = cashier_fact.store_sid 
        AND store_fact.metric_id = cashier_fact.metric_id 
        AND store_fact.bus_dt = cashier_fact.bus_dt 
        AND store_fact.curr_cd = cashier_fact.curr_cd 
        AND store_fact.event_end_hr = cashier_fact.event_end_hr
);