/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_REGION_PERIOD_ALL
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_REGION_PERIOD_ALL
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-06-29 K Lukaszewska	Testing cube information added
#  1.2  2023-07-12 Prasanna Ranjan  Added CUBE_PARTITION_KEY
#  2.0  2024-02-14 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  2.1	2024-07-19 K Lukaszewska	Added missing columns for PIT Increment 2 (PV)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_1;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_AGG_REGION_PERIOD_ALL_1');
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_region_period_all_1 
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_agg_region_period_all_1
OPTIONS(DESCRIPTION = `VIEW DIMENSION AGG_REGION_PERIOD_ALL`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 warehouse_sid,
 warehouse_mstr_sid,
 warehouse_name,
 orig_wh_nr,
 adv_week_id,
 adv_week_mstr_id,
 nearest_rltd_adv_week_fg,
 adv_week_start_dt,
 adv_week_end_dt,
 adv_week_start_dt_descr,
 adv_week_end_dt_descr,
 adv_week_start_day_sdescr,
 adv_week_end_day_sdescr,
 adv_week_start_day_descr,
 adv_week_end_day_descr,
 length_of_adv_week,
 adv_week_year_id,
 adv_week_week_nr,
 adv_week_sdescr,
 adv_week_descr,
 adv_week_ldescr,
 adv_week_overlap_ldescr,
 prev_1_adv_week_id,
 next_1_adv_week_id,
 prev_1_year_adv_week_id,
 last_adv_week_fg,
 last_closed_adv_week_fg,
 mov_adv_week_start_from_current,
 max_adv_period_end_dt,
 rltd_adv_week_id,
 rltd_adv_week_mstr_id,
 rltd_adv_week_sdescr,
 rltd_adv_week_descr,
 rltd_adv_week_ldescr,
 rltd_adv_week_start_dt,
 rltd_adv_week_end_dt,
 reporting_line_sid,
 reporting_line_descr,
 action_type_id,
 action_type_sort_val,
 action_type_name,
 action_type_descr,
 adv_period_id,
 CAST(adv_period_mstr_id AS STRING) AS adv_period_mstr_id,
 adv_period_start_dt,
 adv_period_end_dt,
 adv_period_start_day_id,
 adv_period_start_dt_descr,
 adv_period_end_dt_descr,
 adv_period_end_day_id,
 adv_period_start_day_sdescr,
 adv_period_end_day_sdescr,
 adv_period_start_day_descr,
 adv_period_end_day_descr,
 adv_period_length_in_days,
 overlap_period_fg,
 overlap_adv_period_start_dt,
 overlap_adv_period_end_dt,
 overlap_adv_week_id,
 adv_period_descr,
 adv_period_ldescr,
 current_adv_period_fg,
 sort_order_val,
 add_receipt_cnt,
 add_receipt_per_store_cnt,
 add_turnover_net_val,
 add_turnover_net_per_store_val,
 add_turnover_revenue_net_val,
 add_turnover_revenue_net_per_store_val,
 adv_item_cnt,
 adv_item_delta_rltd_cnt,
 adv_receipt_adv_turnover_net_val,
 adv_receipt_np_turnover_net_val,
 adv_receipt_total_turnover_net_val,
 base_receipt_cnt,
 base_turnover_net_val,
 base_turnover_revenue_net_val,
 base_turnover_qty,
 cherry_picker_receipt_cnt,
 cherry_picker_receipt_cnt_pct,
 deliv_qty,
 heavy_buyer_receipt_cnt,
 heavy_buyer_receipt_cnt_pct,
 pv_effic_revenue_factor,
 pv_effic_turnover_factor,
 IF(action_type_id > 10, NULL, pv_net_val) AS pv_net_val,
 IF(action_type_id > 10, NULL, pv_net_val_share_pct) AS pv_net_val_share_pct,
 pv_lp_net_val,
 pv_lp_net_val_share_pct,
 pv_npps_net_val,
 pv_npps_net_val_share_pct,
 pv_wawi_net_val,
 pv_wawi_net_val_share_pct,
 receipt_cnt,
 receipt_cnt_share_pct,
 receipt_delta_rltd_cnt,
 receipt_delta_rltd_cnt_pct,
 receipt_per_store_cnt,
 receipt_rltd_cnt,
 restbon_np_turnover_net_val,
 restbon_turnover_net_val,
 restbon_turnover_revenue_net_val,
 store_cnt,
 total_receipt_cnt,
 total_receipt_per_store_cnt,
 total_receipt_rltd_cnt,
 total_turnover_net_val,
 IF(action_type_id > 10, NULL, turnover_1d_pct) AS turnover_1d_pct,
 turnover_1d_qty,
 IF(action_type_id > 10, NULL, turnover_3d_pct) AS turnover_3d_pct,
 turnover_3d_qty,
 IF(action_type_id > 10, NULL, turnover_7d_pct) AS turnover_7d_pct,
 turnover_7d_qty,
 turnover_margin_pct,
 turnover_net_delta_rltd_val,
 turnover_net_delta_rltd_val_pct,
 turnover_net_per_store_val,
 turnover_net_rltd_val,
 turnover_net_val,
 turnover_net_val_share_pct,
 turnover_qty,
 turnover_revenue_net_val,
 turnover_revenue_net_store_val,
 volume_buy_net_val,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id,
 warehouse_gid,
 warehouse_mstr_gid,
 total_store_cnt,
 total_store_rltd_cnt,
 total_store_delta_rltd_cnt,
 total_store_delta_rltd_cnt_pct,
 ROW_NUMBER() OVER (PARTITION BY NULL ORDER BY NULL IS NULL, NULL) AS cube_partition_key
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_period_all_1 AS AGG
WHERE deleted_fg = 0
 AND reject_fg = 0;