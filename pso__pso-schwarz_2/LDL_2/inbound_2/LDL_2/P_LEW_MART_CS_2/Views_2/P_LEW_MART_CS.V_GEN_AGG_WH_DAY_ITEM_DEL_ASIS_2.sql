/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_WH_DAY_ITEM_DEL_ASIS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_AGG_WH_DAY_ITEM_DEL_ASIS_2
/*************************************************************************************************************
* Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
*************************************************************************************************************/
(
  client_id
, src_wh_id
, item_sid
, dat_formdate
, curr_cd_from
)
AS
   SELECT
   aji.client_id,
   l.src_wh_id,
   itmp.item_sid_map    AS item_sid,
   aji.dat_formdate,
   b.curr_cd_from
   FROM p_lew_bil_ac.v_aji_deliv_wh_day_item_2 AS aji
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS b
   ON b.client_id = aji.client_id
   AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   AND b.deleted_fg = 0
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 AS c
   ON c.client_id = b.client_id
   AND c.x_rate_type_sid = b.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp
   ON itmp.client_id = aji.client_id
   AND itmp.item_sid = aji.item_sid
   LEFT OUTER JOIN p_lew_core_ac.v_location_2 l
   ON l.client_id = aji.client_id
   AND l.loc_sid = aji.loc_sid_wh_asis
;