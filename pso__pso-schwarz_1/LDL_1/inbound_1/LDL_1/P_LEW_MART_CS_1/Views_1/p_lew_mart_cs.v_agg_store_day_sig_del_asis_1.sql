/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_agg_store_day_sig_del_asis_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_cs.v_agg_store_day_sig_del_asis_1 (
  client_id
 ,dat_formdate
 ,deliverytype_id
 ,orig_store_nr
 ,qty_total_del_asis
 ,store_id
 ,subitemgroup_id
 ,val_rtl_rl_del_asis
 ,val_rtl_rl_net_del_asis
 ,qty_piece_del_asis
 ,val_piece_del_asis
 ,val_piece_net_del_asis
 ,val_pr_diff_del_asis
 ,val_pr_diff_net_del_asis
 ,qty_total_fa_del_asis
 ,val_rtl_rl_fa_del_asis
 ,val_rtl_rl_net_fa_del_asis
 ,qty_piece_fa_del_asis
 ,val_piece_fa_del_asis
 ,val_piece_net_fa_del_asis
 ,val_pr_diff_fa_del_asis
 ,val_pr_diff_net_fa_del_asis
 ,currency_iso_cd
) AS
SELECT 
  client_id
 ,dat_formdate
 ,deliverytype_id
 ,orig_store_nr
 ,qty_total_del_asis
 ,store_id
 ,subitemgroup_id
 ,val_rtl_rl_del_asis
 ,val_rtl_rl_net_del_asis
 ,qty_piece_del_asis
 ,val_piece_del_asis
 ,val_piece_net_del_asis
 ,val_pr_diff_del_asis
 ,val_pr_diff_net_del_asis
 ,qty_total_fa_del_asis
 ,val_rtl_rl_fa_del_asis
 ,val_rtl_rl_net_fa_del_asis
 ,qty_piece_fa_del_asis
 ,val_piece_fa_del_asis
 ,val_piece_net_fa_del_asis
 ,val_pr_diff_fa_del_asis
 ,val_pr_diff_net_fa_del_asis
 ,currency_iso_cd
FROM p_lew_mart_msi.v_agg_store_day_sig_del_asis_1
;