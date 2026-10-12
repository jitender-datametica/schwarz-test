/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: LidlPlus Application metrics
#            DDL for v_agg_app_store_ldpl_wk_2
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-08-11 Barbara Seneta          Initial version - SD-1006
#  1.1 2020-11-26 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column
#                                                   harmo_cal_week_no
#                                                   adjust_growth_fg
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_app_store_ldpl_wk_2 (client_id, cy_week, harmo_cal_week_no,
adjust_growth_fg, org_lvl_id, tm_lvl_id, app_sid, app_name, app_store_sid, app_store_name, country_pol_sid,
cw_download_cnt, pw_download_cnt, pyw_download_cnt, cw_total_download_cnt, pw_total_download_cnt, pyw_total_download_cnt
, cw_redownload_cnt, pw_redownload_cnt, pyw_redownload_cnt, cw_total_redownload_cnt, pw_total_redownload_cnt,
pyw_total_redownload_cnt, cw_update_cnt, pw_update_cnt, pyw_update_cnt, cw_total_update_cnt, pw_total_update_cnt,
pyw_total_update_cnt, cw_uninstall_cnt, pw_uninstall_cnt, pyw_uninstall_cnt, cw_total_uninstall_cnt,
pw_total_uninstall_cnt, pyw_total_uninstall_cnt, cw_return_cnt, pw_return_cnt, pyw_return_cnt, cw_total_return_cnt,
pw_total_return_cnt, pyw_total_return_cnt, load_id, dwh_inserted, dwh_updated)
OPTIONS(DESCRIPTION = `LIDLPLUS : TABLE WHICH CONTAINS APPLICATION METRICS ON WEEKLY LEVEL`) AS SELECT client_id,
 cy_week,
 harmo_cal_week_no,
 adjust_growth_fg,
 org_lvl_id,
 tm_lvl_id,
 app_sid,
 app_name,
 app_store_sid,
 app_store_name,
 country_pol_sid,
 cw_download_cnt,
 pw_download_cnt,
 pyw_download_cnt,
 cw_total_download_cnt,
 pw_total_download_cnt,
 pyw_total_download_cnt,
 cw_redownload_cnt,
 pw_redownload_cnt,
 pyw_redownload_cnt,
 cw_total_redownload_cnt,
 pw_total_redownload_cnt,
 pyw_total_redownload_cnt,
 cw_update_cnt,
 pw_update_cnt,
 pyw_update_cnt,
 cw_total_update_cnt,
 pw_total_update_cnt,
 pyw_total_update_cnt,
 cw_uninstall_cnt,
 pw_uninstall_cnt,
 pyw_uninstall_cnt,
 cw_total_uninstall_cnt,
 pw_total_uninstall_cnt,
 pyw_total_uninstall_cnt,
 cw_return_cnt,
 pw_return_cnt,
 pyw_return_cnt,
 cw_total_return_cnt,
 pw_total_return_cnt,
 pyw_total_return_cnt,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_app_store_ldpl_wk_2;