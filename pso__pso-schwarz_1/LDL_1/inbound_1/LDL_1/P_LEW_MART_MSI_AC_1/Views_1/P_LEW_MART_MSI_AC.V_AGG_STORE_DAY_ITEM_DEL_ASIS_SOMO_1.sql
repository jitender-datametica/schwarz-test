/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_AGG_STORE_DAY_ITEM_DEL_ASIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_STORE_DAY_ITEM_DEL_ASIS_SOMO_1 (
  CLIENT_ID
, DAT_FORMDATE
, CY_MONTH
, DELIVERYTYPE_ID
, ITEM_ID
, ORIG_STORE_NR
, QTY_TOTAL_DEL_ASIS
, STORE_ID
, CONTAINER_ID
, CONTAINER_HIST_ID
, VAL_RTL_RL_DEL_ASIS
, VAL_RTL_RL_NET_DEL_ASIS
, QTY_PIECE_DEL_ASIS
, VAL_PIECE_DEL_ASIS
, VAL_PIECE_NET_DEL_ASIS
, VAL_PR_DIFF_DEL
, VAL_PR_DIFF_NET_DEL
, QTY_TOTAL_FA_DEL_ASIS
, VAL_RTL_RL_FA_DEL_ASIS
, VAL_RTL_RL_NET_FA_DEL_ASIS
, QTY_PIECE_FA_DEL_ASIS
, VAL_PIECE_FA_DEL_ASIS
, VAL_PIECE_NET_FA_DEL_ASIS
, VAL_PR_DIFF_FA_DEL
, VAL_PR_DIFF_NET_FA_DEL
, CURRENCY_ISO_CD
) AS
   SELECT
  client_id
, dat_formdate
, cy_month
, deliverytype_id
, item_id
, orig_store_nr
, qty_total_del_asis
, store_id
, container_id
, container_hist_id
, val_rtl_rl_del_asis
, val_rtl_rl_net_del_asis
, qty_piece_del_asis
, val_piece_del_asis
, val_piece_net_del_asis
, val_pr_diff_del
, val_pr_diff_net_del
, qty_total_fa_del_asis
, val_rtl_rl_fa_del_asis
, val_rtl_rl_net_fa_del_asis
, qty_piece_fa_del_asis
, val_piece_fa_del_asis
, val_piece_net_fa_del_asis
, val_pr_diff_fa_del
, val_pr_diff_net_fa_del
, currency_iso_cd
  FROM p_lew_mart_msi.v_agg_store_day_item_del_asis_somo_1
;