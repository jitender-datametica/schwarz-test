/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_QV_AGG_WH_DAY_BUY_PRCLC_2
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-06-18 Rodrigo Cione           20200309_2424_QuickView_remove_dum
#  2.0 2021-04-09 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9207
#
#----------------------------------------------------------------------------
*/ 

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_QV_AGG_WH_DAY_BUY_PRCLC_2 COMMENT = 'QuickView view : View contains the base data for the the QuickView cube Ware Einkaufen. Data is provided by wh and day.'
(
  client_id
, client_desc
, country_group_id
, country_group_desc
, gl_region_id
, gl_region_desc
, wh_id
, wh_desc
, aspect_id
, aspect_desc
, currency_iso_cd
, curr_tot_id
, dat_formdate
, val_pr_diff_gross_sfo_asis
, val_pr_diff_gross_sfo_asis_py
, val_pr_diff_net_sfo_asis
, val_pr_diff_net_sfo_asis_py
, val_pr_diff_gross_del_asis
, val_pr_diff_gross_del_asis_py
, val_pr_diff_net_del_asis
, val_pr_diff_net_del_asis_py
, val_pr_adj_gross_sfo_asis
, val_pr_adj_gross_sfo_asis_py
, val_pr_adj_net_sfo_asis
, val_pr_adj_net_sfo_asis_py
, val_retail_gross_asis
, val_retail_gross_asis_py
, val_retail_net_asis
, val_retail_net_asis_py
, val_retail_net_rcv
, val_retail_net_rcv_py
, val_buying_net_rcv
, val_buying_net_rcv_py
)
AS
SELECT
  client_id
, client_desc
, country_group_id
, country_group_desc
, gl_region_id
, gl_region_desc
, wh_id
, wh_desc
, aspect_id
, aspect_desc
, currency_iso_cd
, curr_tot_id
, dat_formdate
, val_pr_diff_gross_sfo_asis
, val_pr_diff_gross_sfo_asis_py
, val_pr_diff_net_sfo_asis
, val_pr_diff_net_sfo_asis_py
, val_pr_diff_gross_del_asis
, val_pr_diff_gross_del_asis_py
, val_pr_diff_net_del_asis
, val_pr_diff_net_del_asis_py
, val_pr_adj_gross_sfo_asis
, val_pr_adj_gross_sfo_asis_py
, val_pr_adj_net_sfo_asis
, val_pr_adj_net_sfo_asis_py
, val_retail_gross_asis
, val_retail_gross_asis_py
, val_retail_net_asis
, val_retail_net_asis_py
, val_retail_net_rcv
, val_retail_net_rcv_py
, val_buying_net_rcv
, val_buying_net_rcv_py
FROM P_LEW_MART_LEAD.V_QV_AGG_WH_DAY_BUY_PRCLC_2
;
