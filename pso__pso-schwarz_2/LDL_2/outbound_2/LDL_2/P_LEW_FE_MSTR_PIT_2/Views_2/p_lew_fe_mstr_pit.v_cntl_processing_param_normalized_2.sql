/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_CNTL_PROCESSING_PARAM_NORMALIZED_2
#-------------------------------------------------------------------------------
# Describtion: Create View for Processing Param Normalized
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-15 Andreas Kurz	    Initial version
#  1.1	2023-01-27 Andreas Kurz		Typecast 888853::INTEGER for PIT Start/End DT
#  1.2  2025-02-05 Andreas Kurz		Changed structure and Added new columns for possible cube load restrictions
#										START_ADV_WEEK_ID_CUBE_LOAD
#										END_ADV_WEEK_ID_CUBE_LOAD
#  1.3 2025-09-13 Andreas Kurz		Changes to refere only (ADV_WEEK_ID * 100) + CLIENT_ID 	AS ADV_WEEK_MSTR_ID	
#									and P_LEW_MART_PIT.T_DIM_ADV_WEEK_2
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--Between(Werbewoche@ID,   [Start Adv Week Id Increment Cube Load],[End Adv Week Id Increment Cube Load])
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_processing_param_normalized_2
OPTIONS(DESCRIPTION = `VIEW PROCESSING PARAM NORMALIZE`) AS SELECT PA.client_id,
 cl.country_iso_cd,
 cl.country_descr,
 cl.curr_cd,
 cl.exchange_rate_to_eur,
 PA.start_dt_pit_data,
 COALESCE(adw_s.adv_week_id, 888853) AS start_adv_week_pit_data,
 PA.end_dt_pit_data,
 COALESCE(adw_e.adv_week_id, 888853) AS end_adv_week_pit_data,
  CASE
  WHEN PA.exec_pit_manual_run_fg = 3
  THEN adw_scube.adv_week_id
  ELSE COALESCE(adw_scube.adv_week_id, 888853)
  END AS start_adv_week_id_cube_load,
  CASE
  WHEN PA.exec_pit_manual_run_fg = 3
  THEN adw_scube.adv_week_mstr_id
  ELSE COALESCE(adw_scube.adv_week_mstr_id, 888853 * 100 + PA.client_id)
  END AS start_adv_week_mstr_id_cube_load,
  CASE
  WHEN PA.exec_pit_manual_run_fg = 3
  THEN PA.end_adv_week_intermediate
  ELSE COALESCE(adw_e.adv_week_id, 888853)
  END AS end_adv_week_id_cube_load,
  CASE
  WHEN PA.exec_pit_manual_run_fg = 3
  THEN PA.end_adv_week_intermediate * 100 + PA.client_id
  ELSE COALESCE(adw_e.adv_week_mstr_id, 888853 * 100 + PA.client_id)
  END AS end_adv_week_mstr_id_cube_load,
 PA.next_run_dt_reagg,
 PA.cnt_data_history_pit_in_adv_weeks,
 PA.cnt_data_history_pit_in_days,
 PA.cnt_intermediate_period_in_adv_weeks,
 PA.cnt_intermediate_period_in_days,
 PA.start_dt_intermediate,
 PA.end_dt_intermediate,
 PA.start_adv_week_intermediate,
 PA.end_adv_week_intermediate,
 PA.cnt_reagg_period_in_adv_weeks,
 PA.cnt_reagg_period_in_days,
 PA.start_dt_reagg,
 PA.end_dt_reagg,
 PA.start_adv_week_reagg,
 PA.end_adv_week_reagg,
 PA.cnt_baseline_adv_week,
 PA.loc_time_gaps_opening_days,
 PA.loc_time_gaps_closing_days,
 PA.wh_buying_price_add_period_in_days,
 PA.loc_store_sales_net_val_gt,
 PA.loc_store_sales_qty_gt,
 PA.adp_time_gap_in_days,
 PA.ctr_adv_week_start_weekday_id,
 PA.ctr_store_nbr,
 PA.ctr_ex_elvis_country_fg,
 cl.ctr_ex_elvis_country_migration_date_from,
 cl.ctr_ex_elvis_country_migration_date_to,
 PA.start_dt_base_metric_nf_fa,
 PA.end_dt_base_metric_nf_fa,
 PA.start_dt_deliv_qty,
 PA.end_dt_deliv_qty,
 PA.start_dt_stc_real_qty,
 PA.end_dt_stc_real_qty,
 PA.exec_pit_daily_run_fg,
 PA.exec_pit_weekly_run_fg,
 PA.exec_pit_dq_run_fg,
 PA.exec_pit_manual_run_fg,
 PA.exec_pit_manual_country_lst,
 PA.exec_pit_run_weekly_weekday,
 PA.exec_pit_cnt_initial_adv_weeks,
 PA.exec_pit_ab_parallel_execution,
 PA.exec_pit_sf_credit_timerange_in_days,
 PA.default_pit_manual_run_fg,
 PA.pit_max_data_history_in_days,
 PA.pit_max_data_history_in_adv_week,
 PA.pv_period_length_max,
 PA.pv_period_gap_splitting_days,
 PA.lp_orig_coupon_type_sid,
 PA.lp_coupon_promo_type_sid,
 PA.fa_overlap_period_action_type_condition,
 PA.wawi_price_change_gap_in_days,
 PA.reject_period,
 PA.lp_shift_period_start_dt,
 PA.reject_wawi_pv_long_period
FROM ldl_p_lew_mart_pit.t_cntl_processing_param_normalized_2 AS PA
 INNER JOIN (SELECT client_id,
   country_iso_cd,
   country_descr,
   curr_cd,
   exchange_rate_to_eur,
   ctr_ex_elvis_country_migration_date_from,
   ctr_ex_elvis_country_migration_date_to
  FROM ldl_p_lew_mart_pit.t_dim_client_2
  WHERE deleted_fg = 0
   AND reject_fg = 0
   AND current_fg = 1
   AND pit_country_fg = 1
  QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))) AS cl ON PA.client_id = cl.client_id
 LEFT JOIN (SELECT client_id,
   adv_week_id,
     adv_week_id * 100 + client_id AS adv_week_mstr_id,
   adv_week_start_dt,
   adv_week_end_dt
  FROM ldl_p_lew_mart_pit.t_dim_adv_week_2
  WHERE deleted_fg = 0
   AND reject_fg = 0) AS adw_s ON PA.client_id = adw_s.client_id AND PA.start_dt_pit_data BETWEEN adw_s.adv_week_start_dt
   AND adw_s.adv_week_end_dt
 LEFT JOIN (SELECT client_id,
   adv_week_id,
     adv_week_id * 100 + client_id AS adv_week_mstr_id,
   adv_week_start_dt,
   adv_week_end_dt
  FROM ldl_p_lew_mart_pit.t_dim_adv_week_2
  WHERE deleted_fg = 0
   AND reject_fg = 0) AS adw_e ON PA.client_id = adw_e.client_id AND PA.end_dt_pit_data BETWEEN adw_e.adv_week_start_dt
   AND adw_e.adv_week_end_dt
 LEFT JOIN (SELECT client_id,
   adv_week_id,
     adv_week_id * 100 + client_id AS adv_week_mstr_id,
   adv_week_start_dt,
   adv_week_end_dt
  FROM ldl_p_lew_mart_pit.t_dim_adv_week_2
  WHERE deleted_fg = 0
   AND reject_fg = 0) AS adw_scube ON PA.client_id = adw_scube.client_id AND DATE_ADD(PA.end_dt_pit_data, INTERVAL (PA.pit_max_data_history_in_days
       * - 1) DAY) BETWEEN adw_scube.adv_week_start_dt AND adw_scube.adv_week_end_dt;