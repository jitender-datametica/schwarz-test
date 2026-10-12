CREATE OR REPLACE table FUNCTION ldl_production_p_lew_mart_pit.f_gettableparamsnormalisedpsnf(
  pclientid INT64,
  ppitmanualrunfg INT64,
  ppitmanualcountrylist STRING
)
RETURNS TABLE<
  client_id INT64,
  start_dt_pit_data DATE,
  end_dt_pit_data DATE,
  next_run_dt_reagg DATE,
  cnt_data_history_pit_in_adv_weeks INT64,
  cnt_data_history_pit_in_days INT64,
  cnt_intermediate_period_in_adv_weeks INT64,
  cnt_intermediate_period_in_days INT64,
  start_dt_intermediate DATE,
  end_dt_intermediate DATE,
  start_adv_week_intermediate INT64,
  end_adv_week_intermediate INT64,
  cnt_reagg_period_in_adv_weeks INT64,
  cnt_reagg_period_in_days INT64,
  start_dt_reagg DATE,
  end_dt_reagg DATE,
  start_adv_week_reagg INT64,
  end_adv_week_reagg INT64,
  cnt_baseline_adv_week INT64,
  loc_time_gaps_opening_days INT64,
  loc_time_gaps_closing_days INT64,
  wh_buying_price_add_period_in_days INT64,
  loc_store_sales_net_val_gt NUMERIC,
  loc_store_sales_qty_gt NUMERIC,
  adp_time_gap_in_days INT64,
  ctr_adv_week_start_weekday_id INT64,
  ctr_store_nbr NUMERIC,
  ctr_ex_elvis_country_fg INT64,
  start_dt_base_metric_nf_fa INT64,
  end_dt_base_metric_nf_fa INT64,
  start_dt_deliv_qty INT64,
  end_dt_deliv_qty INT64,
  start_dt_stc_real_qty INT64,
  end_dt_stc_real_qty INT64,
  exec_pit_daily_run_fg INT64,
  exec_pit_weekly_run_fg INT64,
  exec_pit_dq_run_fg INT64,
  exec_pit_manual_run_fg INT64,
  exec_pit_manual_country_lst STRING,
  exec_pit_run_weekly_weekday INT64,
  exec_pit_cnt_initial_adv_weeks INT64,
  exec_pit_ab_parallel_execution INT64,
  exec_pit_sf_credit_timerange_in_days INT64,
  default_pit_manual_run_fg INT64,
  pit_max_data_history_in_days INT64,
  pit_max_data_history_in_adv_week INT64
>
AS (
  WITH pa AS (
    SELECT 
      pa.client_id,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_DT_PIT_DATA', SAFE.PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS start_dt_pit_data,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_DT_PIT_DATA', SAFE.PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS end_dt_pit_data,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'NEXT_RUN_DT_REAGG', SAFE.PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS next_run_dt_reagg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS cnt_data_history_pit_in_adv_weeks,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CNT_DATA_HISTORY_PIT_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS cnt_data_history_pit_in_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS cnt_intermediate_period_in_adv_weeks,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CNT_INTERMEDIATE_PERIOD_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS cnt_intermediate_period_in_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_DT_INTERMEDIATE', SAFE.PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS start_dt_intermediate,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_DT_INTERMEDIATE', SAFE.PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS end_dt_intermediate,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_ADV_WEEK_INTERMEDIATE', CAST(pa.param_value AS INT64), NULL)) AS start_adv_week_intermediate,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_ADV_WEEK_INTERMEDIATE', CAST(pa.param_value AS INT64), NULL)) AS end_adv_week_intermediate,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CNT_REAGG_PERIOD_IN_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS cnt_reagg_period_in_adv_weeks,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CNT_REAGG_PERIOD_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS cnt_reagg_period_in_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_DT_REAGG', SAFE.PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS start_dt_reagg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_DT_REAGG', SAFE.PARSE_DATE('%Y-%m-%d', pa.param_value_char), NULL)) AS end_dt_reagg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_ADV_WEEK_REAGG', CAST(pa.param_value AS INT64), NULL)) AS start_adv_week_reagg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_ADV_WEEK_REAGG', CAST(pa.param_value AS INT64), NULL)) AS end_adv_week_reagg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CNT_BASELINE_ADV_WEEK', CAST(pa.param_value AS INT64), NULL)) AS cnt_baseline_adv_week,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'LOC_TIME_GAPS_OPENING_DAYS', CAST(pa.param_value AS INT64), NULL)) AS loc_time_gaps_opening_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'LOC_TIME_GAPS_CLOSING_DAYS', CAST(pa.param_value AS INT64), NULL)) AS loc_time_gaps_closing_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS wh_buying_price_add_period_in_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'LOC_STORE_SALES_NET_VAL_GT', CAST(pa.param_value AS NUMERIC), NULL)) AS loc_store_sales_net_val_gt,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'LOC_STORE_SALES_QTY_GT', CAST(pa.param_value AS NUMERIC), NULL)) AS loc_store_sales_qty_gt,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'ADP_TIME_GAP_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS adp_time_gap_in_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CTR_ADV_WEEK_START_WEEKDAY_ID', CAST(pa.param_value AS INT64), NULL)) AS ctr_adv_week_start_weekday_id,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CTR_STORE_NBR', CAST(pa.param_value AS NUMERIC), NULL)) AS ctr_store_nbr,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'CTR_EX_ELVIS_COUNTRY_FG', CAST(pa.param_value AS INT64), 0)) AS ctr_ex_elvis_country_fg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_DT_BASE_METRIC_NF_FA', CAST(pa.param_value AS INT64), NULL)) AS start_dt_base_metric_nf_fa,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_DT_BASE_METRIC_NF_FA', CAST(pa.param_value AS INT64), NULL)) AS end_dt_base_metric_nf_fa,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_DT_DELIV_QTY', CAST(pa.param_value AS INT64), NULL)) AS start_dt_deliv_qty,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_DT_DELIV_QTY', CAST(pa.param_value AS INT64), NULL)) AS end_dt_deliv_qty,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'START_DT_STC_REAL_QTY', CAST(pa.param_value AS INT64), NULL)) AS start_dt_stc_real_qty,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'END_DT_STC_REAL_QTY', CAST(pa.param_value AS INT64), NULL)) AS end_dt_stc_real_qty,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_DAILY_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_daily_run_fg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_WEEKLY_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_weekly_run_fg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_DQ_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_dq_run_fg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_MANUAL_RUN_FG', CAST(pa.param_value AS INT64), -1)) AS exec_pit_manual_run_fg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_MANUAL_COUNTRY_LST', pa.param_value_char, NULL)) AS exec_pit_manual_country_lst,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_RUN_WEEKLY_WEEKDAY', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_run_weekly_weekday,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_CNT_INITIAL_ADV_WEEKS', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_cnt_initial_adv_weeks,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_AB_PARALLEL_EXECUTION', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_ab_parallel_execution,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS exec_pit_sf_credit_timerange_in_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'DEFAULT_PIT_MANUAL_RUN_FG', CAST(pa.param_value AS INT64), NULL)) AS default_pit_manual_run_fg,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'PIT_MAX_DATA_HISTORY_IN_DAYS', CAST(pa.param_value AS INT64), NULL)) AS pit_max_data_history_in_days,
      MAX(IF(UPPER(TRIM(par.param_name)) = 'PIT_MAX_DATA_HISTORY_IN_ADV_WEEK', CAST(pa.param_value AS INT64), NULL)) AS pit_max_data_history_in_adv_week
    FROM ldl_production_p_lew_mart_pit.t_cntl_psnf_processing_param pa
    /* PARAM */
    JOIN (
      SELECT param_id, param_name
      FROM ldl_production_p_lew_mart_pit.t_cntl_dim_processing_param 
      WHERE deleted_fg = 0 AND reject_fg = 0
        -- Deduplication
  QUALIFY row_number() OVER (PARTITION BY PARAM_ID ORDER BY if(DWH_UPDATED_TS IS NULL, 0, 1), DWH_UPDATED_TS DESC) = 1
    ) par /* PARAM REF */
    ON pa.param_id = par.param_id
    WHERE CURRENT_DATE() BETWEEN pa.valid_from_dt AND pa.valid_to_dt
      AND pa.deleted_fg = 0
      AND pa.reject_fg = 0
      AND (pclientid = -1 OR pa.client_id IN (pclientid))
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
      (ppitmanualrunfg = 0 AND exec_pit_manual_run_fg = 0 
      AND exec_pit_run_weekly_weekday = MOD(EXTRACT(DAYOFWEEK FROM CURRENT_DATE()) + 5, 7) + 1)
      OR
      -- Scheduled ReAgg - running on every day based on clients in param Table  
      (ppitmanualrunfg = 3 AND exec_pit_manual_run_fg = 3)
      OR 
      -- Manual test ReAgg Process - triggered by Operator 
      (ppitmanualrunfg = 1 AND exec_pit_manual_run_fg = 1 AND client_id IN (
            SELECT CAST(TRIM(value) AS INT64)
            FROM UNNEST(SPLIT(ppitmanualcountrylist, ',')) AS value
            WHERE value IS NOT NULL AND LENGTH(TRIM(value)) > 0
        ))
      OR 
      -- Initialize Data Process - triggered by Operator 
      (ppitmanualrunfg = 2 AND (pclientid = -1 OR client_id IN (pclientid)) AND (
            pclientid IS NULL OR LENGTH(TRIM(CAST(pclientid AS STRING))) <= 0 OR client_id IN (
              SELECT CAST(TRIM(value) AS INT64)
              FROM UNNEST(SPLIT(ppitmanualcountrylist, ',')) AS value
              WHERE value IS NOT NULL AND LENGTH(TRIM(value)) > 0
            )
          ))
    )
);
