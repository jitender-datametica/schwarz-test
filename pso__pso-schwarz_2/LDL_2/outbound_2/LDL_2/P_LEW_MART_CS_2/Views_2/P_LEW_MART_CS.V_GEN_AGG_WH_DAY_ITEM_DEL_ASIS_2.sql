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


/* * Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
************************************************************************************************************ */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_agg_wh_day_item_del_asis_2 (client_id, src_wh_id, item_sid, dat_formdate,
curr_cd_from) AS SELECT AJI.client_id,
 L.src_wh_id,
 ITMP.item_sid_map AS item_sid,
 AJI.dat_formdate,
 B.curr_cd_from
FROM ldl_p_lew_bil_ac.v_aji_deliv_wh_day_item_2 AS AJI
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B ON AJI.client_id = B.client_id AND CURRENT_DATE BETWEEN B
     .active_from_dt AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to AND B.deleted_fg =
   0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON AJI.client_id = ITMP.client_id AND AJI.item_sid = ITMP.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS L ON AJI.client_id = L.client_id AND AJI.loc_sid_wh_asis = L.loc_sid;