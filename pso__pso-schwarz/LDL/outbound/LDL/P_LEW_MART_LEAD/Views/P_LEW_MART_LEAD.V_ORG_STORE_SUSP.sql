/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: P_LEW_MART_LEAD.v_org_store_susp
#
#----------------------------------------------------------------------------
# History:
#
#  Vrs    Date          Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0    2021-11-03    Jaroslaw Syrokosz       Initial version
#  1.1    2022-01-03    Jaroslaw Syrokosz       Column name change from 'move_to_st_loc_sid' to 'loc_sid_store_move_to'
#  1.2    2022-03-01    Jaroslaw Syrokosz       Add filter on current_date for BCP table
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_org_store_susp (client_id, loc_sid, loc_sid_store_move_to, orig_store_nr,
store_desc, move_fg, aspect_id, wh_loc_sid, temporary_closing_reason_id, temporary_closing_reason_descr,
act_closing_from_dt, act_closing_to_dt, act_reopening_dt, planned_closing_from_dt, planned_closing_to_dt,
planned_reopening_dt, act_affected_turnover_days_cnt, planned_affected_turnover_days)
OPTIONS(DESCRIPTION = `STORE SUSPENSION DETAILS`) AS SELECT DISTINCT BCP.client_id,
 LBH.loc_sid,
 WOSM.move_to_st_loc_sid AS loc_sid_store_move_to,
 WOSM.orig_store_nr,
 WOSM.store_desc,
 WOSM.move_fg,
 WOSM.aspect_id,
 WOSM.wh_loc_sid,
 BCP.temporary_closing_reason_id,
 BTC.temporary_closing_reason_descr,
 BCP.act_closing_from_dt,
 BCP.act_closing_to_dt,
 BCP.act_reopening_dt,
 BCP.planned_closing_from_dt,
 BCP.planned_closing_to_dt,
 BCP.planned_reopening_dt,
 BCP.act_affected_turnover_days_cnt,
 BCP.planned_affected_turnover_days
FROM ldl_p_lew_core_ac.v_building_closing_plan_hist AS BCP
 INNER JOIN ldl_p_lew_core_ac.v_location_building_hist AS LBH ON BCP.client_id = LBH.client_id AND BCP.building_sid =
   LBH.building_sid
 INNER JOIN ldl_p_lew_core_ac.v_ref_building_temporary_closing_reason AS BTC ON BCP.client_id = BTC.client_id AND BCP.temporary_closing_reason_id
    = BTC.temporary_closing_reason_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act AS WOSM ON LBH.client_id = WOSM.client_id AND LBH.loc_sid =
   WOSM.st_loc_sid
WHERE CURRENT_DATE BETWEEN LBH.dwh_valid_from AND LBH.dwh_valid_to
 AND CURRENT_DATE BETWEEN BCP.dwh_valid_from AND BCP.dwh_valid_to
 AND BCP.deleted_fg = 0
 AND LBH.deleted_fg = 0
 AND WOSM.mis_store_active_fg = 1;