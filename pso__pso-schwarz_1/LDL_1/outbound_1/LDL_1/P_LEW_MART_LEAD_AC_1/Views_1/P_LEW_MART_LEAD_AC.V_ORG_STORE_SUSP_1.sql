/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: P_LEW_MART_LEAD_AC.V_ORG_STORE_SUSP_1
#
#----------------------------------------------------------------------------
# History:
#
#  Vrs    Date          Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0    2021-11-03    Jaroslaw Syrokosz       Initial version
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_org_store_susp_1 (client_id, loc_sid, loc_sid_store_move_to, orig_store_nr
, store_desc, move_fg, aspect_id, wh_loc_sid, temporary_closing_reason_id, temporary_closing_reason_descr,
act_closing_from_dt, act_closing_to_dt, act_reopening_dt, planned_closing_from_dt, planned_closing_to_dt,
planned_reopening_dt, act_affected_turnover_days_cnt, planned_affected_turnover_days)
OPTIONS(DESCRIPTION = `STORE SUSPENSION DETAILS`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_org_store_susp_1;