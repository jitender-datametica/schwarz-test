/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_SELL_QTY_PRCLC
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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_qv_agg_wh_day_sell_qty_prclc_1 (client_id, client_desc, country_group_id,
country_group_desc, gl_region_id, gl_region_desc, wh_id, wh_desc, aspect_id, aspect_desc, dat_formdate, wt_hrs_net,
wt_hrs_net_py, mt_hrs_net, mt_hrs_net_py, dwh_load_id, dwh_created, dwh_updated)
OPTIONS(DESCRIPTION = `QUICKVIEW VIEW : VIEW CONTAINS THE BASE DATA FOR THE QUICKVIEW CUBE WARE VERKAUFEN. DATA IS PROVIDED BY WH AND DAY.`)
AS SELECT client_id,
 client_desc,
 country_group_id,
 country_group_desc,
 gl_region_id,
 gl_region_desc,
 wh_id,
 wh_desc,
 aspect_id,
 aspect_desc,
 dat_formdate,
 wt_hrs_net,
 wt_hrs_net_py,
 mt_hrs_net,
 mt_hrs_net_py,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lead.t_qv_agg_wh_day_sell_prclc_1
WHERE curr_tot_id = 0;