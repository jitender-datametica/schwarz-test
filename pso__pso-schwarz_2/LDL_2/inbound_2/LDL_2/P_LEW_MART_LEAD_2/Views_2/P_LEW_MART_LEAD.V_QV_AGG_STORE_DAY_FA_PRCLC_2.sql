/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_FA_PRCLC_2
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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_QV_AGG_STORE_DAY_FA_PRCLC_2 COMMENT = 'QuickView view : Data is provided by store and day.'
(
  client_id
, client_desc
, account_manager_id
, account_manager_name
, sales_manager_id
, sales_manager_name
, move_to_store_id
, move_store_desc
, wh_id
, wh_desc
, wh_id_exp
, aspect_id
, aspect_desc
, currency_iso_cd
, curr_tot_id
, dat_formdate
, val_retail_net_fa_ejr
, val_retail_net_fa_ejr_py
, val_retail_net_ejr
, val_retail_net_ejr_py
, val_retail_gross_fa_ejr
, val_retail_gross_fa_ejr_py
, val_retail_gross_ejr
, val_retail_gross_ejr_py
, val_pr_diff_gross_fa_del
, val_pr_diff_gross_fa_del_py
, val_pr_diff_net_fa_del
, val_pr_diff_net_fa_del_py
, val_pr_diff_gross_fa_sfo
, val_pr_diff_gross_fa_sfo_py
, val_pr_diff_net_fa_sfo
, val_pr_diff_net_fa_sfo_py
, val_rtl_rl_gro_fa_sfo_asis
, val_rtl_rl_gro_fa_sfo_asis_py
, val_rtl_rl_net_fa_sfo_asis
, val_rtl_rl_net_fa_sfo_asis_py
, val_prdff_rtrn_gro_fa_sfo
, val_prdff_rtrn_gro_fa_sfo_py
, val_prdff_rtrn_net_fa_sfo
, val_prdff_rtrn_net_fa_sfo_py
, val_adj_gro_fa_sfo_store
, val_adj_gro_fa_sfo_store_py
, val_adj_net_fa_sfo_store
, val_adj_net_fa_sfo_store_py
, qty_sales_fa_ejr
, qty_sales_fa_ejr_py
, cnt_day_store
, cnt_day_store_py
)
AS
SELECT
  client_id
, client_desc
, account_manager_id
, account_manager_name
, sales_manager_id
, sales_manager_name
, move_to_store_id
, move_store_desc
, wh_id
, wh_desc
, wh_id_exp
, aspect_id
, aspect_desc
, currency_iso_cd
, curr_tot_id
, dat_formdate
, val_retail_net_fa_ejr
, val_retail_net_fa_ejr_py
, val_retail_net_ejr
, val_retail_net_ejr_py
, val_retail_gross_fa_ejr
, val_retail_gross_fa_ejr_py
, val_retail_gross_ejr
, val_retail_gross_ejr_py
, val_pr_diff_gross_fa_del
, val_pr_diff_gross_fa_del_py
, val_pr_diff_net_fa_del
, val_pr_diff_net_fa_del_py
, val_pr_diff_gross_fa_sfo
, val_pr_diff_gross_fa_sfo_py
, val_pr_diff_net_fa_sfo
, val_pr_diff_net_fa_sfo_py
, val_rtl_rl_gro_fa_sfo_asis
, val_rtl_rl_gro_fa_sfo_asis_py
, val_rtl_rl_net_fa_sfo_asis
, val_rtl_rl_net_fa_sfo_asis_py
, val_prdff_rtrn_gro_fa_sfo
, val_prdff_rtrn_gro_fa_sfo_py
, val_prdff_rtrn_net_fa_sfo
, val_prdff_rtrn_net_fa_sfo_py
, val_adj_gro_fa_sfo_store
, val_adj_gro_fa_sfo_store_py
, val_adj_net_fa_sfo_store
, val_adj_net_fa_sfo_store_py
, qty_sales_fa_ejr
, qty_sales_fa_ejr_py
, cnt_day_store
, cnt_day_store_py
FROM P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_FA_PRCLC_2
;
