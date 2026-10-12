/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_SALES_PRCLC_1
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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_QV_AGG_STORE_DAY_SALES_PRCLC_1 COMMENT = 'QuickView view : Data iprovided by store and day.'
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
, val_retail_net_asis
, val_retail_net_asis_py
, cnt_customer_asis
, cnt_customer_asis_py
, val_retail_gross_asis
, val_retail_gross_asis_py
, cnt_customer_adj_asis
, cnt_customer_adj_asis_py
, cnt_customer_adj_asis_ppy
, val_retail_net_adj_asis
, val_retail_net_adj_asis_py
, val_retail_net_adj_asis_ppy
, val_retail_gross_adj_asis
, val_retail_gross_adj_asis_py
, val_retail_gross_adj_asis_ppy
, val_rtl_gro_extrapol_asis
, val_rtl_net_extrapol_asis
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
, val_retail_net_asis
, val_retail_net_asis_py
, cnt_customer_asis
, cnt_customer_asis_py
, val_retail_gross_asis
, val_retail_gross_asis_py
, cnt_customer_adj_asis
, cnt_customer_adj_asis_py
, cnt_customer_adj_asis_ppy
, val_retail_net_adj_asis
, val_retail_net_adj_asis_py
, val_retail_net_adj_asis_ppy
, val_retail_gross_adj_asis
, val_retail_gross_adj_asis_py
, val_retail_gross_adj_asis_ppy
, val_rtl_gro_extrapol_asis
, val_rtl_net_extrapol_asis
FROM P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_SALES_PRCLC_1
;
