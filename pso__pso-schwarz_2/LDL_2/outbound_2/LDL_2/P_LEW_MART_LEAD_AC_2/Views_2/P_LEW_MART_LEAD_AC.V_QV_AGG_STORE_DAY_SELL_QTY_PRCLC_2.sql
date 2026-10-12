/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_QV_AGG_STORE_DAY_SELL_QTY_PRCLC_2
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-08-19 Tris Bayliff            20200309_2424_QuickView_remove_dum
#  2.0 2021-04-09 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9207
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_qv_agg_store_day_sell_qty_prclc_2 (client_id, client_desc,
account_manager_id, account_manager_name, sales_manager_id, sales_manager_name, move_to_store_id, move_store_desc, wh_id
, wh_desc, wh_id_exp, aspect_id, aspect_desc, dat_formdate, wt_hrs_net, wt_hrs_net_py, mt_hrs_net, mt_hrs_net_py,
dwh_load_id, dwh_created, dwh_updated)
OPTIONS(DESCRIPTION = `QUICKVIEW VIEW : VIEW CONTAINS THE BASE DATA FOR THE QUICKVIEW CUBE WARE VERKAUFEN. DATA IS PROVIDED BY STORE AND DAY.`)
AS SELECT *
FROM ldl_p_lew_mart_lead.v_qv_agg_store_day_sell_qty_prclc_2;