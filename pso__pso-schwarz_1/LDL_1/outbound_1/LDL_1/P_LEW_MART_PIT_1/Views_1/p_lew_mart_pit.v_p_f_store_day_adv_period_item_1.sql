/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_P_F_STORE_DAY_ADV_PERIOD_ITEM_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_P_F_STORE_DAY_ADV_PERIOD_ITEM_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-11-14 Nikolai Toknov	   Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT_1;
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_p_f_store_day_adv_period_item_1 (client_id, country_iso_cd, country_descr,
day_dt, adv_week_id, item_sid, adv_period_id, orig_item_nr, store_sid, store_name, adv_period_start_day_dt,
sub_item_grp_sid, orig_store_nr, adv_period_end_day_dt, item_grp_int_sid, warehouse_sid, warehouse_name,
reporting_adv_period_start_day_dt, reporting_adv_period_end_day_dt, orig_wh_nr, theme_grp_nat_sid, action_type_id,
theme_grp_int_sid, reject_reason_id, reject_fg, source_system_id, deleted_fg, dwh_created_ts, theme_grp_nat_cat_sid,
dwh_updated_ts, load_id) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 day_dt,
 adv_week_id,
 item_sid,
 adv_period_id,
 orig_item_nr,
 store_sid,
 store_name,
 adv_period_start_day_dt,
 sub_item_grp_sid,
 orig_store_nr,
 adv_period_end_day_dt,
 item_grp_int_sid,
 warehouse_sid,
 warehouse_name,
 reporting_adv_period_start_day_dt,
 reporting_adv_period_end_day_dt,
 orig_wh_nr,
 theme_grp_nat_sid,
 action_type_id,
 theme_grp_int_sid,
 reject_reason_id,
 reject_fg,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 theme_grp_nat_cat_sid,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_p_f_store_day_adv_period_item_1
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 day_dt,
 adv_week_id,
 item_sid,
 adv_period_id,
 orig_item_nr,
 store_sid,
 store_name,
 adv_period_start_day_dt,
 sub_item_grp_sid,
 orig_store_nr,
 adv_period_end_day_dt,
 item_grp_int_sid,
 warehouse_sid,
 warehouse_name,
 reporting_adv_period_start_day_dt,
 reporting_adv_period_end_day_dt,
 orig_wh_nr,
 theme_grp_nat_sid,
 action_type_id,
 theme_grp_int_sid,
 reject_reason_id,
 reject_fg,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 theme_grp_nat_cat_sid,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_p_f_store_day_adv_period_item_adv_lp_pv_1
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 day_dt,
 adv_week_id,
 item_sid,
 adv_period_id,
 orig_item_nr,
 store_sid,
 store_name,
 adv_period_start_day_dt,
 sub_item_grp_sid,
 orig_store_nr,
 adv_period_end_day_dt,
 item_grp_int_sid,
 warehouse_sid,
 warehouse_name,
 reporting_adv_period_start_day_dt,
 reporting_adv_period_end_day_dt,
 orig_wh_nr,
 theme_grp_nat_sid,
 action_type_id,
 theme_grp_int_sid,
 reject_reason_id,
 reject_fg,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 theme_grp_nat_cat_sid,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_p_f_store_day_adv_period_item_adv_wawi_pv_1;