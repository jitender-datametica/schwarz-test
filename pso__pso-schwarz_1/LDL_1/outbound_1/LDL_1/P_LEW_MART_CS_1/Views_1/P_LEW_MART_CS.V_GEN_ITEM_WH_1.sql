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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_item_wh_1 (client_id, wh_id, item_sid, item_status_id, dwh_valid_from,
dwh_valid_to, dwh_updated, dwh_created, dwh_load_id) AS SELECT A.client_id,
 F.src_wh_id AS wh_id,
 A.item_sid,
 COALESCE(R.mis_itm_state_id, E.item_status, ROUND(SAFE_CAST(B.item_status_cd AS BIGNUMERIC), 0), 8) AS item_status_id,
 F.dwh_valid_from,
 F.dwh_valid_to,
 A.dwh_updated,
 A.dwh_created,
 A.dwh_load_id
FROM ldl_p_lew_bil_ac.v_item_1 AS A
 INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS B ON A.client_id = B.client_id AND A.item_sid = B.item_sid
      AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to AND B.deleted_fg = 0
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS F ON A.client_id = F.client_id AND B.loc_sid = F.loc_sid_wh AND F.dwh_actual_fg
     = 1 AND F.deleted_fg = 0
 LEFT JOIN ldl_p_lew_core_ac.v_map_mis_item_status_1 AS R ON B.client_id = R.client_id AND B.item_status_cd = R.item_status_cd
   
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS E ON B.client_id = E.client_id AND B.item_sid = E.item_sid AND B.loc_sid
     = E.wh_loc_sid AND CURRENT_DATE BETWEEN E.dat_rec_start AND E.dat_rec_end
WHERE A.dwh_actual_fg = 1;