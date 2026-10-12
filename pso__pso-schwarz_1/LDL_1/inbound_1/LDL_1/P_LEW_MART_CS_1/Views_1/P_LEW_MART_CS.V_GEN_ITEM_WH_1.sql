/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_ITEM_WH_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_ITEM_WH_1
(
client_id
, wh_id
, item_sid
, item_status_id
, dwh_valid_from
, dwh_valid_to
, dwh_updated
, dwh_created
, dwh_load_id

)
AS
   SELECT
   a.client_id,
   a.wh_id,
   a.item_sid,
   a.item_status_id,
   a.dwh_valid_from,
   a.dwh_valid_to,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id
   FROM (SELECT
   a.client_id,
   f.src_wh_id AS wh_id,
   a.item_sid,
   COALESCE(r.mis_itm_state_id, e.item_status, TRY_CAST(b.item_status_cd AS INTEGER),8) AS item_status_id,
   f.dwh_valid_from,
   f.dwh_valid_to,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id
   FROM p_lew_bil_ac.v_item_1 AS a
   INNER JOIN p_lew_core_ac.v_item_info_per_location_hist_1 AS b
   ON b.client_id = a.client_id
   AND b.item_sid = a.item_sid
   AND Current_Date BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   AND b.deleted_fg = 0
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS f
   ON f.client_id=a.client_id
   AND f.loc_sid_wh = b.loc_sid
   AND f.dwh_actual_fg = 1
   AND f.deleted_fg = 0
   LEFT OUTER JOIN p_lew_core_ac.v_map_mis_item_status_1 AS r
   ON r.client_id = b.client_id
   AND r.item_status_cd = b.item_status_cd
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_wh_1 AS e
   ON b.client_id = e.client_id
   AND b.item_sid = e.item_sid
   AND b.loc_sid = e.wh_loc_sid
   AND Current_Date BETWEEN e.dat_rec_start AND e.dat_rec_end

   WHERE  a.dwh_actual_fg = 1
   ) a
;