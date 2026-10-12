/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_QV_OPEN_STORES_1
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-09-30 Rodrigo Cione           Table added to be used for filtering in FE
#                                         20200930_2603_Add_obj_QV_Dummy_Recs
#  2.0 2021-04-09 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9207
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_qv_open_stores_1 (client_id, move_to_store_id, aspect_id, sales_manager_id
, account_manager_id, wh_id, wh_id_exp, qv_open_store_flag)
OPTIONS(DESCRIPTION = `QUICKVIEW VIEW : OPEN STORES TO USE FOR FILTERING IN FRONT END`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_qv_open_stores_1;