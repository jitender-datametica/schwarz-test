/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_WGI_PRCLC_1
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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_QV_AGG_STORE_DAY_WGI_PRCLC_1 COMMENT = 'QuickView view : Data is provided by store and day.'
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
, itemgroup_int_id
, itemgroup_int_desc
, dat_formdate
, val_retail_gross_ejr
, val_retail_gross_ejr_py
, val_retail_gross_total_ejr
, val_retail_gross_total_ejr_py
, val_retail_net_ejr
, val_retail_net_ejr_py
, val_retail_net_total_ejr
, val_retail_net_total_ejr_py
, val_pr_adj_gross_sfo_asis
, val_pr_adj_gross_sfo_asis_py
, val_pr_adj_net_sfo_asis
, val_pr_adj_net_sfo_asis_py
, val_pr_diff_gross_del
, val_pr_diff_gross_del_py
, val_pr_diff_net_del
, val_pr_diff_net_del_py
, val_pr_diff_gross_sfo
, val_pr_diff_gross_sfo_py
, val_pr_diff_net_sfo
, val_pr_diff_net_sfo_py
, val_prdff_rtrn_gro_sfo
, val_prdff_rtrn_gro_sfo_py
, val_prdff_rtrn_net_sfo
, val_prdff_rtrn_net_sfo_py
, val_adj_gross_sfo_store
, val_adj_gross_sfo_store_py
, val_adj_net_sfo_store
, val_adj_net_sfo_store_py
, qty_sales_ejr
, qty_sales_ejr_py
, cnt_day_store
, cnt_day_store_py
, val_retail_net_fa_ejr
, val_retail_net_fa_ejr_py
, val_retail_net_total_fa_ejr
, val_retail_net_total_fa_ejr_py
, val_pr_diff_net_fa_del
, val_pr_diff_net_fa_del_py
, val_pr_diff_net_fa_sfo
, val_pr_diff_net_fa_sfo_py
, val_rtl_rl_net_fa_sfo_asis
, val_rtl_rl_net_fa_sfo_asis_py
, qty_sales_fa_ejr
, qty_sales_fa_ejr_py
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
, itemgroup_int_id
, itemgroup_int_desc
, dat_formdate
, val_retail_gross_ejr
, val_retail_gross_ejr_py
, CASE WHEN val_retail_gross_ejr IS NOT NULL THEN val_retail_gross_total_ejr ELSE NULL END val_retail_gross_total_ejr
, CASE WHEN val_retail_gross_ejr_py IS NOT NULL THEN val_retail_gross_total_ejr_py ELSE NULL END val_retail_gross_total_ejr_py
, val_retail_net_ejr
, val_retail_net_ejr_py
, CASE WHEN val_retail_net_ejr IS NOT NULL THEN val_retail_net_total_ejr ELSE NULL END val_retail_net_total_ejr
, CASE WHEN val_retail_net_ejr_py IS NOT NULL THEN val_retail_net_total_ejr_py ELSE NULL END val_retail_net_total_ejr_py
, val_pr_adj_gross_sfo_asis
, val_pr_adj_gross_sfo_asis_py
, val_pr_adj_net_sfo_asis
, val_pr_adj_net_sfo_asis_py
, val_pr_diff_gross_del
, val_pr_diff_gross_del_py
, val_pr_diff_net_del
, val_pr_diff_net_del_py
, val_pr_diff_gross_sfo
, val_pr_diff_gross_sfo_py
, val_pr_diff_net_sfo
, val_pr_diff_net_sfo_py
, val_prdff_rtrn_gro_sfo
, val_prdff_rtrn_gro_sfo_py
, val_prdff_rtrn_net_sfo
, val_prdff_rtrn_net_sfo_py
, val_adj_gross_sfo_store
, val_adj_gross_sfo_store_py
, val_adj_net_sfo_store
, val_adj_net_sfo_store_py
, qty_sales_ejr
, qty_sales_ejr_py
, CASE WHEN qty_sales_ejr IS NOT NULL THEN cnt_day_store ELSE NULL END cnt_day_store
, CASE WHEN qty_sales_ejr_py IS NOT NULL THEN cnt_day_store_py ELSE NULL END cnt_day_store_py
, val_retail_net_fa_ejr
, val_retail_net_fa_ejr_py
, CASE WHEN val_retail_net_fa_ejr IS NOT NULL THEN val_retail_net_total_fa_ejr ELSE NULL END val_retail_net_total_fa_ejr
, CASE WHEN val_retail_net_fa_ejr_py IS NOT NULL THEN val_retail_net_total_fa_ejr_py ELSE NULL END val_retail_net_total_fa_ejr_py
, val_pr_diff_net_fa_del
, val_pr_diff_net_fa_del_py
, val_pr_diff_net_fa_sfo
, val_pr_diff_net_fa_sfo_py
, val_rtl_rl_net_fa_sfo_asis
, val_rtl_rl_net_fa_sfo_asis_py
, qty_sales_fa_ejr
, qty_sales_fa_ejr_py
FROM P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_WGI_PRCLC_1
;
