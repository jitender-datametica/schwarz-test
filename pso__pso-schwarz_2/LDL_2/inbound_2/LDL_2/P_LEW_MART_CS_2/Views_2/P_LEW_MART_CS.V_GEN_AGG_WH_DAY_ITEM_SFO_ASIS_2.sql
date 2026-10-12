/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_WH_DAY_ITEM_SFO_ASIS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_AGG_WH_DAY_ITEM_SFO_ASIS_2
/*************************************************************************************************************
* Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
*************************************************************************************************************/
(
    client_id
  , wh_id
  , item_sid
  , booking_dat
  , currency_iso_cd
  , sfotype_id
  )
AS
   SELECT
   agg.client_id,
   wh.src_wh_id        AS wh_id,
   itmp.item_sid_map   AS item_sid,
   agg.booking_dat,
   agg.curr_cd_from    AS currency_iso_cd,
   agg.sfotype_id
   FROM p_lew_bil_ac.v_agg_wh_day_item_sfo_asis_2 AS agg
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON agg.client_id=wh.client_id
   AND agg.loc_sid_wh=wh.loc_sid_wh
   AND wh.dwh_actual_fg = 1
   INNER JOIN p_lew_core_ac.v_item_map_key_2 AS itmp
   ON itmp.client_id = agg.client_id
   AND itmp.item_sid = agg.item_sid
;