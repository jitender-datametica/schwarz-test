/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: LidlPlus Application metrics
#            DDL for v_agg_app_store_ldpl_day_2
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-08-11 Barbara Seneta          Initial version - SD-1006
#  1.1 2020-12-03 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_app_store_ldpl_day_2 (client_id, dwh_cal_dt, harmo_cal_day_no
, adjust_growth_fg, org_lvl_id, tm_lvl_id, app_sid, app_name, app_store_sid, app_store_name, country_pol_sid,
download_cnt, total_download_cnt, redownload_cnt, total_redownload_cnt, update_cnt, total_update_cnt, uninstall_cnt,
total_uninstall_cnt, return_cnt, total_return_cnt, load_id, dwh_inserted, dwh_updated)
OPTIONS(DESCRIPTION = `LIDLPLUS : TABLE WHICH CONTAINS APPLICATION METRICS ON DAILY LEVEL`) AS SELECT client_id,
 dwh_cal_dt,
 harmo_cal_day_no,
 adjust_growth_fg,
 org_lvl_id,
 tm_lvl_id,
 app_sid,
 app_name,
 app_store_sid,
 app_store_name,
 country_pol_sid,
 download_cnt,
 total_download_cnt,
 redownload_cnt,
 total_redownload_cnt,
 update_cnt,
 total_update_cnt,
 uninstall_cnt,
 total_uninstall_cnt,
 return_cnt,
 total_return_cnt,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_app_store_ldpl_day_2;