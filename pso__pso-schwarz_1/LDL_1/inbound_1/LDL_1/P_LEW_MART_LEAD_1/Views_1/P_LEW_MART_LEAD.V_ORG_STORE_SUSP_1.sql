/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: P_LEW_MART_LEAD.v_org_store_susp_1
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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ORG_STORE_SUSP_1 
COMMENT='Store suspension details'
(
   client_id
 , loc_sid
 , loc_sid_store_move_to
 , orig_store_nr
 , store_desc
 , move_fg
 , aspect_id
 , wh_loc_sid
 , temporary_closing_reason_id 
 , temporary_closing_reason_descr
 , act_closing_from_dt
 , act_closing_to_dt
 , act_reopening_dt
 , planned_closing_from_dt
 , planned_closing_to_dt
 , planned_reopening_dt
 , act_affected_turnover_days_cnt 
 , planned_affected_turnover_days
)
AS
SELECT DISTINCT
   bcp.client_id
 , lbh.loc_sid
 , wosm.move_to_st_loc_sid AS loc_sid_store_move_to
 , wosm.orig_store_nr
 , wosm.store_desc
 , wosm.move_fg
 , wosm.aspect_id
 , wosm.wh_loc_sid
 , bcp.temporary_closing_reason_id 
 , btc.temporary_closing_reason_descr
 , bcp.act_closing_from_dt
 , bcp.act_closing_to_dt
 , bcp.act_reopening_dt
 , bcp.planned_closing_from_dt
 , bcp.planned_closing_to_dt
 , bcp.planned_reopening_dt
 , bcp.act_affected_turnover_days_cnt
 , bcp.planned_affected_turnover_days
FROM P_LEW_CORE_AC.V_BUILDING_CLOSING_PLAN_HIST_1 AS bcp
INNER JOIN P_LEW_CORE_AC.V_LOCATION_BUILDING_HIST_1 AS lbh
 ON bcp.client_id = lbh.client_id
 AND bcp.building_sid = lbh.building_sid
INNER JOIN P_LEW_CORE_AC.V_REF_BUILDING_TEMPORARY_CLOSING_REASON_1 AS btc
 ON bcp.client_id = btc.client_id
 AND bcp.temporary_closing_reason_id = btc.temporary_closing_reason_id
INNER JOIN P_LEW_CORE_AC.V_WAWI_ORG_STORE_MERGE_ACT_1 AS wosm
 ON lbh.client_id = wosm.client_id
 AND lbh.loc_sid = wosm.st_loc_sid
WHERE 
 CURRENT_DATE BETWEEN lbh.dwh_valid_from AND lbh.dwh_valid_to
 AND CURRENT_DATE BETWEEN bcp.dwh_valid_from AND bcp.dwh_valid_to
 AND bcp.deleted_fg = 0
 AND lbh.deleted_fg = 0
 AND wosm.MIS_STORE_ACTIVE_FG = 1
;
