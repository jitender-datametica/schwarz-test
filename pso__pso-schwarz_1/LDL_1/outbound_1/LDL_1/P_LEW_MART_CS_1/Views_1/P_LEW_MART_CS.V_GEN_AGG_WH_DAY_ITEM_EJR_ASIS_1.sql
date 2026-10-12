/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_WH_DAY_ITEM_EJR_ASIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* * Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
************************************************************************************************************ */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_agg_wh_day_item_ejr_asis_1 (client_id, item_sid, dwh_cal_dt, wh_id) AS
-- dat_formdate
 SELECT AGG.client_id,
 ITMP.item_sid_map AS item_sid,
 AGG.dwh_cal_dt,
 WH.src_wh_id AS wh_id
FROM ldl_p_lew_bil_ac.v_agg_pos_wh_day_item_asis_1 AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON AGG.client_id = WH.client_id AND AGG.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON AGG.client_id = ITMP.client_id AND AGG.item_sid = ITMP.item_sid
GROUP BY AGG.client_id,
 item_sid,
 AGG.dwh_cal_dt,
 wh_id;