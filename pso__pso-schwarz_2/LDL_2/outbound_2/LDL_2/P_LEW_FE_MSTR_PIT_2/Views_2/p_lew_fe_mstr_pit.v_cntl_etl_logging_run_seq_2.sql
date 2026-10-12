/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_CNTL_ETL_LOGGING_RUN_SEQ_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_CNTL_ETL_LOGGING_RUN_SEQ_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-04-18 Nikolai Toknov	   Initial version. Task DDLvsGIT. Created the file based on the object in PROD.
#  1.1  2025-02-04 Nikolai Toknov	   Drop VC columns MULTI_CLIENT_RUN_LST_NR, MULTI_CLIENT_RUN_LST_DESCR, MULTI_CLIENT_RUN_FG, ADV_WEEK_MSTR_ID
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_CNTL_ETL_LOGGING_RUN_SEQ_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_etl_logging_run_seq_2 (run_id_seq, run_ts_char, run_day_id_char,
run_ts, run_day_id, run_clustering_desc, client_id, country_descr, country_iso_cd, curr_cd, multi_client_run_lst,
application_name, start_dt_pit_data, start_adv_week_pit_data, start_dt_pit_day_of_week_iso_id,
start_dt_pit_day_of_week_sdesc, start_dt_pit_day_of_week_ldesc, end_dt_pit_data, end_adv_week_pit_data,
end_dt_pit_day_of_week_iso_id, end_dt_pit_day_of_week_sdesc, end_dt_pit_day_of_week_ldesc, pit_data_date_range_sdesc,
next_run_dt_reagg, cnt_data_history_pit_in_adv_weeks, cnt_data_history_pit_in_days, cnt_intermediate_period_in_adv_weeks
, cnt_intermediate_period_in_days, start_dt_intermediate, end_dt_intermediate, start_adv_week_intermediate,
end_adv_week_intermediate, cnt_reagg_period_in_adv_weeks, cnt_reagg_period_in_days, start_dt_reagg, end_dt_reagg,
start_adv_week_reagg, end_adv_week_reagg, cnt_baseline_adv_week, loc_time_gaps_opening_days, loc_time_gaps_closing_days
, wh_buying_price_add_period_in_days, loc_store_sales_net_val_gt, loc_store_sales_qty_gt, adp_time_gap_in_days,
ctr_adv_week_start_weekday_id, ctr_store_nbr, ctr_ex_elvis_country_fg, start_dt_base_metric_nf_fa,
end_dt_base_metric_nf_fa, start_dt_deliv_qty, end_dt_deliv_qty, start_dt_stc_real_qty, end_dt_stc_real_qty,
exec_pit_daily_run_fg, exec_pit_weekly_run_fg, exec_pit_dq_run_fg, exec_pit_manual_run_fg, exec_pit_manual_country_lst,
exec_pit_run_weekly_weekday, exec_pit_cnt_initial_adv_weeks, exec_pit_ab_parallel_execution,
exec_pit_sf_credit_timerange_in_days, default_pit_manual_run_fg, pit_max_data_history_in_days,
pit_max_data_history_in_adv_week, exec_client_fg, deleted_fg, dwh_created_ts, dwh_updated_ts, load_id,
exec_pit_run_type_descr, moving_run_id_from_current)
OPTIONS(DESCRIPTION = `ACCESS VIEW KONTROLL ETL LOGGING RUNNING SEQUENCE`) AS SELECT LG.run_id_seq,
 FORMAT_DATETIME('%F %H:%M:%E3S', LG.run_ts) AS run_ts_char,
 FORMAT_DATE('%F', LG.run_day_id) AS run_day_id_char,
 LG.run_ts,
 LG.run_day_id,
 LG.run_clustering_desc,
 LG.client_id,
 COALESCE(cl.country_descr, IF(LG.client_id = - 2, 'Alle Länder', 'n/A')) AS country_descr,
 COALESCE(cl.country_iso_cd, IF(LG.client_id = - 2, 'TOT', 'n/A')) AS country_iso_cd,
 COALESCE(cl.curr_cd, 'n/A') AS curr_cd,
 LG.multi_client_run_lst,
 LG.application_name,
 LG.start_dt_pit_data,
 COALESCE(adw_s.adv_week_id, 888853) AS start_adv_week_pit_data,
 CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) AS start_dt_pit_day_of_week_iso_id,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 1
  THEN 'Mo.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 2
  THEN 'Di.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 3
  THEN 'Mi.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 4
  THEN 'Do.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 5
  THEN 'Fr.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 6
  THEN 'Sa.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 7
  THEN 'So.'
  ELSE NULL
  END AS start_dt_pit_day_of_week_sdesc,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 1
  THEN 'Montag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 2
  THEN 'Dienstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 3
  THEN 'Mittwoch'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 4
  THEN 'Donnerstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 5
  THEN 'Freitag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 6
  THEN 'Samstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 7
  THEN 'Sonntag'
  ELSE NULL
  END AS start_dt_pit_day_of_week_ldesc,
 LG.end_dt_pit_data,
 COALESCE(adw_e.adv_week_id, 888853) AS end_adv_week_pit_data,
 CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) AS end_dt_pit_day_of_week_iso_id,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 1
  THEN 'Mo.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 2
  THEN 'Di.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 3
  THEN 'Mi.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 4
  THEN 'Do.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 5
  THEN 'Fr.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 6
  THEN 'Sa.'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 7
  THEN 'So.'
  ELSE NULL
  END AS end_dt_pit_day_of_week_sdesc,
  CASE
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 1
  THEN 'Montag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 2
  THEN 'Dienstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 3
  THEN 'Mittwoch'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 4
  THEN 'Donnerstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 5
  THEN 'Freitag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 6
  THEN 'Samstag'
  WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 7
  THEN 'Sonntag'
  ELSE NULL
  END AS end_dt_pit_day_of_week_ldesc,
    CASE
    WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 1
    THEN 'Mo.'
    WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 2
    THEN 'Di.'
    WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 3
    THEN 'Mi.'
    WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 4
    THEN 'Do.'
    WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 5
    THEN 'Fr.'
    WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 6
    THEN 'Sa.'
    WHEN CAST(FORMAT_DATE('%u', DATE(LG.start_dt_pit_data)) AS INTEGER) = 7
    THEN 'So.'
    ELSE NULL
    END || '-' || CASE
   WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 1
   THEN 'Mo.'
   WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 2
   THEN 'Di.'
   WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 3
   THEN 'Mi.'
   WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 4
   THEN 'Do.'
   WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 5
   THEN 'Fr.'
   WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 6
   THEN 'Sa.'
   WHEN CAST(FORMAT_DATE('%u', DATE(LG.end_dt_pit_data)) AS INTEGER) = 7
   THEN 'So.'
   ELSE NULL
   END AS pit_data_date_range_sdesc,
 LG.next_run_dt_reagg,
 LG.cnt_data_history_pit_in_adv_weeks,
 LG.cnt_data_history_pit_in_days,
 LG.cnt_intermediate_period_in_adv_weeks,
 LG.cnt_intermediate_period_in_days,
 LG.start_dt_intermediate,
 LG.end_dt_intermediate,
 LG.start_adv_week_intermediate,
 LG.end_adv_week_intermediate,
 LG.cnt_reagg_period_in_adv_weeks,
 LG.cnt_reagg_period_in_days,
 LG.start_dt_reagg,
 LG.end_dt_reagg,
 LG.start_adv_week_reagg,
 LG.end_adv_week_reagg,
 LG.cnt_baseline_adv_week,
 LG.loc_time_gaps_opening_days,
 LG.loc_time_gaps_closing_days,
 LG.wh_buying_price_add_period_in_days,
 LG.loc_store_sales_net_val_gt,
 LG.loc_store_sales_qty_gt,
 LG.adp_time_gap_in_days,
 LG.ctr_adv_week_start_weekday_id,
 LG.ctr_store_nbr,
 LG.ctr_ex_elvis_country_fg,
 LG.start_dt_base_metric_nf_fa,
 LG.end_dt_base_metric_nf_fa,
 LG.start_dt_deliv_qty,
 LG.end_dt_deliv_qty,
 LG.start_dt_stc_real_qty,
 LG.end_dt_stc_real_qty,
 LG.exec_pit_daily_run_fg,
 LG.exec_pit_weekly_run_fg,
 LG.exec_pit_dq_run_fg,
 LG.exec_pit_manual_run_fg,
 LG.exec_pit_manual_country_lst,
 LG.exec_pit_run_weekly_weekday,
 LG.exec_pit_cnt_initial_adv_weeks,
 LG.exec_pit_ab_parallel_execution,
 LG.exec_pit_sf_credit_timerange_in_days,
 LG.default_pit_manual_run_fg,
 LG.pit_max_data_history_in_days,
 LG.pit_max_data_history_in_adv_week,
 LG.exec_client_fg,
 LG.deleted_fg,
 LG.dwh_created_ts,
 LG.dwh_updated_ts,
 LG.load_id,
 IF(LG.load_id > 0, 'Reguläre_2 Ausführung', 'Manulle Ausführung') AS exec_pit_run_type_descr,
   ((DENSE_RANK() OVER (ORDER BY LG.run_id_seq IS NULL DESC, LG.run_id_seq DESC)) - 1) * - 1 AS
 moving_run_id_from_current
FROM ldl_p_lew_mart_pit.t_cntl_etl_logging_run_seq_2 AS LG
 LEFT JOIN (SELECT client_id,
   country_descr,
   country_iso_cd,
   curr_cd
  FROM ldl_p_lew_mart_pit.t_dim_client_2
  WHERE deleted_fg = 0
   AND reject_fg = 0
   AND current_fg = 1
   AND pit_country_fg = 1
  QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))) AS cl ON LG.client_id = cl.client_id
 LEFT JOIN (SELECT client_id,
   adv_week_id,
   adv_week_start_dt,
   adv_week_end_dt
  FROM ldl_p_lew_mart_pit.t_dim_adv_week_2
  WHERE deleted_fg = 0
   AND reject_fg = 0) AS adw_s ON LG.client_id = adw_s.client_id AND LG.start_dt_pit_data BETWEEN adw_s.adv_week_start_dt
   AND adw_s.adv_week_end_dt
 LEFT JOIN (SELECT client_id,
   adv_week_id,
   adv_week_start_dt,
   adv_week_end_dt
  FROM ldl_p_lew_mart_pit.t_dim_adv_week_2
  WHERE deleted_fg = 0
   AND reject_fg = 0) AS adw_e ON LG.client_id = adw_e.client_id AND LG.end_dt_pit_data BETWEEN adw_e.adv_week_start_dt
   AND adw_e.adv_week_end_dt
WHERE LG.deleted_fg = 0;