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
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_AGG_WH_DAY_ITEM_EJR_ASIS_1
/*************************************************************************************************************
* Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
*************************************************************************************************************/
(
  client_id
, item_sid
, dwh_cal_dt
, wh_id
)
AS
   SELECT
   agg.client_id,
   itmp.item_sid_map AS item_sid,
   agg.dwh_cal_dt   --dat_formdate
   ,
   wh.src_wh_id      AS wh_id
   FROM p_lew_bil_ac.v_agg_pos_wh_day_item_asis_1 AS agg
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON wh.client_id = agg.client_id
   AND wh.loc_sid_wh = agg.loc_sid_wh
   AND wh.dwh_actual_fg = 1
   INNER JOIN p_lew_core_ac.v_item_map_key_1 AS itmp
   ON itmp.client_id = agg.client_id
   AND itmp.item_sid = agg.item_sid

   GROUP BY 1,2,3,4
;