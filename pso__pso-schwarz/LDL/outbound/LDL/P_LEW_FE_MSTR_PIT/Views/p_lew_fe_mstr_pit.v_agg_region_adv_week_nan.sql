/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_REGION_ADV_WEEK_NAN
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_REGION_ADV_WEEK_NAN
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-06-29 K Lukaszewska	Testing cube information added
#  1.2  2023-07-12 Prasanna Ranjan  Added CUBE_PARTITION_KEY
#  1.3  2023-11-02 Andreas Kurz		Added COALESCE(BRAND_NAME,'n/A') AS BRAND_NAME
#  2.0  2024-02-13 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.0  2024-03-25 Nikolai Toknov   add PV_LP_NET_VAL, PV_LP_NET_VAL_SHARE_PCT, PV_PD_NET_VAL, PV_PD_NET_VAL_SHARE_PCT, PV_WAWI_NET_VAL, PV_WAWI_NET_VAL_SHARE_PCT
#  4.1  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.2  2025-02-10 Andreas Kurz		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#  4.3  2025-06-26 Andreas Kurz		Added Weighted AVG KPIs for Vk alt / neu and Billiger in PCT
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_AGG_REGION_ADV_WEEK_NAN');
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_region_adv_week_nan 
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_agg_region_adv_week_nan
OPTIONS(DESCRIPTION = `VIEW DIMENSION AGG_REGION_ADV_WEEK_NAN`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 warehouse_sid,
 warehouse_mstr_sid,
 warehouse_gid,
 warehouse_mstr_gid,
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
 orig_item_gid,
 orig_item_mstr_gid,
 orig_item_nr,
 orig_item_mstr_nr,
 dat_valid_from,
 item_name,
 item_descr,
 item_int_descr,
 item_fam_grp_sid,
 item_fam_grp_src_id,
 item_fam_grp_src_cd,
 item_fam_grp_name,
 item_fam_grp_descr,
 item_fam_grp_int_descr,
 sub_item_grp_gid,
 sub_item_grp_mstr_gid,
 sub_item_grp_sid,
 sub_item_grp_mstr_sid,
 sub_item_grp_src_cd,
 sub_item_grp_name,
 sub_item_grp_descr,
 sub_item_grp_int_descr,
 item_grp_int_gid,
 item_grp_int_mstr_gid,
 item_grp_int_sid,
 item_grp_int_mstr_sid,
 item_grp_int_src_cd,
 item_grp_int_name,
 item_grp_int_descr,
 item_grp_int_int_descr,
 brand_sid,
 COALESCE(brand_name, 'n/A') AS brand_name,
 brand_type_cd,
 buying_list_type_id,
 buying_list_type_descr,
 buying_list_type_int_descr,
 supplier_list_descr,
 action_type_id,
 action_type_sort_val,
 action_type_name,
 action_type_descr,
 sort_order_val,
 add_receipt_cnt,
 add_receipt_per_store_cnt,
 add_turnover_net_val,
 add_turnover_net_per_store_val,
 add_turnover_qty,
 add_turnover_per_store_qty,
 add_turnover_revenue_net_val,
 add_turnover_revenue_net_per_store_val,
 adv_item_cnt,
 adv_item_per_receipt_cnt,
 adv_receipt_adv_turnover_net_val,
 adv_receipt_np_turnover_net_val,
 adv_receipt_total_turnover_net_val,
 base_receipt_cnt,
 base_restbon_turnover_net_val,
 base_turnover_net_val,
 base_turnover_qty,
 base_turnover_revenue_net_val,
 cheaper_max_pct,
 cheaper_min_pct,
 cheaper_range,
 cherry_picker_receipt_cnt,
 cherry_picker_receipt_cnt_pct,
 exclusive_buyer_receipt_cnt,
 exclusive_buyer_receipt_cnt_pct,
 heavy_buyer_receipt_cnt,
 heavy_buyer_receipt_cnt_pct,
 price_buy_net,
 price_retail_new_gross_range,
 price_retail_new_max_gross,
 price_retail_new_min_gross,
 price_retail_old_gross_range,
 price_retail_old_max_gross,
 price_retail_old_min_gross,
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
 pv_receipt_cnt_factor,
 pv_turnover_net_val_factor,
 pv_turnover_qty_factor,
 receipt_cnt,
 receipt_cnt_share_pct,
 receipt_per_store_cnt,
 restbon_effect_pct,
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
 cheaper_weighted_avg_in_pct,
 price_retail_old_weighted_avg_gross,
 price_retail_new_weighted_avg_gross,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id,
 ROW_NUMBER() OVER (PARTITION BY NULL ORDER BY NULL IS NULL, NULL) AS cube_partition_key
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_adv_week_nan AS AGG
WHERE deleted_fg = 0
 AND reject_fg = 0;