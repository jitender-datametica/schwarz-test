/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ADVERTISE_THEME_HIST
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#  1.1  28.02.2023    Aparna   Rayanki            Removed columns cy_week_theme_deliver and cy_week_theme_advertise
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_advertise_theme_hist (client_id, mdm_ad_theme_sid,
cbx_proj_version_nr, cbx_proj_doc_status, cbx_proj_change_tmsp, mdm_range_sel_sid, ad_theme_approval_status,
ad_theme_workflow_status, ad_theme_sell_from_day, ad_theme_sell_from_dt, deleted_fg, dwh_valid_from, dwh_valid_to,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_ad_theme_sid,
 cbx_proj_version_nr,
 cbx_proj_doc_status,
 cbx_proj_change_tmsp,
 mdm_range_sel_sid,
 ad_theme_approval_status,
 ad_theme_workflow_status,
 ad_theme_sell_from_day,
 ad_theme_sell_from_dt,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core_ac.v_mdm_advertise_theme_hist
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;