/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: LidlPlus Application metrics
#            DDL for v_agg_app_store_ldpl_mth_1
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
#                                                   harmo_cal_month_no
#                                                   adjust_growth_fg
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_app_store_ldpl_mth_1 (client_id, cy_month, harmo_cal_month_no
, adjust_growth_fg, org_lvl_id, tm_lvl_id, app_sid, app_name, app_store_sid, app_store_name, country_pol_sid,
cm_download_cnt, pm_download_cnt, pym_download_cnt, cm_total_download_cnt, pm_total_download_cnt, pym_total_download_cnt
, cm_redownload_cnt, pm_redownload_cnt, pym_redownload_cnt, cm_total_redownload_cnt, pm_total_redownload_cnt,
pym_total_redownload_cnt, cm_update_cnt, pm_update_cnt, pym_update_cnt, cm_total_update_cnt, pm_total_update_cnt,
pym_total_update_cnt, cm_uninstall_cnt, pm_uninstall_cnt, pym_uninstall_cnt, cm_total_uninstall_cnt,
pm_total_uninstall_cnt, pym_total_uninstall_cnt, cm_return_cnt, pm_return_cnt, pym_return_cnt, cm_total_return_cnt,
pm_total_return_cnt, pym_total_return_cnt, load_id, dwh_inserted, dwh_updated)
OPTIONS(DESCRIPTION = `LIDLPLUS : TABLE WHICH CONTAINS APPLICATION METRICS ON MONTHLY LEVEL`) AS SELECT client_id,
 cy_month,
 harmo_cal_month_no,
 adjust_growth_fg,
 org_lvl_id,
 tm_lvl_id,
 app_sid,
 app_name,
 app_store_sid,
 app_store_name,
 country_pol_sid,
 cm_download_cnt,
 pm_download_cnt,
 pym_download_cnt,
 cm_total_download_cnt,
 pm_total_download_cnt,
 pym_total_download_cnt,
 cm_redownload_cnt,
 pm_redownload_cnt,
 pym_redownload_cnt,
 cm_total_redownload_cnt,
 pm_total_redownload_cnt,
 pym_total_redownload_cnt,
 cm_update_cnt,
 pm_update_cnt,
 pym_update_cnt,
 cm_total_update_cnt,
 pm_total_update_cnt,
 pym_total_update_cnt,
 cm_uninstall_cnt,
 pm_uninstall_cnt,
 pym_uninstall_cnt,
 cm_total_uninstall_cnt,
 pm_total_uninstall_cnt,
 pym_total_uninstall_cnt,
 cm_return_cnt,
 pm_return_cnt,
 pym_return_cnt,
 cm_total_return_cnt,
 pm_total_return_cnt,
 pym_total_return_cnt,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_app_store_ldpl_mth_1;