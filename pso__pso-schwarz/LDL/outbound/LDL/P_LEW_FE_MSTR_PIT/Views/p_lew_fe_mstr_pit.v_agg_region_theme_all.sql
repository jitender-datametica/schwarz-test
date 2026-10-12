/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_REGION_THEME_ALL
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_REGION_THEME_ALL
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-01-30 Andreas Kurz		Added
#										 ACTION_TYPE_ID
#										 ACTION_TYPE_SORT_VAL
#										 ACTION_TYPE_NAME
#										 ACTION_TYPE_DESCR
#  1.2  2023-06-29 K Lukaszewska	Testing cube information added
#  3.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  3.1  2023-07-28 Nikolai Toknov	Rollback WA
#  3.2  2023-09-12 K Lukaszewska	Category columns added for INT/NAT
#  4.0	2024-02-12 K Lukaszewska	CROSS JOIN to T_DIM_ADV_WEEK_2_ADV_WEEK_PREV for Related Adv Week data
#  4.1  2024-02-14 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.2  2024-03-25 Nikolai Toknov	Chnage table T_DIM_ADV_WEEK_2_ADV_WEEK_PREV to view 
#  4.3	2024-07-19 K Lukaszewska	Added missing columns for PIT Increment 2 (PV)
#  4.4  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S; 

 */

/*
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_region_theme_all
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_agg_region_theme_all
OPTIONS(DESCRIPTION = `VIEW DIMENSION AGG_REGION_THEME_ALL`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 warehouse_sid,
 warehouse_mstr_sid,
 warehouse_name,
 orig_wh_nr,
 adv_week_id,
 adv_week_mstr_id,
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
 reporting_line_sid,
 reporting_line_descr,
 NULL AS rltd_adv_week_id,
 NULL AS rltd_adv_week_mstr_id,
 NULL AS rltd_adv_week_sdescr,
 NULL AS rltd_adv_week_descr,
 NULL AS rltd_adv_week_ldescr,
 - 2000 AS theme_grp_sid,
 CAST(- 2000 * 100 - client_id AS BIGNUMERIC) AS theme_grp_mstr_sid,
 'Gesamt' AS theme_grp_name,
 200000 AS theme_grp_sort_val,
 theme_grp_type_id,
 theme_grp_type_sort_val,
 theme_grp_type_name,
 theme_grp_type_descr,
 theme_grp_int_sid,
 theme_grp_int_mstr_sid,
 theme_grp_int_name,
 theme_grp_int_sort_val,
 theme_grp_nat_sid,
 theme_grp_nat_mstr_sid,
 theme_grp_nat_name,
 theme_grp_nat_sort_val,
 theme_grp_nat_cat_sid,
 theme_grp_nat_cat_mstr_sid,
 theme_grp_nat_cat_name,
 theme_grp_nat_cat_sort_val,
 theme_grp_main_mstr_sid,
 theme_grp_main_name,
 action_type_id,
 action_type_name,
 action_type_descr,
 action_type_sort_val,
 sort_order_val,
 add_turnover_net_val,
 add_turnover_net_per_store_val,
 add_turnover_qty,
 add_turnover_per_store_qty,
 add_turnover_revenue_net_val,
 add_turnover_revenue_net_per_store_val,
 add_receipt_cnt,
 add_receipt_per_store_cnt,
 adv_item_cnt,
 adv_item_fa_cnt,
 adv_item_nf_cnt,
 adv_item_pv_cnt,
 adv_item_pv_lp_cnt,
 adv_item_pv_npps_cnt,
 adv_item_pv_wawi_cnt,
 adv_receipt_adv_turnover_net_val,
 adv_receipt_np_turnover_net_val,
 adv_receipt_total_turnover_net_val,
 base_receipt_cnt,
 base_turnover_net_val,
 base_turnover_revenue_net_val,
 base_turnover_qty,
 cherry_picker_receipt_cnt,
 cherry_picker_receipt_cnt_pct,
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
 receipt_per_store_cnt,
 restbon_np_turnover_net_val,
 restbon_turnover_net_val,
 restbon_turnover_revenue_net_val,
 store_cnt,
 total_receipt_cnt,
 total_turnover_net_val,
 turnover_margin_pct,
 turnover_net_per_store_val,
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
 warehouse_mstr_gid
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_theme_all AS AGG
WHERE deleted_fg = 0
 AND reject_fg = 0;