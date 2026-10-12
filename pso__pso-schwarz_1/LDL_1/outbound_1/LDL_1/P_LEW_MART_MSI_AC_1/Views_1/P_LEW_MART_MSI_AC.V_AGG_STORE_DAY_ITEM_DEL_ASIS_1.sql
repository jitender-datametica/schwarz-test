/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_AGG_STORE_DAY_ITEM_DEL_ASIS_1
#----------------------------------------------------------------------------
# History:
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_store_day_item_del_asis_1 (client_id, dat_formdate, cy_month,
deliverytype_id, item_id, orig_store_nr, qty_total_del_asis, store_id, val_rtl_rl_del_asis, val_rtl_rl_net_del_asis,
qty_piece_del_asis, val_piece_del_asis, val_piece_net_del_asis, val_pr_diff_del, val_pr_diff_net_del,
qty_total_fa_del_asis, val_rtl_rl_fa_del_asis, val_rtl_rl_net_fa_del_asis, qty_piece_fa_del_asis, val_piece_fa_del_asis
, val_piece_net_fa_del_asis, val_pr_diff_fa_del, val_pr_diff_net_fa_del, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_store_day_item_del_asis_1;