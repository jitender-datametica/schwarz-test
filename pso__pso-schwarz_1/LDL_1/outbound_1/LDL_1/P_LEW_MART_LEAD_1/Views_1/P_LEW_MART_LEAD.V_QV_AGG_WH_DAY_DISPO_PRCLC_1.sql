/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_DISPO_PRCLC_1
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-06-24 Prasanna Ranjan         20200309_2424_QuickView_remove_dum
#  2.0 2021-04-09 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9207
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_qv_agg_wh_day_dispo_prclc_1 (client_id, client_desc, country_group_id,
country_group_desc, gl_region_id, gl_region_desc, wh_id, wh_desc, aspect_id, aspect_desc, currency_iso_cd, curr_tot_id,
dat_formdate, val_adj_gross_sfo_wh, val_adj_gross_sfo_wh_py, val_adj_net_sfo_wh, val_adj_net_sfo_wh_py,
val_pr_diff_gross_sfo, val_pr_diff_gross_sfo_py, val_pr_diff_net_sfo, val_pr_diff_net_sfo_py, val_retail_gross_asis,
val_retail_gross_asis_py, val_retail_net_asis, val_retail_net_asis_py, cnt_miss_item, cnt_miss_item_py,
cnt_dat_miss_item, cnt_dat_miss_item_py, val_roc_prclc_wh, val_roc_prclc_wh_py, avg_stc_wh, avg_stc_wh_py)
OPTIONS(DESCRIPTION = `QUICKVIEW VIEW : DATA IS PROVIDED BY WH AND DAY.`) AS SELECT client_id,
 client_desc,
 country_group_id,
 country_group_desc,
 gl_region_id,
 gl_region_desc,
 wh_id,
 wh_desc,
 aspect_id,
 aspect_desc,
 currency_iso_cd,
 curr_tot_id,
 dat_formdate,
 val_adj_gross_sfo_wh,
 val_adj_gross_sfo_wh_py,
 val_adj_net_sfo_wh,
 val_adj_net_sfo_wh_py,
 val_pr_diff_gross_sfo,
 val_pr_diff_gross_sfo_py,
 val_pr_diff_net_sfo,
 val_pr_diff_net_sfo_py,
 val_retail_gross_asis,
 val_retail_gross_asis_py,
 val_retail_net_asis,
 val_retail_net_asis_py,
 cnt_miss_item,
 cnt_miss_item_py,
 cnt_dat_miss_item,
 cnt_dat_miss_item_py,
 val_roc_prclc_wh,
 val_roc_prclc_wh_py,
 avg_stc_wh,
 avg_stc_wh_py
FROM ldl_p_lew_mart_lead.t_qv_agg_wh_day_dispo_prclc_1;