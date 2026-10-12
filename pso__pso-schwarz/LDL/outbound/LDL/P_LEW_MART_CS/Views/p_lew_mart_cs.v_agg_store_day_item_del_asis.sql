/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_agg_store_day_item_del_asis
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_agg_store_day_item_del_asis (client_id, dat_formdate, cy_month,
deliverytype_id, item_id, orig_store_nr, qty_total_del_asis, store_id, val_rtl_rl_del_asis, val_rtl_rl_net_del_asis,
qty_piece_del_asis, val_piece_del_asis, val_piece_net_del_asis, val_pr_diff_del, val_pr_diff_net_del, currency_iso_cd)
AS SELECT client_id,
 dat_formdate,
 cy_month,
 deliverytype_id,
 item_id,
 orig_store_nr,
 qty_total_del_asis,
 store_id,
 val_rtl_rl_del_asis,
 val_rtl_rl_net_del_asis,
 qty_piece_del_asis,
 val_piece_del_asis,
 val_piece_net_del_asis,
 val_pr_diff_del,
 val_pr_diff_net_del,
 currency_iso_cd
FROM ldl_p_lew_mart_msi.v_agg_store_day_item_del_asis;