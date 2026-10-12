CREATE OR REPLACE TABLE FUNCTION 
  ldl_production_p_lew_mart_pit.f_gettableparamsnormailized(
    pclientid INT64,
    ppitmanualrunfg INT64,
    ppitmanualcountrylist STRING
)
AS (
WITH pa AS (
    SELECT 
          pa.client_id AS client_id
        , MAX(IF(UPPER(TRIM(par.param_name)) = 'START_DT_PIT_DATA', PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS start_dt_pit_data
        , MAX(IF(UPPER(TRIM(par.param_name)) = 'END_DT_PIT_DATA', PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS end_dt_pit_data
        , MAX(IF(UPPER(TRIM(par.param_name)) = 'NEXT_RUN_DT_REAGG', PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS next_run_dt_reagg
        , MAX(IF(par.param_name = 'CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS cnt_data_history_pit_in_adv_weeks
        , MAX(IF(par.param_name = 'CNT_DATA_HISTORY_PIT_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS cnt_data_history_pit_in_days
        , MAX(IF(par.param_name = 'CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS cnt_intermediate_period_in_adv_weeks
        , MAX(IF(par.param_name = 'CNT_INTERMEDIATE_PERIOD_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS cnt_intermediate_period_in_days
        , MAX(IF(par.param_name = 'START_DT_INTERMEDIATE', PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS start_dt_intermediate
        , MAX(IF(par.param_name = 'END_DT_INTERMEDIATE', PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS end_dt_intermediate
        , MAX(IF(par.param_name = 'START_ADV_WEEK_INTERMEDIATE', CAST(pa.param_value AS INT64), NULL)) AS start_adv_week_intermediate
        , MAX(IF(par.param_name = 'END_ADV_WEEK_INTERMEDIATE', CAST(pa.param_value AS INT64), NULL)) AS end_adv_week_intermediate
        , MAX(IF(par.param_name = 'CNT_REAGG_PERIOD_IN_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS cnt_reagg_period_in_adv_weeks
        , MAX(IF(par.param_name = 'CNT_REAGG_PERIOD_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS cnt_reagg_period_in_days
        , MAX(IF(par.param_name = 'START_DT_REAGG', PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS start_dt_reagg
        , MAX(IF(par.param_name = 'END_DT_REAGG', PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS end_dt_reagg
        , MAX(IF(par.param_name = 'START_ADV_WEEK_REAGG', CAST(pa.param_value AS INT64), NULL)) AS start_adv_week_reagg
        , MAX(IF(par.param_name = 'END_ADV_WEEK_REAGG', CAST(pa.param_value AS INT64), NULL)) AS end_adv_week_reagg
        , MAX(IF(par.param_name = 'CNT_BASELINE_ADV_WEEK', CAST(pa.param_value AS INT64), NULL)) AS cnt_baseline_adv_week        
        , MAX(IF(par.param_name = 'LOC_TIME_GAPS_OPENING_DAYS', CAST(pa.param_value AS INT64), NULL)) AS loc_time_gaps_opening_days
        , MAX(IF(par.param_name = 'LOC_TIME_GAPS_CLOSING_DAYS', CAST(pa.param_value AS INT64), NULL)) AS loc_time_gaps_closing_days
        , MAX(IF(par.param_name = 'WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS wh_buying_price_add_period_in_days        
        , MAX(IF(par.param_name = 'LOC_STORE_SALES_NET_VAL_GT', CAST(pa.param_value AS NUMERIC), NULL)) AS loc_store_sales_net_val_gt
        , MAX(IF(par.param_name = 'LOC_STORE_SALES_QTY_GT', CAST(pa.param_value AS NUMERIC), NULL)) AS loc_store_sales_qty_gt        
        , MAX(IF(par.param_name = 'ADP_TIME_GAP_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS adp_time_gap_in_days
        , MAX(IF(par.param_name = 'CTR_ADV_WEEK_START_WEEKDAY_ID', CAST(pa.param_value AS INT64), NULL)) AS ctr_adv_week_start_weekday_id
        , MAX(IF(par.param_name = 'CTR_STORE_NBR', CAST(pa.param_value AS NUMERIC), NULL)) AS ctr_store_nbr
        , MAX(IF(par.param_name = 'CTR_EX_ELVIS_COUNTRY_FG', CAST(pa.param_value AS INT64), 0)) AS ctr_ex_elvis_country_fg        
        , MAX(IF(par.param_name = 'START_DT_BASE_METRIC_NF_FA', CAST(pa.param_value AS INT64), NULL)) AS start_dt_base_metric_nf_fa
        , MAX(IF(par.param_name = 'END_DT_BASE_METRIC_NF_FA', CAST(pa.param_value AS INT64), NULL)) AS end_dt_base_metric_nf_fa
        , MAX(IF(par.param_name = 'START_DT_DELIV_QTY', CAST(pa.param_value AS INT64), NULL)) AS start_dt_deliv_qty
        , MAX(IF(par.param_name = 'END_DT_DELIV_QTY', CAST(pa.param_value AS INT64), NULL)) AS end_dt_deliv_qty        
        , MAX(IF(par.param_name = 'START_DT_STC_REAL_QTY', CAST(pa.param_value AS INT64), NULL)) AS start_dt_stc_real_qty
        , MAX(IF(par.param_name = 'END_DT_STC_REAL_QTY', CAST(pa.param_value AS INT64), NULL)) AS end_dt_stc_real_qty        
        , MAX(IF(par.param_name = 'EXEC_PIT_DAILY_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_daily_run_fg
        , MAX(IF(par.param_name = 'EXEC_PIT_WEEKLY_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_weekly_run_fg
        , MAX(IF(par.param_name = 'EXEC_PIT_DQ_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_dq_run_fg
        , MAX(IF(par.param_name = 'EXEC_PIT_MANUAL_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_manual_run_fg        
        , MAX(IF(par.param_name = 'EXEC_PIT_MANUAL_COUNTRY_LST', pa.param_value_char, NULL)) AS exec_pit_manual_country_lst        
        , MAX(IF(par.param_name = 'EXEC_PIT_RUN_WEEKLY_WEEKDAY', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_run_weekly_weekday
        , MAX(IF(par.param_name = 'EXEC_PIT_CNT_INITIAL_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_cnt_initial_adv_weeks
        , MAX(IF(par.param_name = 'EXEC_PIT_AB_PARALLEL_EXECUTION', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_ab_parallel_execution        
        , MAX(IF(par.param_name = 'EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_sf_credit_timerange_in_days
        , MAX(IF(par.param_name = 'DEFAULT_PIT_MANUAL_RUN_FG', CAST(pa.param_value AS INT64), NULL)) AS default_pit_manual_run_fg        
        , MAX(IF(par.param_name = 'PIT_MAX_DATA_HISTORY_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS pit_max_data_history_in_days
        , MAX(IF(par.param_name = 'PIT_MAX_DATA_HISTORY_IN_ADV_WEEK', CAST(pa.param_value AS INT64), NULL)) AS pit_max_data_history_in_adv_week        
        , MAX(IF(par.param_name = 'WAWI_PRICE_CHANGE_GAP_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS wawi_price_change_gap_in_days
        , MAX(IF(par.param_name = 'PV_PERIOD_LENGTH_MAX', CAST(pa.param_value AS INT64), NULL)) AS pv_period_length_max
        , MAX(IF(par.param_name = 'PV_PERIOD_GAP_SPLITTING_DAYS', CAST(pa.param_value AS INT64), NULL)) AS pv_period_gap_splitting_days        
        , MAX(IF(par.param_name = 'LP_ORIG_COUPON_TYPE_SID', pa.param_value_char, NULL)) AS lp_orig_coupon_type_sid
        , MAX(IF(par.param_name = 'LP_COUPON_PROMO_TYPE_SID', pa.param_value_char, NULL)) AS lp_coupon_promo_type_sid        
        , MAX(IF(par.param_name = 'FA_OVERLAP_PERIOD_ACTION_TYPE_CONDITION', pa.param_value_char, NULL)) AS fa_overlap_period_action_type_condition
        , MAX(IF(par.param_name = 'REJECT_PERIOD', pa.param_value_char, NULL)) AS reject_period        
        , MAX(IF(par.param_name = 'LP_SHIFT_PERIOD_START_DT', CAST(pa.param_value AS INT64), NULL)) AS lp_shift_period_start_dt
        , MAX(IF(par.param_name = 'REJECT_WAWI_PV_LONG_PERIOD', CAST(pa.param_value AS INT64), NULL)) AS reject_wawi_pv_long_period
    FROM (
        /* PARAM */
        SELECT 
              client_id,
              param_id,
              param_value,
              param_value_char,
              version_nr
        FROM ldl_production_p_lew_mart_pit.t_cntl_processing_param
        WHERE
            CURRENT_DATE() BETWEEN valid_from_dt AND valid_to_dt
            AND deleted_fg = 0
            AND reject_fg = 0
            AND (pclientid = -1 OR client_id = pclientid)
        QUALIFY version_nr = MAX(version_nr) OVER (PARTITION BY client_id, param_id)
    ) pa
    
    /* PARAM REF */
    JOIN (
        SELECT 
            param_id,
            param_name
        FROM ldl_production_p_lew_mart_pit.t_cntl_dim_processing_param
        WHERE deleted_fg = 0 AND reject_fg = 0  -- Deduplication
        QUALIFY ROW_NUMBER() OVER(PARTITION BY param_id ORDER BY dwh_updated_ts DESC) = 1
    ) par
    ON pa.param_id = par.param_id
    GROUP BY pa.client_id
)
SELECT *
FROM pa
WHERE start_dt_reagg IS NOT NULL
  AND end_dt_reagg IS NOT NULL
  AND next_run_dt_reagg IS NOT NULL
  -- AKU 2022-10-20 Issue in preparing param, this is not needed for weekly PIT runs only Daily run
  --AND pa.NEXT_RUN_DT_REAGG <> TO_DATE(''8888-12-31'',''YYYY-MM-DD'')
  AND (
        -- Scheduled ReAgg - running on Weekdays
        (ppitmanualrunfg = 0 
         AND exec_pit_manual_run_fg = 0
         AND exec_pit_run_weekly_weekday = MOD(EXTRACT(DAYOFWEEK FROM CURRENT_DATE()) + 5, 7) + 1)
        OR
        -- Scheduled ReAgg - running on every day based on clients in param Table
        (ppitmanualrunfg = 3 AND exec_pit_manual_run_fg = 3)
        OR
        -- Manual test ReAgg Process - triggered by Operator
        (
            ppitmanualrunfg = 1 
            AND exec_pit_manual_run_fg = 1
            AND client_id IN (
                SELECT CAST(val AS INT64) as value
                FROM UNNEST(SPLIT(ppitmanualcountrylist, ',')) AS val
                WHERE TRIM(val) <> ''
                AND length(trim(val, ' ')) > 0
                GROUP by 1
            )
        )
        OR 
        -- Initialize Data Process - triggered by Operator
        (
            ppitmanualrunfg = 2
            AND (pclientid = -1 OR client_id = pclientid)
            AND 
            (
                    PCLIENTID IS NULL
     OR length(trim(cast(PCLIENTID as string), ' ')) <= NUMERIC '0'
								OR
							client_id IN (
                SELECT CAST(val AS INT64)
                FROM UNNEST(SPLIT(ppitmanualcountrylist, ',')) AS val
                WHERE TRIM(val) <> ''
                AND length(trim(val, ' ')) > 0
                GROUP by 1
            )
            )
            
        )
    )
);